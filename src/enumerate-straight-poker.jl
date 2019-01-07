using Combinatorics
import Base.diff
using Formatting

"""
    adjustAceValues(draw)

If given exactly 2 ace values in a draw, convert the second ace value to 14 to allow for K,A straight
"""
function adjustAceValues(draw :: Array{Int}) :: Array{Int}
    numAces = sum(draw .== 1)
    sort!(draw)
    if (numAces == 2)
        draw[2] = 14
    end
    sort!(draw)
    return draw
end

"""
    isAlmostStraightWrapper(draw)

If the draw is not a straight, consider the possibility that an Ace could also serve as a
[Q],K,A straight.

TODO Could make isAlmostStraight recursive to avoid this separate function
"""
function isAlmostStraightWrapper(draw :: Array{Int}) :: Bool
    decision = isAlmostStraight(draw)
    isAceMask = (draw .== 1)
    if ~decision && (1 in draw) && (sum(isAceMask) == 1)
        draw[isAceMask] .= 14
        decision = isAlmostStraight(draw)
    end
    return decision
end

"""
    isAlmostStraight(draw)

Determine if the draw of cards is an almost straight
"""
function isAlmostStraight(draw :: Array{Int}) :: Bool
    # Define possible almost straight values, where '0' is any step not equal to 1
    validSteps = ([1,0,1,1], [1,1,0,1])

    # Adjust for pairs of aces
    adjustAceValues(draw)
    steps = diff(draw)

    # No chance of being almost straight
    if all(steps .== 1) || sum(steps .> 1) > 1
        return false
    end

    # No pairs of number allowed
    if any(steps .== 0)
        return false
    end

    # Final logic for almost straight
    steps[steps .> 1] .= 0
    if (steps in validSteps)
        return true
    end

    return false

end

## Main Logic
cards = collect(0:51) .% 13 .+ 1
combos = combinations(cards, 5) # Iterator for all possible draws, sorted
total = binomial(52,5) # Total number of possible draws (alternatively, length of above iterator)
out = isAlmostStraightWrapper.(combos)

## Final answer
pAlmostStraight = sum(out)/total
printfmt("The answer is {:.5f}\n", pAlmostStraight)
