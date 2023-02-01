/**
 * @author ngum buka fon
 * @version 1.0
 * @since   2023-31-01
 */
@isTest
public class APIServiceTest {
        @isTest
        public static void getAndSetRatesTest(){         
            Test.setMock(HttpCalloutMock.class, new APIServiceDataMock());
            Exchange_Rates__c newExchangeRate =  new Exchange_Rates__c(Base_Currency__c = 'EUR', Requested_Currency__c = 'GBP'  );
            
            Test.startTest();
                insert newExchangeRate;
            Test.stopTest();

            List<Exchange_Rates__c> newExchangeRateList = [select id, Base_Currency__c, Requested_Currency__c, exchange_rate__c, date__c From Exchange_Rates__c WHERE id=:newExchangeRate.id];
            newExchangeRate = newExchangeRateList[0];
            System.debug(newExchangeRate);
            System.assertEquals(newExchangeRate.date__c, date.valueOf('2023-01-30'));
            System.assertEquals(newExchangeRate.exchange_rate__c, 0.87845);
        }
}