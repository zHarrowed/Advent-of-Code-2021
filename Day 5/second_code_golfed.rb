n=[]
m=->x,y{n[y]||=[];n[y][x]=n[y][x]?1:0}
o=->r,s,t,u,v{r.step(t,r<t ?1:-1){v ?m.(_1,s):m.(s,_1)
s+=s<u ? 1:s!=u ?-1:0}}
$<.map{a,b,c,d=_1.split(/,|->/).map &:to_i
a!=c ?o.(a,b,c,d,p):o.(b,a,d,c,1)}
p (n-[p]).sum{(_1-[p]).sum}