public with sharing class FindCongaReportsController {

	public String baseURL {get; set;}
	public String recordId {get; set;}
	public String queryId1 {get; set;}
	public String queryId2 {get; set;}
	public String templateId {get; set;}
	private String sessionId {get; set;}
	private String serverURL {get; set;}

	public FindCongaReportsController() {
		this.sessionId = UserInfo.getSessionId();
		this.serverURL = URL.getSalesforceBaseUrl().toExternalForm();
		this.baseURL = 'https://composer.congamerge.com';
		Conga_Setting__c cs = Conga_Setting__c.getValues('Legal');
		this.recordId = cs.recordId__c;
		this.templateId = cs.templateId__c;
		this.queryId1 = cs.queryId1__c;
		this.queryId2 = cs.queryId2__c;
	}

	public PageReference doReport() {
		return new PageReference(baseURL+'?SessionId='+sessionId+'&ServerURL='+serverURL+'&Id='+recordId+'&TemplateId='+templateId+'&QueryId='+queryId1+'&OCNR=1&DS7=13');
	}	
}