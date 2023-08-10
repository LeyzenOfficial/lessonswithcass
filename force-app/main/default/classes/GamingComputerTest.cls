@istest
private class GamingComputerTest {
    @istest
    private static void setMotherBoardModelTest(){

        GamingComputer gc = new GamingComputer('GX2300', 'MG2322', 'SSD');

        System.assertEquals('GX2300', gc.motherBoardModel, 'Motherboard model wrong');

        gc.setMotherBoardModel('GTX4090');

        System.assertEquals('GTX4090', gc.motherBoardModel, 'Motherboard model wrong');

    }
    @istest
    private static void setVideoCardModelTest(){

        GamingComputer gc = new GamingComputer('GX2300', 'MG2322', 'SSD');

        System.assertEquals('MG2322', gc.videoCardModel, 'videocard is wrong');

        gc.setVideoCardModel('opop123');

        System.assertEquals('opop123', gc.videoCardModel, 'videocard is wrong');

    }
    @istest
    private static void setStorageTypeTest(){

        GamingComputer gc = new GamingComputer('GX2300', 'MG2322', 'SSD');

        System.assertEquals('SSD', gc.storageType, 'storage type invalid');

        gc.setStorageType('HD');

        System.assertEquals('HD', gc.storageType, 'storage type invalid');

    }

}