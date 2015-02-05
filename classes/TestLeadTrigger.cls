@isTest
public class TestLeadTrigger{
    private static testmethod void shouldPass(){
        Site__c mySite = new Site__c(Name = 'MySite');
        insert mySite;
        Plot__c myPlot = new Plot__c(Name = '100', Site__c = mySite.id);
        insert myPlot;
        Plot__c myPlot2 = new Plot__c(Name = '110', Site__c = mySite.id);
        insert myPlot2;
        Lead myLead = new Lead(FirstName = 'testFirstname', LastName = 'testLastname', Phone = '07957121234', Email = 'test@mailinator.com', Applicant_1_DOB__c = Date.newInstance(1980,2,17), Site_Name__c = mySite.Name);
        myLead.Customer_Type__c = 'Early Bird';
		myLead.Sub_Type__c = 'Help to buy';
        insert myLead;
        myLead.Site__c = mySite.id;
        myLead.Plot__c = myPlot.id;
		myLead.Appointed_Financial_Adviser__c = UserInfo.getUserId();
        myLead.Mortgage_Advisory_Team__c = 'North';
        myLead.Appointed_Sales_Consultant_Id__c = UserInfo.getUserId();
        myLead.Status = 'Pending Affordability Check';
		update myLead;
        myLead.Customer_Type__c = 'First time buyer';
        myLead.Status = 'Affordability Check Passed';
        update myLead;
        system.debug('Lead is on Scheme : ' + myLead.Sub_Type__c);
		Database.LeadConvert lc = new Database.LeadConvert();
		lc.setLeadId(myLead.id);

		LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
		lc.setConvertedStatus(convertStatus.MasterLabel);

		Database.LeadConvertResult lcr = Database.convertLead(lc);
		System.assert(lcr.isSuccess());
        
        //Testing for Lost Lead Scenario
        
        Lead myLead2 = new Lead(FirstName = 'testFirstname', LastName = 'test2Lastname', Phone = '07957124234', Email = 'test2@mailinator.com', Applicant_1_DOB__c = Date.newInstance(1980,2,17), Site_Name__c = mySite.Name);
        myLead2.Customer_Type__c = 'Early Bird';
        myLead2.Site__c = mySite.id;
        myLead2.Plot__c = myPlot2.id;
        insert myLead2;
        myLead2.Status = 'Lead Lost';
        update myLead2;
        Plot__c pl = [Select Status__c From Plot__c where Id = :myPlot2.id];
        System.assert(pl.Status__c == 'Awaiting Release');
    
    }
}