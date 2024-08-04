local constants = require(script.Parent.constants)
local vide = require(script.Parent.packages.vide)
local Toolbar = require(script.components.studio.Toolbar)
local ToolbarButtonWidget = require(script.components.studio.ToolbarButtonWidget)
local App = require(script.widgets.App)

local function plugin(plugin: Plugin)
  local toolbar = Toolbar {
    plugin = plugin,
    name = `{constants.PLUGIN_NAME} {constants.VERSION}`
  }

  ToolbarButtonWidget(App {
    plugin = plugin,
    title = constants.PLUGIN_NAME,
    id = constants.PLUGIN_ID,
    defaultSize = Vector2.new(200, 200),
  }) {
    toolbar = toolbar,
    id = "app",
    text = constants.PLUGIN_NAME,
    tooltip = `Click to toggle the {constants.PLUGIN_NAME} window`,
    icon = constants.PLUGIN_ICON_ID,
    active = false
  }

  vide.cleanup(toolbar)
end

return plugin