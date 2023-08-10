public class UserService {
    
    public static void addAdminToPublicGroup(List<User> users){

        
        User[] user = [SELECT Id, IsActive, Profile.Name FROM User WHERE Id IN :users];
        List<GroupMember> GMlist = new List<GroupMember>();

        for(User u : user){

            if(u.Profile.Name == 'System Administrator' && u.IsActive){
                
                Group pg = [SELECT Id, Name FROM Group WHERE Name = 'Admins'];

                GroupMember GM = new GroupMember();
                GM.GroupId = pg.Id;
                GM.UserOrGroupId = U.Id;
                GMlist.add(GM);
            }
        }
        insert GMlist;
    }

    public static void addDeleteAdminUserGroup(List<User> users, Map<id, User> oldUsers){

        User[] user = [SELECT Id, IsActive, Profile.Name FROM User WHERE Id IN :users];
        List<GroupMember> gmList = new List<GroupMember>();
        Set<Id> userIds = new Set<Id>();
        Group pg = [SELECT Id, Name FROM Group WHERE Name = 'Admins'];
        
        for(User u : user){

            if(u.profile.Name == oldUsers.get(u.id).profile.Name){ continue; }

            if(u.profile.Name == 'System Administrator' && u.IsActive){

                GroupMember GM = new GroupMember();
                GM.GroupId = pg.Id;
                GM.UserOrGroupId = U.Id;
                GMlist.add(GM);


            }else if(u.profile.Name != 'System Administrator' || !u.IsActive){ 
                userIds.add(u.Id);
             }
        }

        List<GroupMember> groupMembers = [SELECT Id, UserOrGroupId, GroupId FROM GroupMember WHERE UserOrGroupId IN :userIds AND GroupId = :pg.Id];

        if(!GMlist.IsEmpty()){
            insert GMlist;
        }

        if(!groupMembers.IsEmpty()){
            delete groupMembers;
        }
    }
}