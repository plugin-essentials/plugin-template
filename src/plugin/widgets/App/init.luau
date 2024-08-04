local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.packages.vide)
local loop = require(script.Parent.Parent.Parent.utils.loop)
local Text = require(script.Parent.Parent.components.Text)
local Widget = require(script.Parent.Parent.components.studio.Widget)
local theme = require(script.Parent.Parent.theme)

type RainbowTextProps = {
  text: string,
  tick: vide.Source<number>,
  layout: vide.vTextLabel?
}

local function RainbowText(props: RainbowTextProps): TextLabel
  local textHue = vide.source(0)
  local textAngle = vide.source(0)
  local textPosition = vide.source(UDim2.new(.5, 0, .5, 0))

  local textColor = function()
    return Color3.fromHSV(textHue(), 1, 1)
  end

  vide.cleanup(RunService.RenderStepped:Connect(function(delta)
    textHue((textHue() + delta / 10) % 1)
    textAngle(math.sin(props.tick() * 2) * 5)
    textPosition(UDim2.new(
      .5, math.sin(props.tick() * 2) * 20, 
      .5, math.sin(props.tick() * 2) * math.cos(props.tick() * 2) * 20
    ))
  end))

  return Text {
    text = props.text,
    layout = {
      Size = UDim2.fromScale(1, 1),
      AnchorPoint = Vector2.new(.5, .5),
      Position = textPosition,
      TextColor3 = textColor,
      TextXAlignment = Enum.TextXAlignment.Center,
      Rotation = textAngle,
      TextSize = 32,
      props.layout
    }
  }
end

local function App(): Frame
  return vide.create "Frame" {
    Name = "App",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = theme(Enum.StudioStyleGuideColor.MainBackground),

    loop(10, function(i)
      return RainbowText {
        text = "Hello World!",
        tick = function()
          return tick() - i/10
        end,
        layout = {
          TextTransparency = i/10
        }
      }
    end)
  }
end

return Widget(App)