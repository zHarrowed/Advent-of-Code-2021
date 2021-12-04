x=$<.to_a
a=x[0].chop.chars.map{x.map{_1.slice!0}.count(?1).fdiv($.).round}*""
b=a.to_i(2)
p b*(b^2**a.size-1)