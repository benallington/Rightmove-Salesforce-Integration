/* Author: Mohammed Abdul Qadeer
 * Company: Cloudreach Ltd
 * Date: 25th April 2014
 * Business case: Mapping few fields that that needs to be trasnfered upon Lead Convert. 
 * Assigning the lead to appropriate queue when the Affordability Check is completed
 * Updated by: Matt Parker
 * Updated on: 24th June 2014
 */
@isTest
public class TestHandleRightmoveAndZooplaLeads{
    /*
    private static testmethod void rightmoveLeadPlotEnquiry(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: for Topaz The Twitchell, Sutto... (ftest ltest)';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' + 	
                'Name:	 	Dr Stephanie Test \r\n' + 
                'Email:		testlead@mailinator.com \r\n' + 
                'Phone:		07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:	20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
            	'PROPERTY \r\n\r\n' +
            	'Price: 		Equity Loan £101,213 \r\n\n' + 
            	'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
        		'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        System.assertEquals(result.success  ,true); 
    }

    private static testmethod void rightmoveLeadBuyingIn(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: Buying in';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' +   
                'Name:      Dr Stephanie Test \r\n' + 
                'Email:     testlead@mailinator.com \r\n' + 
                'Phone:     07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:   20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
                'PROPERTY \r\n\r\n' +
                'Price:         Equity Loan £101,213 \r\n\n' + 
                'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
                'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

    private static testmethod void rightmoveLeadComingSoonEnquiry(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: coming soon enquiry';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' +   
                'Name:      Dr Stephanie Test \r\n' + 
                'Email:     testlead@mailinator.com \r\n' + 
                'Phone:     07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:   20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
                'PROPERTY \r\n\r\n' +
                'Price:         Equity Loan £101,213 \r\n\n' + 
                'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
                'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

    private static testmethod void rightmoveLeadBuyingInComingSoon(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: buying in Topaz - coming soon';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' +   
                'Name:      Dr Stephanie Test \r\n' + 
                'Email:     testlead@mailinator.com \r\n' + 
                'Phone:     07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:   20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
                'PROPERTY \r\n\r\n' +
                'Price:         Equity Loan £101,213 \r\n\n' + 
                'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
                'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

    private static testmethod void rightmoveLeadComingSoon(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: coming soon';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' +   
                'Name:      Dr Stephanie Test \r\n' + 
                'Email:     testlead@mailinator.com \r\n' + 
                'Phone:     07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:   20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
                'PROPERTY \r\n\r\n' +
                'Price:         Equity Loan £101,213 \r\n\n' + 
                'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
                'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }


    private static testmethod void rightmoveLeadNoSalutation(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Rightmove Lead: for Topaz The Twitchell, Sutto... (ftest ltest)';
        email.fromName = 'test test';
        email.plainTextBody = 'Topaz by Strata Homes \r\n\n' + 'CONTACT DETAILS \r\n\n' +   
                'Name:      Stephanie Test \r\n' + 
                'Email:     testlead@mailinator.com \r\n' + 
                'Phone:     07917433319 \r\n' + 
                //'Address:   NG19 6TE \r\n\r\n' + 
                'Address:   20 Harrop White Road Mansfield Notts, NG19 6TE \r\n\r\n' + 
                'PROPERTY \r\n\r\n' +
                'Price:         Equity Loan £101,213 \r\n\n' + 
                'Comments \r\n' + 'Could I have details about the Geneva at the topaz the twitchell sutton in Ashfield.\r\n' +
                'SEARCH CRITERIA*\r\n' + 'Properties up to £110,000 in NG19 6TE (+5 miles)';

        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        System.assertEquals(result.success  ,true); 
    }*/

	private static testmethod void zooplaLeadBuyer(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Buyer lead from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an buyer enquiry from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
				'Applicant\'s details \r\n' + 
				'Name: Mrs Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
				'Telephone number: 07522219954\r\n' +
            	'Type of enquiry: Request property details\r\n' +
				'Message: Generally available at weekends\r\n' +
 				'Development: Strata - Topaz\r\n' + 
            	'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        System.assertEquals(result.success  ,true); 
    }

    private static testmethod void zooplaLeadViewing(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Viewing Request from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an viewing request from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
                'Applicant\'s details \r\n' + 
                'Name: Mrs Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
                'Telephone number: 07522219954\r\n' +
                'Type of enquiry: Request property details\r\n' +
                'Message: Generally available at weekends\r\n' +
                'Your property ref: 965935\r\n' + 
                'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        System.assertEquals(result.success  ,true); 
    }

    private static testmethod void zooplaLeadBrochure(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Brochure Request from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an brochure request from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
                'Applicant\'s details \r\n' + 
                'Name: Mrs Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
                'Telephone number: 07522219954\r\n' +
                'Type of enquiry: Request property details\r\n' +
                'Message: Generally available at weekends\r\n' +
                'Your property ref: 965935\r\n' + 
                'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

    private static testmethod void zooplaLeadApplicantEnquiry(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Applicant Enquiry from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an applicant enquiry from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
                'Applicant\'s details \r\n' + 
                'Name: Mrs Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
                'Telephone number: 07522219954\r\n' +
                'Type of enquiry: Request property details\r\n' +
                'Message: Generally available at weekends\r\n' +
                'Your property ref: 965935\r\n' + 
                'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

    private static testmethod void zooplaLeadPropertyDetailsRequest(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Brochure Request from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an property details request from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
                'Applicant\'s details \r\n' + 
                'Name: Mrs Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
                'Telephone number: 07522219954\r\n' +
                'Type of enquiry: Request property details\r\n' +
                'Message: Generally available at weekends\r\n' +
                'Your property ref: 965935\r\n' + 
                'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        //System.assertEquals(result.success  ,true); 
    }

        private static testmethod void zooplaLeadNoSalutation(){
        insert Trigger_Switch__c.getOrgDefaults();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'Buyer lead from Zoopla Property Group';
        email.fromName = 'test test';
        email.plainTextBody = 'Please find below an buyer enquiry from Sarah Lead. Please respond to this enquiry promptly to maximise your chances of converting this lead. \r\n' +
                'Applicant\'s details \r\n' + 
                'Name: Sarah Lead\r\n' + 'Email address: testlead@mailinator.com\r\n' +
                'Telephone number: 07522219954\r\n' +
                'Type of enquiry: Request property details\r\n' +
                'Message: Generally available at weekends\r\n' +
                'Development: Strata - Topaz\r\n' + 
                'Address: The Zurich, Spirit, Elton Road, Derby DE24';
        envelope.fromAddress = 'testuser@mailinator.com';
        HandleRightmoveAndZooplaLeads lead = new HandleRightmoveAndZooplaLeads();
        Messaging.InboundEmailResult result = lead.handleInboundEmail(email, envelope);
        System.assertEquals(result.success  ,true); 
    }
}