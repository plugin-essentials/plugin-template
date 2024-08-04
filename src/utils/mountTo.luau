local vide = require(script.Parent.Parent.packages.vide)

local function mountTo<A...>(
  component: (A...) -> Instance?,
  instance: unknown,
  ...: A...
)
  local arguments = table.pack(...)
  return vide.mount(function()
    return component(table.unpack(arguments))
  end, instance)
end

return mountTo