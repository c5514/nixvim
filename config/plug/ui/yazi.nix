{
  plugins.yazi = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>yy";
      action = "<cmd>Yazi<CR>";
      options = {
        desc = "Open Yazi";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>yd";
      action = "<cmd>Yazi cwd<CR>";
      options = {
        desc = "Open Yazi in current directory";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>yr";
      action = "<cmd>Yazi toggle<CR>";
      options = {
        desc = "Resume last Yazi session";
        silent = true;
        noremap = true;
      };
    }
  ];
}
