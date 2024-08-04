local vide = require(script.Parent.Parent.Parent.Parent.packages.vide)
local cleanup = require(script.Parent.Parent.Parent.Parent.utils.cleanup)
local mountTo = require(script.Parent.Parent.Parent.Parent.utils.mountTo)

type WidgetProps = {
  plugin: Plugin,
  id: string,
  title: string,
  initialState: Enum.InitialDockState?,
  enabled: boolean?,
  overrideState: boolean?,
  defaultSize: Vector2,
  minimumSize: Vector2?,
  onClose: () -> ()?,
}

local function widget<A...>(
  component: (A...) -> Instance
): (props: WidgetProps, A...) -> DockWidgetPluginGui
  return function(props, ...)
    local enabled = vide.source(props.enabled or false)

    local widgetInfo = DockWidgetPluginGuiInfo.new(
      props.initialState or Enum.InitialDockState.Float,
      enabled(),
      props.overrideState or false,
      props.defaultSize.X,
      props.defaultSize.Y,
      (props.minimumSize or props.defaultSize).X,
      (props.minimumSize or props.defaultSize).Y
    )

    local widget = props.plugin:CreateDockWidgetPluginGui(props.id, widgetInfo)
    widget.Title = props.title

    if props.onClose then 
      widget:BindToClose(function()
        enabled(false)
        props.onClose()
      end) 
    end

    mountTo(component, widget, ...)

    cleanup(widget)

    return widget
  end
end

return widget