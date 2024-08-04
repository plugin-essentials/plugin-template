local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)
local theme = require(script.Parent.Parent.theme)

export type TextProps = {
  text: types.SourcedAs<string>,
  layout: vide.vTextLabel?
}

local function Text(props: TextProps): TextLabel
  return vide.create "TextLabel" {
    Name = "Text",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 0),
    AutomaticSize = Enum.AutomaticSize.XY,

    Text = props.text,
    RichText = true,
    TextColor3 = theme(Enum.StudioStyleGuideColor.MainText),
    TextSize = 16,
    FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextWrapped = true,

    props.layout
  }
end

return Text