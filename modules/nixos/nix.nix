{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      auto-optimise-store = true;
    };
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };
}

