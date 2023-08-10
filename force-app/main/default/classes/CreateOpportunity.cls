public class CreateOpportunity {

    List<Account> accList;
    Map<Id, Account> accMap;

    public CreateOpportunity(List<Account> accList, Map<Id, Account> accMap){
        this.accList = accList;
        this.accMap = accMap;
    }

    public CreateOpportunity(List<Account> accList){
        this.accList = accList;
    }


    public void createOpp(){

        List<Opportunity> oppList = new List<Opportunity>();


        for(Account newAcc : accList){

            String industry = accMap?.get(newAcc.Id).Industry;

            if(industry == 'Agriculture'){
                continue;
            }

            if(newAcc.Industry == 'Agriculture'){

                Opportunity newOpp = new Opportunity();

                newOpp.name = 'LessonOppName';
                newOpp.StageName = 'Prospecting';
                newOpp.CloseDate = System.today();
                newOpp.AccountId = newAcc.Id;

                oppList.add(newOpp);
            }         
        }
        if(oppList.size() > 0){
            insert oppList;
        }
    }
}