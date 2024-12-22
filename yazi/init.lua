require("git"):setup()
require("no-status"):setup()
require("starship"):setup {
	config_file = "~/.config/yazi/starship.toml",
}
require("smart-enter"):setup {
	open_multi = true,
}
