public class Utils {

    public static void validateCPF(List<Account> accounts) {
        for (Account acc : accounts) {
            if (!isCpfValid(acc.CPF__c)) {
                
                throw new UtilsException('Invalid CPF');
            }
            
        }
    }

    public static Boolean isCpfValid(String cpf){

        Integer[] cpfArray = new Integer[9];

        for (Integer i = 0; i < 9; i++) {
            cpfArray[i] = Integer.valueOf(cpf.substring(i, i + 1));
        }


        Integer firstChecksumDigit = calculateChecksumDigit(cpfArray, 10);


        cpfArray.add(firstChecksumDigit);


        Integer secondChecksumDigit = calculateChecksumDigit(cpfArray, 11);


        String result = String.valueOf(firstChecksumDigit) + String.valueOf(secondChecksumDigit);
        System.debug('Calculated CPF: ' + result);

        if(result == cpf.substring(9)){

            return true;
        }else{

            return false;
        }
    }

    private static Integer calculateChecksumDigit(Integer[] cpfArray, Integer multiplier) {
        Integer sum = 0;


        for (Integer i = 0; i < cpfArray.size(); i++) {
            sum += cpfArray[i] * multiplier;
            multiplier--;
        }


        Integer remainder = Math.mod(sum, 11);


        return (remainder < 2) ? 0 : 11 - remainder;
    }

    public class UtilsException extends Exception {}
}