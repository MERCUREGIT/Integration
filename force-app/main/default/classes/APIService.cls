/**
 * @description Handle API calls and update Exchange_rate__c values
 * @author ngum buka fon
 * @version 1.0
 * @since   2023-30-01
 */

public class APIService  {
    @future (callout=true)
    public static void getAndSetRates(string serializedMapOfValuesToConvert, Integer amount){
        Map<Id,Exchange_Rates__c> mapOfValuesToConvert = (Map<Id,Exchange_Rates__c>) JSON.deserializeStrict(serializedMapOfValuesToConvert,Map<Id,Exchange_Rates__c>.class);
        list<Exchange_Rates__c> newExchangeRecordsToCreate = new list<Exchange_Rates__c>();
        for(Exchange_Rates__c instance : mapOfValuesToConvert.values()){
            System.debug(instance);
            HttpRequest req = new HttpRequest();
            string url = 'https://api.apilayer.com/exchangerates_data/convert?to='+instance.Base_Currency__c+'&from='+instance.Requested_Currency__c + '&amount='+ amount;
            req.setEndpoint(url);
            req.setMethod('GET');
            req.setHeader('apiKey', 'tVFk0FFErOrKSXXs11niINVJ5wsQXQgi');
            Http http = new Http();
            HTTPResponse res = http.send(req);
            Object convertedValue =  (Object) JSON.deserializeUntyped(res.getBody());
            Map<string,Object> parsedConvertedValue = (Map<string,Object>) convertedValue;
            Map<string,Object> parsedInfo = (Map<String,Object>) parsedConvertedValue.get('info');
            instance.exchange_rate__c = decimal.valueOf(String.valueOf(parsedInfo.get('rate')));
            instance.date__c = date.valueOf(String.valueOf(parsedConvertedValue.get('date')));
            newExchangeRecordsToCreate.add(instance);
        }
        CheckRecursive.firstcall = true;
        update newExchangeRecordsToCreate;
    }
}