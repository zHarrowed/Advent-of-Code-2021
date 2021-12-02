a=b=c=0
$<.map{d=_1[/\d+/].to_i
_1[/f/]?(a+=d;b+=c*d):c+=_1[/u/]?-d:d}
p a*b