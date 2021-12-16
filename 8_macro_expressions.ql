import cpp
from MacroInvocation mi 
where mi.getMacroName() in ["ntohs","ntohl","ntohll"] 
// step-8.1
select mi.getExpr() 