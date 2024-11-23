{ config, ... }:
{
  colorschemes = {
    onedark = {
      enable = true;
      settings = {
        style = "warmer";
        transparent = true;
      };
    };
    # base16 = {
    #   enable = true;
    #   setUpBar = false;
    #   colorscheme = import ../../colors/${config.theme}.nix { };
    #   settings = {
    #     cmp = true;
    #     illuminate = true;
    #     indentblankline = true;
    #     lsp_semantic = true;
    #     mini_completion = true;
    #     telescope = true;
    #     telescope_borders = false;
    #   };
    # };
  };
}
