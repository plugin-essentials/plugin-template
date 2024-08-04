local vide = require(script.Parent.Parent.Parent.Parent.packages.vide)
local ToolbarButton = require(script.Parent.ToolbarButton)

export type ToolbarButtonWidgetProps = ToolbarButton.ToolbarButtonProps

local function ToolbarButtonWidget(
  widget: DockWidgetPluginGui
): (props: ToolbarButtonWidgetProps) -> (vide.Source<boolean>, PluginToolbar)
  return function(props)
    local enabled = vide.source(props.active)

    local button = ToolbarButton {
      toolbar = props.toolbar,
      id = props.id,
      text = props.text,
      tooltip = props.tooltip,
      icon = props.icon,
      active = props.active,
      onClick = function()
        enabled(not enabled())      
        if props.onClick then 
          props.onClick()
        end
      end
    }
  
    vide.effect(function()
      widget.Enabled = enabled()
    end)
  
    return enabled, button
  end
end

return ToolbarButtonWidget