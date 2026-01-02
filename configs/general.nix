{ self, ... }:
{
  settings = {
    "breadcrumbs.enabled" = false; # I don't use much,takes up space
    "editor.stickyScroll.maxLineCount" = 2; # Not always very helpful, can take up a lot of space
    "workbench.layoutControl.enabled" = false; # I don't need this, I know the shortcuts
    "chat.mcp.gallery.enabled" = true;
    "cSpell.customDictionaries" = {
      "custom-dictionary-user" = {
        "name" = "custom-dictionary-user";
        "path" = "${self}/assets/.cspell/custom-dictionary-user.txt";
        "addWords" = true;
        "scope" = "user";
      };
    };
    "cSpell.diagnosticLevel" = "Hint";
    "cSpell.dictionaries" = [ "vim" ];
    "cSpell.enabledNotifications" = {
      "Average Word Length too Long" = false;
      "Lines too Long" = false;
      "Maximum Word Length Exceeded" = false;
    };
    "debug.console.fontFamily" = "FiraCode Nerd Font";
    "debug.console.fontSize" = 10;
    "debug.hideLauncherWhileDebugging" = true;
    "workbench.welcomePage.walkthroughs.openOnInstall" = false;
    "workbench.startupEditor" = "readme";
    "debug.internalConsoleOptions" = "openOnSessionStart";
    "debug.showSubSessionsInToolBar" = true;
    "debug.showVariableTypes" = true;
    "diffEditor.wordWrap" = "off";
    "dotenv.enableAutocloaking" = false;
    "editor.acceptSuggestionOnEnter" = "off";
    "editor.accessibilityPageSize" = 11;
    "editor.codeLensFontFamily" = "FiraCode Nerd Font";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.gotoLocation.multipleDefinitions" = "gotoAndPeek";
    "editor.gotoLocation.multipleImplementations" = "gotoAndPeek";
    "editor.gotoLocation.multipleReferences" = "gotoAndPeek";
    "editor.gotoLocation.multipleTypeDefinitions" = "gotoAndPeek";
    "editor.guides.bracketPairs" = true;
    "editor.inlayHints.enabled" = "off";
    "editor.inlayHints.fontFamily" = "FiraCode Nerd Font";
    "editor.inlineSuggest.enabled" = true;
    "editor.largeFileOptimizations" = false;
    "editor.minimap.autohide" = true;
    "editor.minimap.enabled" = false;
    "editor.minimap.renderCharacters" = false;
    "editor.minimap.side" = "left";
    "editor.peekWidgetDefaultFocus" = "editor";
    "editor.unicodeHighlight.ambiguousCharacters" = false;
    "editor.wordWrap" = "bounded";
    "editor.wordWrapColumn" = 100;
    "files.associations" = {
      # Weird errors with opening vscode and it sorting.
      "*.env*" = "dotenv";
      "*.toml.tmpl" = "toml";
      "*Brewfile*" = "ruby";
      ".aliases" = "shellscript";
      ".bashrc" = "shellscript";
      ".envrc" = "shellscript";
      ".zshrc" = "shellscript";
      "flake.lock" = "json"; # I think nix-ide adds this
      ".env*" = "dotenv"; # I think dotenv adds this
      "*.typ" = "typst"; # Sometimes selects Django txt for some reason.
    };
    "files.autoSave" = "afterDelay";
    "files.exclude" = {
      "**/.DS_Store" = true;
      "**/.git" = true;
      "**/.hg" = true;
      "**/.ruby-lsp" = true;
      "**/.svn" = true;
      "**/.trunk/*actions/" = true;
      "**/.trunk/*logs/" = true;
      "**/.trunk/*notifications/" = true;
      "**/.trunk/*out/" = true;
      "**/.trunk/*plugins/" = true;
      "**/CVS" = true;
      "**/Thumbs.db" = true;
    };
    "projectManager.cacheProjectsBetweenSessions" = false;
    "projectManager.confirmSwitchOnActiveWindow" = "always";
    "projectManager.git.baseFolders" = [ "${config.home.homeDirectory}/work/" ];
    "projectManager.sortList" = "Saved";
    "projectManager.tags" = [
      "Personal"
      "Work"
      "Mantis"
      "FlipperZero"
    ];
    # Starship config helps
    "window.commandCenter" = false;
    "window.density.editorTabHeight" = "compact";
    "window.openFilesInNewWindow" = "default";
    "window.title" =
      "🪿 \${separator} 🌳 \${activeRepositoryName} (\${activeRepositoryBranchName}) \${separator} 📁 \${activeEditorMedium}";
    "workbench.activityBar.location" = "top";
    "workbench.editor.customLabels.enabled" = true;
    "workbench.editor.customLabels.patterns" = {
      "**/__init__.py" = "📦 \${dirname}/\${filename}";
      "**/admin.py" = "🔒 \${dirname}/\${filename}";
      "**/apps.py" = "📦 \${dirname}/\${filename}";
      "**/extensions.json" = "🧩 \${dirname}/\${filename}";
      "**/forms.py" = "📝 \${dirname}/\${filename}";
      "**/keybindings.json" = "⌨️ \${dirname}/\${filename}";
      "**/models.py" = "📁 \${dirname}/\${filename}";
      "**/serializers.py" = "👍 \${dirname}/\${filename}";
      "**/settings.json" = "⚙️ \${dirname}/\${filename}";
      "**/snippets/*.json" = "📝 \${dirname}/\${filename}";
      "**/test_*.py" = "🧪 \${filename}";
      "**/tests.py" = "🧪 \${dirname}/\${filename}";
      "**/urls.py" = "🔗 \${dirname}/\${filename}";
      "**/views.py" = "👁️ \${dirname}/\${filename}";
      "*/.vscode/launch.json" = "🚀 \${dirname}/\${filename}";
    };
    "workbench.editor.labelFormat" = "default";
    "workbench.editor.limit.value" = 4;
    "workbench.editorAssociations" = {
      "{git,gitlens}:/**/*.{md,csv,svg}" = "default";
    };
    "workbench.list.smoothScrolling" = true;
    "workbench.panel.opensMaximized" = "never";
    "workbench.panel.showLabels" = false;
    "editor.fontFamily" = "FiraCode Nerd Font";
    "editor.fontLigatures" = true;
  };
}
