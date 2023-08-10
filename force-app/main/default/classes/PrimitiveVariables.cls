public class PrimitiveVariables {
    
    public static decimal getDecimal(Decimal decNumber){
        
        If(decNumber > 10.0 ){
            
            return decNumber;
            
            
        }else if(decNumber < 10.0){
            
            return decNumber;    
        }
        
        return decNumber;
    }
    
    public static Integer getInteger(Integer intNumber){
        
        Integer intResult = intNumber + 10; 
        
        return intResult;
    }
    
    public static Integer getBoolean(Boolean bolDecision){
        
        if(bolDecision == true ){
            
            Integer intNumber = 0;
            
            return intNumber;
            
        }else if(bolDecision == false){
            
            Integer intNumber2 = 1;
            
            return intNumber2;
        }
        return null;
    }
}