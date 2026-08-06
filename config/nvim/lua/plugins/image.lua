require("image").setup({
  backend = "sixel", -- 或 "ueberzug" / "sixel"
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        only_render_image_at_cursor = false,
    },
  },
})
