@isTest(SeeAllData=true)
public class TestOpportunityTrigger{
	private static testmethod void shouldPass(){
        Site__c mySite = new Site__c(Name = 'MySite');
        insert mySite;
        String House_type = 'someType';
        Plot__c myPlot = new Plot__c(Name = '100', Site__c = mySite.id, House_Type__c = House_type);
        insert myPlot;
    	Account acc = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId());
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = acc.id, Site__c = mySite.id, Plot__c = myPlot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
    	insert opp;
        acc.Sub_Type__c = 'Help to buy';
        update acc;
        Product2 p = new Product2(Name = 'Standard_Plot', isActive = True, ProductCode = 'plot123', Family = 'Plot');
        insert p;
        Pricebook2 pbStandard = [Select Id from Pricebook2 Where isStandard = True Limit 1];
        System.debug('Found 1 standard pricebook : ' + pbStandard.id);
        PriceBookEntry peStandard = new PriceBookEntry(Product2Id = p.id, Pricebook2Id = pbStandard.id, UnitPrice = 1.0, isActive = True);
        insert peStandard;        
        Pricebook2 pb = new Pricebook2(Name = House_type, isActive = True);
        insert pb;
        PriceBookEntry pe = new PriceBookEntry(Product2Id = p.id, Pricebook2Id = pb.id, UnitPrice = 1.0, isActive = True);
        insert pe;
        opp.Purchase_Price__c = 125000;
        update opp;
        opp.Mortgage__c = 'Mortgage Trigger';
        try{        
            update opp;
        }catch(Exception e){
            System.assertEquals('Please select the appropriate scheme that this customer is under...Eg. \"Help to buy\" or \"Deposit Paid\"..etc, by going to the customer record.', e.getMessage());
            System.debug('Opportunity should not be able to move to Mortgage Trigger, unless scheme on account is populated');
        	acc.Sub_Type__c = 'Help to buy';
            update acc;
            opp.Mortgage__c = 'Mortgage Trigger';
            update opp;
        }
        opp.Mortgage__c = 'Mortgage Application Submitted';
        update opp;
        opp.Purchase_Price__c = 126000;
        update opp;
        List<OpportunityLineItem> oli = [Select id from OpportunityLineItem where OpportunityId = :opp.id];
        system.assert(oli.size() > 0);
    }
}