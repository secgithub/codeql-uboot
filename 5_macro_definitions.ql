import cpp
from Macro m 
// where m.getName() = "ntohs" or m.getName() = "ntohl" or m.getName() = "ntohl"
where m.getName() in ["ntohs","ntohl","ntohll"]
select m,"macro definitions "
