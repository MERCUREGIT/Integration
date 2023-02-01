/**
 * @author ngum buka fon nyuydze
 * @since 2023-31-01
 * @version 1.0
 * @description Mocks the http call for the exchange data
 */
@isTest
public class APIServiceDataMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"date": "2023-01-30","info": {"rate": 0.87845,"timestamp": 1675105983},"query": {"amount": 28,    "from": "EUR","to": "GBP"},"result": 24.5966,"success": true}');
        res.setStatusCode(200);
        return res;
    }
}