public class VariableController {
    
    public static List<String> debugStringVariable(String stri, String stri2, String stri3){
        
        List<String> stringList = new List<String>();
        
        stringList.add(stri);
        stringList.add(stri2);
        stringList.add(stri3);
        
        List<String> result = stringList;
        
        
        Return result;
        
    }

    public static String debugStringVariable(String stri, String stri2){
        
        String result = stri + ' ' + stri2;
        
        Return result;
        
    }
    
    /*
    String one = 'Hello my name is';
	String two = 'Matt';

	System.debug(VariableController.debugStringVariable(one, two));
    */
    
    public static Integer debugIntegerVariable(Integer inte, Integer inte2){
        
        Integer result = Inte * Inte2;
        
        return result;
    }
    
    /*
	Integer one = 23;
	Integer two = 2;

	System.debug(VariableController.debugIntegerVariable(one, two));
    */   
    
    public static Decimal debugDecimalVariable(Decimal dece, Decimal dece2){
        
        Decimal result = dece / dece2;
        
        Return result;
    }
    
    /*
    Decimal one = 2.3;
	Decimal two = 3.0;

	System.debug(VariableController.debugDecimalVariable(one, two));
    */
    
    Public static void debugBooleanVariable(Boolean bool){
        System.debug(bool);
    }
    
}