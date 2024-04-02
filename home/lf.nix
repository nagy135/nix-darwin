{ pkgs, ... }: {
  programs.lf = {
    enable = true;
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        		''${{
        			printf "Directory Name: "
        				read DIR
        				mkdir $DIR
        		}}
        				'';
    };
    keybindings = {

      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      "g~" = "cd";
      gh = "cd";
      "gd" = "cd ~/Downloads";
      "gv" = "cd ~/Videos";

      ee = "editor-open";
      V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
  };
}
