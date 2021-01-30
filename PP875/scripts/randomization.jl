## Julia script to randomize roles in jigsaw dynamic
## Claudia January 2021

people = ["m.b", "t.c", "c.f", "l.f", "a.h", "l.h", "d.j", "m.k.","a.k", "m.s", "j.s.g", "j.s", "b.t", "k.d."]
n = length(people)

## February 5, 12, 19, 26
using Random
s = 0130140
Random.seed!(s);
people = people[randperm(length(people))]
group1 = people[1:Integer(n/2)]
group2 = people[Integer(n/2)+1:n]