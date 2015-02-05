@isTest
private class TestLogIncidentController{
	@isTest
	static void testSuccessController() {

        PageReference pageRef = Page.LogIncident;
        Test.setCurrentPageReference(pageRef);
        
        //pageref.getParameters().put('id', mt.id);
        //ApexPages.StandardController sc = new ApexPages.standardController(mt);
        String rtId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Site__c site = new Site__c(Name = 'MySite');
        insert site;
        String House_type = 'someType';
        Plot__c plot = new Plot__c(Name = '100', Site__c = site.id, House_Type__c = House_type);
        insert plot;
        Account a = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId(),recordtypeid=rtId);
        insert a;
        //Contact c = new Contact(AccountId=a.id);
        //insert c;
        Opportunity opp = new Opportunity(Actual_Legal_Completion_Date__c=Date.today(),Name = 'Test Opportunity', AccountId = a.id, Site__c = site.id, Plot__c = plot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
    	insert opp;

        ApexPages.StandardController stdCont= new ApexPages.StandardController(new Case());
        LogIncidentController myPageCon = new LogIncidentController(stdCont);

        myPageCon.searchText = 'testFname';
        myPageCon.contId = a.id;
        myPageCon.saveCase();
        myPageCon.saveAndNew();
        myPageCon.search();
        myPageCon.checkWarranty();
        myPageCon.getReason();
        myPageCon.getReasonOptions();
        myPageCon.getitems();
        myPageCon.getOrigins();
        myPageCon.getOrigin();

        myPageCon.getPriorities();
        myPageCon.reset();

	}

    @isTest
    static void testExceptionController1() {

        PageReference pageRef = Page.LogIncident;
        Test.setCurrentPageReference(pageRef);
        
        //pageref.getParameters().put('id', mt.id);
        //ApexPages.StandardController sc = new ApexPages.standardController(mt);
        String rtId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Site__c site = new Site__c(Name = 'MySite');
        insert site;
        String House_type = 'someType';
        Plot__c plot = new Plot__c(Name = '100', Site__c = site.id, House_Type__c = House_type);
        insert plot;
        Account a = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId(),recordtypeid=rtId);
        insert a;
        //Contact c = new Contact(AccountId=a.id);
        //insert c;
        Opportunity opp = new Opportunity(Actual_Legal_Completion_Date__c=Date.today().addDays(1000),Name = 'Test Opportunity', AccountId = a.id, Site__c = site.id, Plot__c = plot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
        insert opp;

        ApexPages.StandardController stdCont= new ApexPages.StandardController(new Case());
        LogIncidentController myPageCon = new LogIncidentController(stdCont);
        myPageCon.searchText = 'testFname';
        myPageCon.contId = a.id;
        myPageCon.saveCase();
        myPageCon.saveAndNew();
        myPageCon.search();
        myPageCon.checkWarranty();
        myPageCon.getReason();
        myPageCon.getReasonOptions();
        myPageCon.getitems();
        myPageCon.getOrigins();
        myPageCon.getOrigin();

        myPageCon.getPriorities();
        myPageCon.reset();

    }

        @isTest
    static void testExceptionController2() {

        PageReference pageRef = Page.LogIncident;
        Test.setCurrentPageReference(pageRef);
        
        //pageref.getParameters().put('id', mt.id);
        //ApexPages.StandardController sc = new ApexPages.standardController(mt);
        String rtId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Site__c site = new Site__c(Name = 'MySite');
        insert site;
        String House_type = 'someType';
        Plot__c plot = new Plot__c(Name = '100', Site__c = site.id, House_Type__c = House_type);
        insert plot;
        Account a = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId(),recordtypeid=rtId);
        insert a;
        //Contact c = new Contact(AccountId=a.id);
        //insert c;
        Opportunity opp = new Opportunity(Actual_Legal_Completion_Date__c=Date.today().addDays(1000),Name = 'Test Opportunity', AccountId = a.id, Site__c = site.id, Plot__c = plot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
        insert opp;

        ApexPages.StandardController stdCont= new ApexPages.StandardController(new Case());
        LogIncidentController myPageCon = new LogIncidentController(stdCont);
        myPageCon.searchText = '100';
        myPageCon.contId = a.id;
        myPageCon.search();
        myPageCon.getReason();
        myPageCon.getReasonOptions();
        myPageCon.getitems();
        myPageCon.getOrigins();
        myPageCon.getOrigin();

        myPageCon.getPriorities();
        myPageCon.reset();

    }

