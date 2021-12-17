import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
    // TODO: replace <class> and <var>
    // exists(<class> var1 | 
    exists( MacroInvocation mi |  mi.getMacroName() in ["ntohs","ntohl","ntohll"]
        and this = mi.getExpr()
    )
    }
}
class Config extends TaintTracking::Configuration{
    Config(){
        this = "NetworkToMemFuncLength"
    }
    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetworkByteSwap
    }
    override predicate isSink(DataFlow::Node sink) {
        // sink.asExpr().(FunctionCall).getTarget().getName() = "memcpy"
        //call.getArgument(2) 可能是通过这样判断有3个参数？
        exists(FunctionCall call | sink.asExpr() = call.getArgument(2) and
        call.getTarget().getName() = "memcpy")
        // sink.asExpr().(FunctionCall).getNumberOfArguments()=3
    }
}
from Config cfg ,DataFlow::PathNode source,DataFlow::PathNode sink
where cfg.hasFlowPath(source,sink)
select sink,source,sink,"Network byte swap flows to memcpy"