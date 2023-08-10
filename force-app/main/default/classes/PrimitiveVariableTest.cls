@istest
public class PrimitiveVariableTest {
    
    @istest
    public static void getDecimalTest(){
        test.startTest();
        Decimal decTest = PrimitiveVariables.getDecimal(0.20);
        
        System.assertEquals(0.20, decTest, 'Expected value is not correct.');
        
        
        Decimal decTest2 = PrimitiveVariables.getDecimal(15.0);
        
        System.assertEquals(15.0, decTest2, 'Expected value is not correct.');
        
        
        Decimal decTest3 = PrimitiveVariables.getDecimal(10.0);
        test.stopTest();
        System.assertEquals(10.0, decTest3, 'Expected value is not correct.');
    }
    @istest
    public static void getIntegerTest(){
        test.startTest();
        Integer intTest = PrimitiveVariables.getInteger(24);
        test.stopTest();
        System.assertEquals(34, intTest, 'Expected value is not correct.');
    }
    @istest
    public static void getBooleanTest(){
        test.startTest();
        Integer booIntTest = PrimitiveVariables.getBoolean(true);
        System.assertEquals(0, booIntTest, 'Expected value is not correct.');
        
        Integer booIntTest2 = PrimitiveVariables.getBoolean(false);
        System.assertEquals(1, booIntTest2, 'Expected value is not correct.');
        
        Integer booIntTest3 = PrimitiveVariables.getBoolean(null);
        System.assertEquals(null, booIntTest3, 'Expected value is not correct.');
        test.stopTest();
    }
    
}