@IsTest
private class UserServiceTest {
    @IsTest
    private static void addAdminToPublicGroupTest(){

        Id systemAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        Group pg = [SELECT Id, Name FROM Group WHERE Name = 'Admins'];
        
        User userExample = new User();
        userExample.Username = 'leyzen2323@2323test.com';
        userExample.FirstName = 'First';
        userExample.LastName = 'Last';
        userExample.Alias = 'Alias';
        userExample.Email = 'emailtest@test.com';
        userExample.TimeZoneSidKey = 'America/New_York';
        userExample.LocaleSidKey = 'en_US';
        userExample.EmailEncodingKey = 'ISO-8859-1';
        userExample.ProfileId = systemAdminProfileId;
        userExample.LanguageLocaleKey = 'en_US';

        insert userExample;


        String userId = userExample.Id; // Replace with the User ID you want to check
        String groupId = pg.Id; // Replace with the Public Group ID you want to check

        List<GroupMember> groupMembers = [SELECT Id, UserOrGroupId, GroupId FROM GroupMember WHERE UserOrGroupId = :userId AND GroupId = :groupId];

        System.assertEquals(false, groupMembers.isEmpty(), 'The group shouldnt be empty!');
    }

    @IsTest
    private static void addDeleteAdminUserGroupTest(){

        Id standarduserProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        Id systemAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        Group pg = [SELECT Id, Name FROM Group WHERE Name = 'Admins'];

        User userExample = new User();
        userExample.Username = 'leyzen2323@2323test.com';
        userExample.FirstName = 'First';
        userExample.LastName = 'Last';
        userExample.Alias = 'Alias';
        userExample.Email = 'emailtest@test.com';
        userExample.TimeZoneSidKey = 'America/New_York';
        userExample.LocaleSidKey = 'en_US';
        userExample.EmailEncodingKey = 'ISO-8859-1';
        userExample.ProfileId = standarduserProfileId;
        userExample.LanguageLocaleKey = 'en_US';

        insert userExample;

        userExample.ProfileId = systemAdminProfileId;

        update userExample;

        String userId = userExample.Id; // Replace with the User ID you want to check
        String groupId = pg.Id; // Replace with the Public Group ID you want to check

        List<GroupMember> groupMembers = [SELECT Id, UserOrGroupId, GroupId FROM GroupMember WHERE UserOrGroupId = :userId AND GroupId = :groupId];

        
        System.assertEquals(False, groupMembers.isEmpty(), 'The group shouldnt be empty!');
    }
}