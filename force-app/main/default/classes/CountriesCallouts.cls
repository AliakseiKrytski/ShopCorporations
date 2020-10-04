public with sharing class CountriesCallouts {
    private static final Map<String, String> ENDPOINTS_MAP;
    static {
        ENDPOINTS_MAP = loadCountryServiceEndpointMap();
    }


    @AuraEnabled
    public static CountryDto[] makeGetCountriesCallout(String searchBy, String searchText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINTS_MAP.get(searchBy) + EncodingUtil.urlEncode(searchText, 'UTF-8'));
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return convertJsonToCountryDtoList(response.getBody());
        } else if (response.getStatusCode() == 404) {
            return new List<CountryDto>();
        } else {
            throw new System.CalloutException('Request failed with status code ' + response.getStatusCode() + ': ' + response.getStatus());
        }
    }


    private static List<CountryDto> convertJsonToCountryDtoList(String countryDtoListJson) {
        List<CountryDto> countries = new List<CountryDto>();
        List<Object> resultList = (List<Object>) JSON.deserializeUntyped(countryDtoListJson);

        for (Object resultListItem : resultList) {
            Map<String, Object> countryFieldsMap = (Map<String, Object>) resultListItem;
            CountryDto countryDto = new CountryDto();
            countryDto.name = (String) countryFieldsMap.get('name');
            countryDto.capital = (String) countryFieldsMap.get('capital');
            countryDto.population = (Integer) countryFieldsMap.get('population');
            countryDto.subregion = (String) countryFieldsMap.get('subregion');
            countryDto.flag = (String) countryFieldsMap.get('flag');
            List<Object> currencies = (List<Object>) countryFieldsMap.get('currencies');
            for (Object currencyItem : currencies) {
                Map<String, Object> currencyFieldsMap = (Map<String, Object>) currencyItem;
                countryDto.currencyCodes.add((String)currencyFieldsMap.get('code'));
            }
            countries.add(countryDto);
        }
        return countries;
    }


    private static Map<String, String> loadCountryServiceEndpointMap() {
        Countries_Service_Endpoint__mdt[] endpoints = [SELECT DeveloperName, Endpoint_URL__c 
                                                        FROM Countries_Service_Endpoint__mdt];
        Map<String, String> endpointsMap = new Map<String, String>();
        for (Countries_Service_Endpoint__mdt endpoint : endpoints) {
            endpointsMap.put(endpoint.DeveloperName, endpoint.Endpoint_URL__c);
        }
        return endpointsMap;
    }
}
