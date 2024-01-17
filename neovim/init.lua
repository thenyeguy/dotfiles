require("keymap")
require("options")
require("windowing")
require("lazy").setup("plugins", {
    change_detection = { notify = false },
    ui = { border = "rounded" },
})
