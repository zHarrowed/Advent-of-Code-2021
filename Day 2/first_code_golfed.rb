a=b=0
$<.map{c=_1[/\d+/].to_i
_1[/f/]?a+=c:b+=_1[/u/]?-c:c}
p a*b