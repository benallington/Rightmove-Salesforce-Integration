@isTest
private class RightmoveLeadServiceTest {
	
	@isTest static void testCallout() {

		RightmoveLeadService svc = new RightmoveLeadService();
		RightmoveRequest req = new RightmoveRequest();
		RightmoveResponse res = new RightmoveResponse();

        HttpRequestMock fakeResponse = new HttpRequestMock(200,
                                                 'Complete',
                                                 '{"network":{"network_id": 7552},"brand":{"brand_id": 27286},"export_period":{"start_date_time": "15-01-2015 00:00:00","end_date_time": "01-02-2015 00:00:00"}}',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        RightmoveLeadService.getRightMoveLeads();
	}

	@isTest static void testResponseClass(){

		RightmoveResponse.User u = new RightmoveResponse.User();
		RightmoveResponse.Branch b = new RightmoveResponse.Branch();
		RightmoveResponse.Emails e = new RightmoveResponse.Emails();
		RightmoveResponse.User_contact_details details = new RightmoveResponse.User_contact_details();
		RightmoveResponse.User_information info = new RightmoveResponse.User_information();
		RightmoveResponse.Property p = new RightmoveResponse.Property();

	}
	
}