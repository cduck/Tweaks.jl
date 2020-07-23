module Tweaks

export get_weight


# Submodules
include("BiMaps.jl")

# Tweaks
include("GraphUtil.jl")
import .GraphUtil: get_weight
include("BaseTweaks.jl"); using .BaseTweaks
include("PyCallTweaks.jl"); using .PyCallTweaks


end
