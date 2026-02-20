require("keymap")
require("options")
require("windowing")
require("yank")
require("lazy").setup("plugins", {
    change_detection = { notify = false },
    ui = { border = "rounded" },
})
