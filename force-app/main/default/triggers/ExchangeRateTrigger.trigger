/**
 * @author ngum buka fon
 * @version 1.0
 * @since   2023-30-01
 */
trigger ExchangeRateTrigger on Exchange_Rates__c (after insert, before update) {
    if(!CheckRecursive.firstcall) {
        if(Trigger.isAfter && Trigger.isInsert){
            ExchangeRateAPIIntegrator.convertCurrency(Trigger.newMap);
        }
        if(Trigger.isBefore && Trigger.isUpdate){
            ExchangeRateAPIIntegrator.convertCurrency(Trigger.newMap);
        }
    }
   
}