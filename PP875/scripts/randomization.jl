## Julia script to randomize roles in jigsaw dynamic
## Claudia January 2021

## February 5, 12, 19, 26
people = ["m.b", "t.c", "c.f", "l.f", "a.h", "l.h", "d.j", "m.k.","a.k", "m.s", "j.s.g", "j.s", "b.t", "k.d."]
s = 0130140

## March 5, 12, 19, 26
people = ["austin","ben","charlotte","dana", "grant", "jose", "kymi", "lauren","lillian", "max", "melody", "yurin"]
s = 02262021954

## April 9, 16, 23, 30
people = ["austin","ben","charlotte","dana", "grant", "jose", "kymi", "lauren","lillian", "max", "melody", "yurin"]
s = 032620211225

using Random
n = length(people)
Random.seed!(s);
people = people[randperm(length(people))]
group1 = people[1:Integer(n/2)]
group2 = people[Integer(n/2)+1:n]