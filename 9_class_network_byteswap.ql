import cpp
class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
    // TODO: replace <class> and <var>
    // exists(<class> var1 | 
    exists( MacroInvocation mi |  
        mi.getMacroName() in ["ntohs","ntohl","ntohll"] 
        and this = mi.getExpr()
        // TODO: <condition>
        )
    }   
}
from NetworkByteSwap n
select n, "Network byte swap"


// from NetworkByteSwap n
// select n,"network byte swap"
//1.normal
// from Person t, string c
// where t.getHairColor() = c
// select t
//2. with exist quantifier
//
// from Person t
// where exists(string c | t.getHairColor() = c)
// select t
/*
docs :
https://codeql.github.com/docs/ql-language-reference/types/#classes
class One23 extends int{
    One23(){ //数据集
        this = 1 or this =2 or this =3
    }
    string getAString(){
        result = "One ,Two or Three"+this.toString()
    }
    predicate isEven() {   //条件
        this = 2
    }
}
from One23 o
where o.isEven()
select o,o.getAString()
*/


