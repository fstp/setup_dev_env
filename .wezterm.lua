-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.wsl_domains = {
  {
    -- The name of this specific domain.  Must be unique amonst all types
    -- of domain in the configuration file.
    name = 'WSL:Ubuntu',

    -- The name of the distribution.  This identifies the WSL distribution.
    -- It must match a valid distribution from your `wsl -l -v` output in
    -- order for the domain to be useful.
    distribution = 'Ubuntu',
  },
}

config.default_domain = 'WSL:Ubuntu'
config.font = wezterm.font 'Hack Nerd Font Mono'
--config.font = wezterm.font 'Terminess Nerd Font'
--config.font = wezterm.font 'Ubuntu Nerd Font'

config.max_fps = 120

-- For example, changing the color scheme:
--config.color_scheme = 'Adventure'
config.color_scheme = 'Adventure Time (Gogh)'

-- and finally, return the configuration to wezterm
return config
