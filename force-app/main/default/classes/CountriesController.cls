public with sharing class CountriesController {
    @AuraEnabled(cacheable=true)
    public static CountryDto[] searchCountries(String searchBy, String searchText){
        return CountriesCallouts.makeGetCountriesCallout(searchBy, searchText);
    }
}
