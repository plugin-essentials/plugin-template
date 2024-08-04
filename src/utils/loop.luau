local function loop<T>(amount: number, fn: (i: number) -> (T)): {T}
  local items: {T} = {}
  for i = 1, amount do
    table.insert(items, fn(i))
  end
  return items
end

return loop