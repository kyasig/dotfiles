{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;
      cursorcolumn = true;
      confirm = true;
      smartindent = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      ignorecase = true;
      smartcase = true;
      showmode = true;
      hlsearch = true;
      wildmenu = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    autoCmd = [
      {
        event = "BufWritePre";
        pattern = "*";
        command = "silent! %s/\\s\\+$//e";
      }
      {
        event = "InsertEnter";
        pattern = "*";
        command = "norm zz";
      }
    ];
    plugins = {
      autoclose.enable = true;
      vimtex = {
        enable = true;
        texlivePackage = null;
        settings = {
          compiler_method = "latexmk";
          view_method = "zathura";
        };
      };
    };
  };
}
