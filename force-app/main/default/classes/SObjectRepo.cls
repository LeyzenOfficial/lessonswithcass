public class SObjectRepo {
    
    public static List<Account> getAccounts(String identity){
        
        String testString = '%' + identity + '%';
        
        return [SELECT Id, name FROM Account WHERE name like :testString];       
    }
    
    public static List<Contact> getContacts(String identity){
        
        String testString = '%' + identity + '%';
        
        return [SELECT Id, name FROM Contact WHERE account.name like :testString];
    }
    
    public static List<opportunity> getOpportunity(Decimal revenue){
        
        return [SELECT Id, name, amount FROM Opportunity Where amount > :revenue ];
    }
    
    public static Map<id, account> getMapAccounts(){
        
        Account newAcc = new Account();
        newAcc.name = 'MapAccTester';
        
        insert newAcc;
        
        map<id, account> newMap = new map<id, account>();
        
        newMap.put(newAcc.id, newAcc);
        
        return newMap;
        
        
    }
    
    public static void delAccountNotification(List<Account> triggerList){
        
        For(Account acc2: triggerList){
            acc2.addError('You cannot delete this account!');
        }
    }
    
    public static void createDoubleOpps(List<Account> triggerList){
        
        List<Opportunity> oppList = New List<Opportunity>();
        
        For(Account acc: triggerList){
            
            
            For(Integer i = 0; i<2; i++){
                
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name + i;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today();
                
                opp.AccountId = acc.id;
                oppList.add(opp);
                
            }
            
        }
        Insert oppList;
        
    }
    
    public static void createAccountCreationNotification(List<Account> triggerList){
        
        For(Account acc3: triggerList){
            
            Set<String> recipientsIds = new Set<String>();
            
            recipientsIds.add(acc3.Ownerid);
            
            // Get the Id for our custom notification type
            CustomNotificationType notificationType = 
                [SELECT Id, DeveloperName 
                 FROM CustomNotificationType 
                 WHERE DeveloperName='Notificationtest'];
            
            // Create a new custom notification
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            
            // Set the contents for the notification
            notification.setTitle('bada bing bada boom');
            notification.setBody('im the body mutha fucka');
            
            // Set the notification type and target
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(acc3.id);
            
            // Actually send the notification
            try {
                notification.send(recipientsIds);
            }
            catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getMessage());
            }
        }
        
    }
}