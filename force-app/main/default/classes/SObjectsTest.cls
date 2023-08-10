@istest
public class SObjectsTest {
    
    // @istest
    // public static void setFieldTripTest(){
        
    //     FieldTrip.setCity();

    //     FieldTrip ft = new FieldTrip();

    //     ft.setCity('Boca');

    //     System.assertEquals('Boca', Null, 'msg');
        
    // }
}


























//     @istest
//     public static void updateAccountTest(){
        
//         List<account> queryTest = new List<account>();
        
//         For(Integer i = 0; i<80; i++){
            
//             account newAcc = new account();
//             newAcc.name = 'Matt123' + i;
            
//             insert newAcc;
//             queryTest.add(newAcc);
//         }
//         test.startTest();
//         SObjects.updateBulkAccounts(queryTest);
//         test.stopTest();
//     }
//     @istest
//     public static void updateConTest(){

//         List<Contact> conList = new List<Contact>();

//         For(Integer i = 0; i<10; i++){

//             Contact newCon = new Contact();
//             newCon.Lastname = 'Orsi' + i;

            
//             conList.add(newCon);
//         }
        
//         insert conList;
        
//         test.startTest();
//         SObjects.updateContacts(conList);
//         test.stopTest();

//         System.assertEquals(10, conList.size(), 'yoo this is ur error');
//     }
//     @istest
//     public static void oppCreatorTest(){
//         test.startTest();
//         SObjects.oppCreator('OppTesterName','Prospecting', System.today());
//         test.stopTest();

//         List<opportunity> oppQuery = [SELECT ID, name, StageName FROM opportunity];

//         System.assertEquals(1, oppQuery.size(), 'idk about this one');
//         System.assertEquals('Prospecting', oppQuery[0].StageName, 'msghere123');
//     }
//     @istest
//     public static void returnAccNamesTest(){

//         List<Account> accList = new List<Account>();

//         For(Integer i = 0; i<25; i++){

//             account newAcc = new account();
//             newAcc.name = 'noob123' + i;

//             accList.add(newAcc);
//         }

//         insert accList;

//         test.startTest();
//         List<String> accTest = SObjects.returnAccNames(accList);
//         test.stopTest();

//         System.assertEquals(25, accTest.size(), 'test message');
//     }