public with sharing class CountriesController {
    @AuraEnabled
    public static CountryDto[] searchCountries(String searchBy, String searchText){
        return CountriesCallouts.makeGetCountriesCallout(searchBy, searchText);
    }
}
