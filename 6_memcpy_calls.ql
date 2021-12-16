
import cpp
from Function f, FunctionCall fc
where f.getName()="memcpy" and fc.getTarget() = f
select fc,"function calls named  memcpy"