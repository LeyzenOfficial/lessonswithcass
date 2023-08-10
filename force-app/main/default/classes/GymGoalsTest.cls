@istest
private class GymGoalsTest {
    @istest
    private static void setWeightGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setWeightGoal('50kg');

        System.assertEquals('50kg', gg.weightGoal, 'Weight goal is invalid');
    }
    @istest
    private static void setGymNameTest(){

        GymGoals gg = new GymGoals();

        gg.setGymName('Gold');

        System.assertEquals('Gold', gg.gymName, 'Gym name invalid');
    }
    @istest
    private static void setMuscleGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setMuscleGoal('5kg gain');

        System.assertEquals('5kg gain', gg.muscleGoal, 'Muscle goal invalid');

    }
    @istest
    private static void setmonthsGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setmonthsGoal(12);

        System.assertEquals(12, gg.monthsGoal, 'Months goal invalid');

    }
    @istest
    private static void getWeightGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setWeightGoal('50kg');

        String weightGoal = gg.getWeightGoal();

        System.assertEquals('50kg', weightGoal, 'Didnt get weight');

    }
    @istest
    private static void getGymNameTest(){

        GymGoals gg = new GymGoals();

        gg.setGymName('Golds');

        String gymName = gg.getGymName();

        System.assertEquals('Golds', gymName, 'Didnt get gym name');

    }
    @istest
    private static void getMuscleGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setMuscleGoal('5kg gain');

        String muscleGoal = gg.getMuscleGoal();

        System.assertEquals('5kg gain', muscleGoal, 'Didnt get muscle goal');
    }
    @istest
    private static void getmonthsGoalTest(){

        GymGoals gg = new GymGoals();

        gg.setMonthsGoal(12);

        Integer monthsGoal = gg.getMonthsGoal();

        System.assertEquals(12, monthsGoal, 'Didnt get month goal');

    }

}