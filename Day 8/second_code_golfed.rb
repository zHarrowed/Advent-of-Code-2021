p $<.sum{a,b=_1.split"|"
b.split.map{|d|[42,17,34,39,30,37,41,25,49,45].index d.chars.sum{|e|a.chars.tally[e]}}.join.to_i}