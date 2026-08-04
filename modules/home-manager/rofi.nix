{ config, pkgs, lib,... }:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun";
      display-drun = "Spawn ";
    };
    location = "center";
    plugins = with pkgs; [
      rofimoji
      rofi-power-menu
    ];
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        window = {
          border = 2;
          padding = 2;
        };
        element = {
          border = mkLiteral "0";
          padding = mkLiteral "2px";
          orientation = mkLiteral "horizontal";
          children = mkLiteral "[element-icon ,element-text ]";
          spacing = mkLiteral "5px";
        };

        inputbar = {
          spacing = mkLiteral "0";
          padding = mkLiteral "2px";
        };
        prompt = {
          margin = mkLiteral "2px";
        };

        entry = {
          padding = mkLiteral "2px";
        };

        textbox-prompt-sep = {
          expand = false;
          str = mkLiteral ''":"'';
          margin = mkLiteral "0 0.3em 0 0";
        };
      };
    terminal = "${pkgs.kitty}/bin/kitty";
  };

}
