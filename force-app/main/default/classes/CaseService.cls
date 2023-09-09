public class CaseService {
    
    @AuraEnabled
    public static List<Case> caseGrabber(Integer i){

        return [SELECT Id, CaseNumber, Status, Origin, Type FROM Case LIMIT :i];
    }

}