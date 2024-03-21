{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      font.size = 14;
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.75;
        blur = false;
      };
    };
  };
}
