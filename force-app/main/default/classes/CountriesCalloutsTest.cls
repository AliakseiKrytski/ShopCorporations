@isTest
private class CountriesCalloutsTest {
    @isTest static void testGetCountriesByCurrencyCallout() { 
        Test.setMock(HttpCalloutMock.class, new CountriesHttpCalloutMock());

        Test.startTest();
        CountryDto[] resultCountries = CountriesCallouts.makeGetCountriesCallout('currency', 'EUR');
        Test.stopTest();
     
        System.assert(resultCountries != null);
        System.assertEquals(1, resultCountries.size());
        System.assertEquals('Estonia', resultCountries.get(0).name);
        System.assertEquals('Tallinn', resultCountries.get(0).capital);
        System.assertEquals(1315944, resultCountries.get(0).population);
        System.assertEquals('Northern Europe', resultCountries.get(0).subregion);
        System.assertEquals(1, resultCountries.get(0).currencyCodes.size());
        System.assertEquals('EUR', resultCountries.get(0).currencyCodes.get(0));
    }
}