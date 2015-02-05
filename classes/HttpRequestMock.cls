@isTest
public class HttpRequestMock implements HttpCalloutMock {
    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Map<String, String> responseHeaders;

    public HttpRequestMock(Integer code, String status, String body,
                                         Map<String, String> responseHeaders) {
      this.code = code;
      this.status = status;
      this.bodyAsString = body;
      this.responseHeaders = responseHeaders;
    }

    public HTTPResponse respond(HTTPRequest req) {
      HttpResponse resp = new HttpResponse();
      resp.setStatusCode(code);
      resp.setStatus(status);
      String json = '{\"message\":\"Your request to get brand emails was executed successfully.\",\"success\":true,\"errors\":null,\"warnings\":[],\"request_timestamp\":\"03-02-2015 13:32:26\",\"response_timestamp\":\"03-02-2015 13:32:26\",\"request_id\":\"311301-150203-133226-450622\",\"replication_lag\":1,\"export_period\":{\"start_date_time\":\"31-01-2015 06:00:00\",\"end_date_time\":\"31-01-2015 12:00:00\"},\"brand\":{\"brand_id\":27286},\"branch\":[{\"branch_id\":104375,\"emails\":[{\"email_id\":105717300,\"from_address\":\"suephillips769@btinternet.com\",\"to_address\":\"sales@strata.co.uk\",\"email_date\":\"31-01-2015 11:35:12\",\"email_types\":[6,3],\"user\":{\"user_contact_details\":{\"title\":\"Mrs\",\"address\":\"The Chimes\\r\\n44 Measham Road\\r\\nAcresford \",\"postcode\":\"DE12 8AJ\",\"country\":\"GB\",\"first_name\":\"Susan\",\"last_name\":\"Phillips\",\"phone_day\":\"01283 769809\",\"phone_evening\":null,\"dpa_flag\":false},\"user_information\":{\"comments\":null,\"move_date\":null,\"moving_reason\":null,\"property_to_sell\":null,\"property_to_rent\":null,\"financial_advice\":false,\"part_exchange\":false}},\"property\":{\"price\":107213,\"postcode\":\"DE24 8BB\",\"bedrooms\":3,\"agent_ref\":\"The_Cadiz_HTB\",\"rightmove_id\":42391559,\"rightmove_url\":\"http://www.rightmove.co.uk/new-homes-for-sale/property-42391559.html\",\"style\":\"The Cadiz\",\"property_type\":1}}]}]}';
      resp.setBody(json);
      
      if (responseHeaders != null) {
         for (String key : responseHeaders.keySet()) {
            resp.setHeader(key, responseHeaders.get(key));
         }
      }
      return resp;
    }
}