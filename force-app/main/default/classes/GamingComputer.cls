public with sharing class GamingComputer {
    
    public String motherBoardModel;
    public String videoCardModel;
    public String storageType;

    public GamingComputer(String motherboardModel, String videocardModel, String storageType){
        
        this.motherBoardModel = motherboardModel;
        this.videocardModel = videocardModel;
        this.storageType = storageType;

    }

    public void setMotherBoardModel(String motherboardModel){
        this.motherBoardModel = motherboardModel;
    }

    public void setVideoCardModel(String videocardModel){
        this.videoCardModel = videocardModel;
    }

    public void setStorageType(String storageType){
        this.storageType = storageType;
    }
}

/*
GamingComputer gc = new GamingComputer();

gc.setMotherBoardModel('M2330');
gc.setVideoCardModel('GTX4080');
gc.setStorageType('SSD');

System.debug(gc.motherBoardModel);
System.debug(gc.storageType);
System.debug(gc.videoCardModel);
*/