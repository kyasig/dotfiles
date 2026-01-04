{
  pkgs,
  inputs,
  system,
  ...
}:
{
  programs.librewolf = {
    enable = true;
    profiles.ky = {
      extensions.packages = with inputs.firefox-addons.packages."${system}"; [
        bitwarden
        tridactyl
      ];
      search.default = "google";
      isDefault = true;
    };
  };
}