        @isTest
    static void testExceptionController3() {

        PageReference pageRef = Page.LogIncident;
        Test.setCurrentPageReference(pageRef);
        
        //pageref.getParameters().put('id', mt.id);
        //ApexPages.StandardController sc = new ApexPages.standardController(mt);
        String rtId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Site__c site = new Site__c(Name = 'MySite');
        insert site;
        String House_type = 'someType';
        Plot__c plot = new Plot__c(Name = '100', Site__c = site.id, House_Type__c = House_type);
        insert plot;
        Account a = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId(),recordtypeid=rtId);
        insert a;
        //Contact c = new Contact(AccountId=a.id);
        //insert c;
        Opportunity opp = new Opportunity(Actual_Legal_Completion_Date__c=Date.today().addDays(1000),Name = 'Test Opportunity', AccountId = a.id, Site__c = site.id, Plot__c = plot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
        insert opp;

        ApexPages.StandardController stdCont= new ApexPages.StandardController(new Case());
        LogIncidentController myPageCon = new LogIncidentController(stdCont);
        myPageCon.searchText = '';
        myPageCon.contId = a.id;
        myPageCon.search();
        myPageCon.getReason();
        myPageCon.getReasonOptions();
        myPageCon.getitems();
        myPageCon.getOrigins();
        myPageCon.getOrigin();

        myPageCon.getPriorities();
        myPageCon.reset();

    }

    @isTest
    static void testExceptionController4() {

        PageReference pageRef = Page.LogIncident;
        Test.setCurrentPageReference(pageRef);
        
        //pageref.getParameters().put('id', mt.id);
        //ApexPages.StandardController sc = new ApexPages.standardController(mt);
        String rtId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Site__c site = new Site__c(Name = 'MySite');
        insert site;
        String House_type = 'someType';
        Plot__c plot = new Plot__c(Name = '100', Site__c = site.id, House_Type__c = House_type);
        insert plot;
        Account a = new Account(Firstname = 'testFname', Lastname = 'testLname', Customer_Type__c = 'First time buyer', Phone = '07957121234', PersonEmail = 'test@mailinator.com', PersonBirthDate = Date.newInstance(1980,2,17), Appointed_Financial_Adviser__c = UserInfo.getUserId(),recordtypeid=rtId);
        insert a;
        //Contact c = new Contact(AccountId=a.id);
        //insert c;
        Opportunity opp = new Opportunity(Actual_Legal_Completion_Date__c=null,Name = 'Test Opportunity', AccountId = a.id, Site__c = site.id, Plot__c = plot.id, StageName = 'Stage 1 Reservation', CloseDate = Date.today());
        insert opp;

        ApexPages.StandardController stdCont= new ApexPages.StandardController(new Case());
        LogIncidentController myPageCon = new LogIncidentController(stdCont);
        myPageCon.searchText = 'testFname';
        myPageCon.contId = a.id;
        myPageCon.saveCase();
        myPageCon.saveAndNew();
        myPageCon.search();
        myPageCon.checkWarranty();
        myPageCon.getReason();
        myPageCon.getReasonOptions();
        myPageCon.getitems();
        myPageCon.getOrigins();
        myPageCon.getOrigin();

        myPageCon.getPriorities();
        myPageCon.reset();

    }
}