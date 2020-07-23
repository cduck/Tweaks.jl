module Tweaks


# Submodules
include("BiMaps.jl")
include("GraphUtil.jl")
include("Time.jl")

# Tweaks
include("BaseTweaks.jl"); using .BaseTweaks
include("PyCallTweaks.jl"); using .PyCallTweaks


end
