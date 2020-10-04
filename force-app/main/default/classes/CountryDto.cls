public class CountryDto {
    @AuraEnabled public String name;
    @AuraEnabled public String capital;
    @AuraEnabled public Integer population;
    @AuraEnabled public List<String> currencyCodes = new List<String>();
    @AuraEnabled public String subregion;
    @AuraEnabled public String flag;

    
    public CountryDto() {
        
    }

    public CountryDto(String name, String capital, Integer population, 
        List<String> currencyCodes, String subregion, String flag) {
        this.name = name;
        this.capital = capital;
        this.population = population;
        this.currencyCodes = currencyCodes;
        this.subregion = subregion;
        this.flag = flag;
    }
}
