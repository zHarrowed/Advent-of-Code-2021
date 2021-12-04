x=$<.read.split"\n\n"
y=x.shift.split ?,
x.map! &:split
y.map{|b|x.map{|c|c.map!{_1 if b!=_1}
abort"#{b.to_i*c.sum(&:to_i)}"if !(0..4).all?{|d|(c[d,5]-[p])[0]&&(c.each_slice(5).map{_1[d]}-[p])[0]}}}