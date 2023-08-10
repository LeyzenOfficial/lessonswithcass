public class SObjectController {
    
    public static void accountCreator(String name, String website, String phone) {
        
        Account newAcc = new Account();
        
        newAcc.Name = name;
        newAcc.Website = website;
        newAcc.Phone = phone;
        
        insert newAcc;
        
    }
    
    public static void contactCreator(String lastname, String email, String firstname) {
        
        Contact newCon = new Contact();
        
        newCon.Lastname = lastname;
        newCon.Email = email;
        newCon.FirstName = firstname;
        
        insert newCon;
        
    }
    
    public static void opportunityCreator(String name, String stagename, String OrderNumber, Date testdate) {
        
        Opportunity newOpp = new Opportunity();
        
        newOpp.Name = name;
        newOpp.StageName = stagename;
        newOpp.OrderNumber__c = OrderNumber;
        newOpp.CloseDate = testdate;
        
        
        
        insert newOpp;
        
    }
    
    public static void insertAccounts(Integer i) {
        
        List<Account> accList = new List<Account>();
        
        For(Integer a = 0; a<i; a++){
            
            //Making the accounts without calling another method
            /* Account newAcc = new Account();
			newAcc.Name = 'Making3Accounts ' + a;
			*/
            
            //Calling createAccount method
            Account newAcc = createAccount('MatheusCassioTester' + a);
            
            accList.add(newAcc);
            
            
        }
        insert accList;
        
    }
    
    private static Account createAccount(String accountname){
        
        Account newAcc = new Account();
        newAcc.Name = accountname;
        
        return newAcc;
        
    }   
    //homework
    public static Account createAccountHomework(String accname){
        
       Account newAcc = new Account();
       newAcc.Name = accname;
        
       insert newAcc;
       return newAcc;
        
    }
    
    public static Contact createContactHomework(String conlastname){
        
        Contact newCon = new Contact();
        newCon.Lastname = conlastname;
        
        insert newCon;
        return newCon;
    }
    
    public static Opportunity createOpportunityHomework(String oppname, String stagename, date closedate){
        
        Opportunity newOpp = new Opportunity();
        
        newOpp.Name = oppname;
        newOpp.StageName = stagename;
        newOpp.CloseDate = closedate;
        
        insert newOpp;
        return newOpp;
    }
    //bonus homework
    public static List<Account> createAccountList(){
        
        List<Account> accList = new List<Account>();
        
        For(Integer i = 1; i<6; i++){
            Account newAcc = new Account();
            newAcc.Name = 'CassioBonusHomework' + i;
            
            acclist.add(newAcc);
        }
        return accList;
    }
    
    public static void insertListAccountHomework(){
        
       List<Account> accList = createAccountList();
       
       insert accList;
    }
}