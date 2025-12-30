{ pkgs, lib, ... }:
let
  # Auto-import all extension modules from subdirectories
  extensionDirs =
    let
      entries = builtins.readDir ./.;
    in
    builtins.filter (name:
      entries.${name} == "directory" && (builtins.readDir ./${name}) ? "default.nix"
    ) (builtins.attrNames entries);

  # Import each extension module
  extensionModules = map (dir: import ./${dir} { inherit pkgs; }) extensionDirs;

  # Merge all extensions into a single list
  allExtensions = builtins.concatLists (map (mod: mod.extensions) extensionModules);

  # Merge all settings
  allSettings = builtins.foldl' (acc: mod: acc // mod.settings) { } extensionModules;

  # Export dracula color palette from the dracula-theme module if it exists
  draculaPalette =
    let
      draculaMod = builtins.filter (mod: mod ? dracula) extensionModules;
    in
    if draculaMod != [ ] then (builtins.head draculaMod).dracula else { };
    
in
{
  extensions = allExtensions;
  settings = allSettings;
  dracula = draculaPalette;
}
