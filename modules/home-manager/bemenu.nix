{config,lib,...}:
{
  programs.bemenu = {
    enable = true;
    settings =
    {
      line-height = lib.mkDefault 28;
      prompt = "run";
      ignorecase = true;
      list=10;
      cw = 2;
      ch = 22;
      fb = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
      tb = lib.mkForce "${config.lib.stylix.colors.withHashtag.base09}";
      tf = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
      ff = lib.mkForce "${config.lib.stylix.colors.withHashtag.base04}";
      nb = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
      ab = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
      hb = lib.mkForce "${config.lib.stylix.colors.withHashtag.base09}";
      hf = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
    };
  };
}
