module Tweaks


# Submodules
include("BiMaps.jl")
include("GraphUtil.jl")
include("Time.jl")
include("Plot.jl")

# Tweaks
include("BaseTweaks.jl"); using .BaseTweaks
include("PyCallTweaks.jl"); using .PyCallTweaks


end
