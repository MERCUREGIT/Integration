/**
 * @author ngum buka fon
 * @version 1.0
 * @since   2023-30-01
 */

public without sharing class ExchangeRateAPIIntegrator {
    public static void convertCurrency(Map<Id,Exchange_Rates__c> mapOfValuesToConvert){
            APIService.getAndSetRates(JSON.serialize(mapOfValuesToConvert), 1);
    }
}
