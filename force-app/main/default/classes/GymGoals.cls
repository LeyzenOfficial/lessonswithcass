public with sharing class GymGoals {
    
    public String weightGoal;
    public String gymName;
    public String muscleGoal;
    public Integer monthsGoal;

    public void setWeightGoal(String weightGoal){
        this.weightGoal = weightGoal;
    }

    public void setGymName(String gymName){
        this.gymName = gymName;
    }

    public void setMuscleGoal(String muscleGoal){
        this.muscleGoal = muscleGoal;
    }

    public void setMonthsGoal(Integer monthsGoal){
        this.monthsGoal = monthsGoal;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////

    public String getWeightGoal(){
        return weightGoal;
    }

    public String getGymName(){
        return gymName;
    }

    public String getMuscleGoal(){
        return muscleGoal;
    }

    public Integer getMonthsGoal(){
        return monthsGoal;
    }
}


// GymGoals gg = new GymGoals();

// gg.setGymName('Golds Gym');
// gg.setWeightGoal('85kg');
// gg.setMuscleGoal('5kg gain');
// gg.SetmonthsGoal(3);

// System.debug(gg.gymName);
// System.debug(gg.weightGoal);
// System.debug(gg.muscleGoal);
// System.debug(gg.monthsGoal);
