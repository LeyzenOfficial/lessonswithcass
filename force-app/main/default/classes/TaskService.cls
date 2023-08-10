public class TaskService {
    @AuraEnabled
    public static List<Task> taskGrabber(Integer i){

        return [SELECT Id, Subject, WhoId FROM Task LIMIT :i];

    }

}