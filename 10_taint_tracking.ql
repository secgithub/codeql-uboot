import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
class NetworkByteSwap extends Expr{

}
class Config extends TaintTracking::Configuration{
    Config(){
        this = "NetworkToMemFuncLength"
    }
    override predicate isSource(DataFlow::Node source) {
        exists( MacroInvocation mi  
            | mi.getMacroName() in  ["ntohs","ntohl","ntohll"] 
            and source.asExpr() = mi.getExpr()
            )
    }
    override predicate isSink(DataFlow::Node sink) {
        exists (Function memcp |
            sink.asExpr().(FunctionCall).getTarget() = memcp and
            memcp.hasQualifiedName("memcpy")
          )
    }
}
from Config cfg ,DataFlow::PathNode source,DataFlow::PathNode sink
where cfg.hasFlowPath(source,sink)
select sink,source,sink,"Network byte swap flows to memcpy"