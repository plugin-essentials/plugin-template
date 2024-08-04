local vide = require(script.Parent.Parent.Parent.Parent.packages.vide)

export type ToolbarButtonProps = {
  toolbar: PluginToolbar,
  id: string,
  text: string?,
  tooltip: string,
  icon: string,
  active: boolean,
  onClick: () -> ()?
}

local function ToolbarButton(props: ToolbarButtonProps): PluginToolbarButton
  local button = props.toolbar:CreateButton(props.id, props.tooltip, props.icon, props.text)

  if props.onClick then
    vide.cleanup(button.Click:Connect(props.onClick))
  end

  vide.effect(function()
    button:SetActive(props.active)
  end)
  vide.cleanup(button)

  return button
end

return ToolbarButton