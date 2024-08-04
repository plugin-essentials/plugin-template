local vide = require(script.Parent.packages.vide)

export type SourcedAs<T> = T | vide.Source<T>
export type Component = SourcedAs<Instance>
export type Components = SourcedAs<{Instance}>

return nil