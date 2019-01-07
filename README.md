This Julia script brute-forces every possibility for the Brilliant problem described below. It essentially considers every combination of 5 cards that can be drawn from a 52 card deck, and determines how many of these are *almost-straights*.

This is my first Julia scripting attempt but hopefully not my last. The language is fun and the syntax is pretty intuitive to work with.

## Problem Statement
The problem is described in Brilliant as below:

> Let an *almost-straight* be a 5-card combination of cards from a poker deck in which two of the cards are consecutive ranks, the other 3 cards are consecutive ranks, but the two cards are not consecutive with the three cards.

> If five cards are drawn from a shuffled poker deck, what is the probability of drawing an *almost-straight*?

> **Note**: An Ace card can count as the highest ranked card or the lowest ranked card, but it cannot count as both. However, there are *almost-straights* that are possible with two Aces; e.g.

> A, 2, 3, K, A

> However, no other pairs are allowed in *almost-straights*.

The mathematical answer provided is (provided in the way you would type it in google math):

((87 * (4 ^ 5)) + (2 * (4^3) * (4 choose 2))) / (52 choose 5)
