a=[0]*9
$<.read.split(?,).map{a[_1.to_i]+=1}
256.times{a[8]=a.shift
a[6]+=a[8]}
p a.sum