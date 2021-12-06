a=$<.read
b=(0..8).map{a.count"#{_1}"}
256.times{b[(_1+7)%9]+=b[_1%9]}
p b.sum