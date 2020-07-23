module Time

export @time2


macro time2(expr)
    eexpr = esc(expr)
    quote
        @time $eexpr
        @time $eexpr
    end
end


end
