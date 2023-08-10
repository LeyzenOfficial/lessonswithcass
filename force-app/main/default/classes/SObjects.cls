public class SObjects {

    public static void createAccount(){

        account newAcc = new account();
        newAcc.name = 'sobjects';

        insert newAcc;
    }

    public static void updateBulkAccounts(List<Account> accList){

        For(Account loopAcc: accList){
            
            loopAcc.website = 'www.runescape.com';
            Update accList;    
        } 
    } 

    public static List<Contact> updateContacts(List<Contact> conList){

        For(Contact loopCon: conList){

            loopCon.email = 'matt.orsi@hotmail.com';   
        }
        Update conList;
        return conList;

    }

    public static void oppCreator(String oppName, String stageName, Date closeDate){

        Opportunity newOpp = new Opportunity();
        newOpp.Name = oppName;
        newOpp.StageName = stageName;
        newOpp.CloseDate = closeDate;

        insert newOpp;
    }

    public static List<string> returnAccNames(List<account> accList){

        List<string> accNames = new List<string>();

        For(account accLoop: accList){

            accNames.add(accLoop.Name);
        }

        return accNames;
    }
}