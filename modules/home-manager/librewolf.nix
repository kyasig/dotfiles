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
      search.default = "google";
      isDefault = true;
    };
    policies = {
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/"
          "https://addons.mozilla.org/firefox/downloads/latest/darkreader/"
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/"
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/"
          "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/"
        ];
      };
    };
    settings = {
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
    };
  };
  stylix.targets.librewolf.profileNames = [ "ky" ];
}
