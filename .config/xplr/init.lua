version = '0.20.0'

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

-- XPLR Config

xplr.config.general.enable_mouse=true
xplr.config.general.show_hidden=true


-- Plugins
require("tri-pane").setup()
require("icons").setup()
