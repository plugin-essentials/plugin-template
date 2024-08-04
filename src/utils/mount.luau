local mountTo = require(script.Parent.mountTo)

local function mount<A...>(component: (A...) -> Instance?, ...: A...)
  return mountTo(component, nil, ...)
end

return mount