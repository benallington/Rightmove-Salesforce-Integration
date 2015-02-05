public class LogIncidentController {

	public String searchText {get; set;}
	public List<Account> contacts {get; set;}
	public List<Plot__c> plots {get; set;}
	public Boolean showError {get; set;}
	public String errorMsg {get; set;}
	public String JSONString {get; set;}
	public String priorities {get; set;}
	public Boolean validWarranty {get; set;}
	public String reason {get; set;}
	public List<SelectOption> options {get; set;}
	public String origin {get; set;}
	public Boolean caseCreated {get; set;}
	public String contId {get; set;}
	public Boolean isPlotQuery {get; set;}
	public String symptom {get; set;}
	public Integer validCounter {get; set;}
	public List<contactPlotWrapper> cpWrappers {get; set;}
	public Boolean showSearchResults {get; set;}
	public String personAccountRTypeId {get; set;}
	public Boolean showInputSection {get; set;}

	public LogIncidentController(ApexPages.StandardController controller) {
		validWarranty = false;
		caseCreated = false;
		validCounter = 0;
		isPlotQuery = false;
		cpWrappers = new List<contactPlotWrapper>();
		personAccountRTypeId = [select id,name from RecordType where SObjectType='Account' AND isPersonType=true].id;

	}

	private String queryString(){

		String q;
		String text = String.escapeSingleQuotes(searchText).toLowerCase();
		String first = text.substringBefore(' ');
		String last = text.substringAfter(' ');

		isPlotQuery = (searchText.isAlphaSpace()) ? false : true;

		//TODO query for Contact from Plot > Opportunity > Account Name
		if(isPlotQuery){
			q = 'select id, name, site_name__c from Plot__c where ';
			q+= 'name LIKE \'%' + text + '%\' ';
		}else{
			q = 'select id,firstname,lastname,personemail,(select id,plot__c,plot__r.name,plot__r.site_name__c from Opportunities) from Account where (recordtypeid=:personAccountRTypeId AND ';
			q+= '(lastname LIKE \'%' + text + '%\' ';
			q+=  'OR firstname LIKE \'%' + text + '%\'))';
			q+=  'OR ';
			q+= '(recordtypeid=:personAccountRTypeId AND ';
			q+= 'firstname LIKE \'%' + first + '%\'';
			q+=  'AND lastname LIKE \'%' + last + '%\')';
		}

		return q;
	}

	/*
	Getting and setting Customer Names for Typeahead
	* COMMENTING OUT UNTIL WE NEED IT
	*/
	/*private List<String> findFullNames(){
		Contact[] contList = [select id,firstname,lastname,email from Contact]; //Limit this query if more than 50K contacts are in system
		list<String> fullnames = new list<String>();

		for(Contact c : contList){
			if(c.firstname != null)
			fullnames.add(c.firstname+' '+c.lastname);
		}

		return fullnames;
	}

	private void stringToJSON(){
		JSONString = JSON.serialize(findFullNames());
	}

	public PageReference getNames(){
		stringToJSON();
		return null;
	}
	/*----------------------------------------------*/

	/*
	Getting and setting Picklist values
	*/
	public List<SelectOption> getReasonOptions(){

		options = new List<SelectOption>();

		Schema.DescribeFieldResult fieldResult = Case.Type.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for(Schema.PicklistEntry f : ple){
			options.add(new SelectOption(f.getLabel(), f.getValue()));
		}
		return options;
	}

	public String getReason() {
		return reason;
	}

	public List<SelectOption> getitems() {
	    List<SelectOption> options = new List<SelectOption>();
	    options.add(new SelectOption('High','High'));
	    options.add(new SelectOption('Medium','Medium'));
	    options.add(new SelectOption('Low','Low'));

	    return options;
	}

    public String getPriorities() {
        return priorities;
    }

	public List<SelectOption> getOrigins(){

		List<SelectOption> origins = new List<SelectOption>();
	    origins.add(new SelectOption('Phone','Phone'));
	    origins.add(new SelectOption('Email','Email'));
	    origins.add(new SelectOption('Web','Web'));

		return origins;
	}

	public String getOrigin() {
		return origin;
	}

	/*----------------------------------------------*/

    /*
	Reset error messages
    */
    public PageReference reset(){
        showError = false;
        validWarranty = false;
        validCounter = 0;
        caseCreated = false;
        showInputSection = false;
        return null;
    }

    /*
	Customer search
    */
	public PageReference search(){

		reset();

		if(searchText != null){
			if(searchText.length() >= 1){
				if(searchText.isAlphaSpace()){
        			contacts = database.query(queryString()); //query person accounts from search string
        			if(contacts.isEmpty()){
	        			errorMsg= 'No customers found';
	        			showError = true;
	        			return null;
        			}else{
        				getWrappers(contacts); //create contact/plot wrappers for searchResults table
        				//showSearchResults=true;
        			}
	        	}
	        	else{
        			plots = database.query(queryString()); //query plots from search string
        			//if(plots.isEmpty()){
	        			errorMsg= 'Please only use letters';
	        			showError = true;
	        			return null;
        			//}
	        	}
			}
			else{
				errorMsg = 'You must enter at least 1 character';
				showError = true;
				return null;
			}
    	}

        return null;
	}

	/*
	* Creating wrappers for VF searchResults table
	*/
	public List<contactPlotWrapper> getWrappers(List<Account> customers){
		for(Account a : [SELECT id,
							firstname,
							lastname,
							personemail,
							(SELECT id,
								plot__c,
								plot__r.name,
								plot__r.site_name__c 
								FROM Opportunities 
								ORDER BY CreatedDate ASC) 
							FROM Account WHERE id IN :Reach.Utils.getRecordIds(customers)]){
			if(!a.Opportunities.isEmpty()){
				if(a.Opportunities[0].plot__r != null){
			    	contactPlotWrapper cpwrap = new contactPlotWrapper(a,a.Opportunities[0].plot__r);
			    	cpWrappers.add(cpwrap);
		    	}
	    	}
		}
		return cpWrappers;
	}


	/*
	* Validate that Legal Completion Date is less than 2 years from TODAY
	*/
    public PageReference checkWarranty() {

    	Account a = [select id,
    					(select id,
    						Actual_Legal_Completion_Date__c 
    						from Opportunities 
    						order by CreatedDate ASC) 
						from Account where id=:contId];

    	//if we have opptys related to the Account
		if(!a.Opportunities.isEmpty()){
			//if the latest oppty has a legal completion date
	    	if(a.Opportunities[0].Actual_Legal_Completion_Date__c == null){
	    		validWarranty = false;
	    		validCounter = -1;
			}else{
				//if the latest legal completion date is greater than than 2 years from today
		    	if(Date.today() > a.Opportunities[0].Actual_Legal_Completion_Date__c + 730){
			    	validWarranty = false;
			    	validCounter = -1;
				}else{
					validWarranty = true;
					validCounter = 1;
				}
			}
		}
		showInputSection = true;
		caseCreated = false; //hiding the Case Created! message when we check more warranties
    	return null;
    }
    /*
	* Auto create the first job (Event) after insert of new Case
    */
    public Event getJob(Case c){
    	Event job = new Event();
    	job.WhatId = c.Id;
    	job.Ownerid = UserInfo.getUserId();
    	job.Description = symptom;
    	job.isRecurrence = false;
    	job.location = c.site__c;
    	job.Subject = 'Maintenance Job';
    	job.StartDateTime = DateTime.now();
    	job.EndDateTime = DateTime.now().addHours(1);

    	return job;
    }


    public PageReference saveCase() {
    	Case c = new Case();
    	Account a = [select id,(select id,plot__c from Opportunities ORDER BY CreatedDate ASC) from Account where id=:contId];
    	c.AccountId = a.id;
    	c.plot__c = a.Opportunities[0].plot__c;
    	c.Opportunity__c = a.Opportunities[0].id;
    	c.Type = reason;
    	c.Priority = priorities;
    	c.Status = 'New';
    	c.Subject = reason;
    	c.Description = symptom;
    	c.warranty_valid__c = validWarranty;
    	c.origin = origin;
    	try{
    		insert c;
    		insert getJob(c);
    	}catch(Exception ex){
    		Reach.Utils.CreateSystemException(ex);
    	}
    	//redirect to new Case
        Pagereference pageref = new Pagereference('/' + c.id);
        pageref.setRedirect(true);
    	return pageref;
    }

    public PageReference saveAndNew() {
    	Case c = new Case();
    	Account a = [select id,(select id,plot__c from Opportunities ORDER BY CreatedDate ASC) from Account where id=:contId];
    	c.AccountId = a.id;
    	c.plot__c = a.Opportunities[0].plot__c;
    	c.Opportunity__c = a.Opportunities[0].id;
    	c.Reason = reason;
    	c.Priority = priorities;
    	c.Status = 'New';
    	c.Subject = reason;
    	c.Description = symptom;
    	c.warranty_valid__c = validWarranty;
    	c.origin = origin;
    	try{
    		insert c;
    		insert getJob(c);
    		validCounter = 0;
    		caseCreated = true;
    	}catch(Exception ex){
    		Reach.Utils.CreateSystemException(ex);
    		caseCreated = false;
    	}
    	system.debug('case created is >>> ' + caseCreated);
    	return null;
    }

    /*
    * Customer - Plot Wrapper Class
	*/
    public class contactPlotWrapper {
    	public String cId {get; set;}
    	public String plotName {get; set;}
    	public String siteName {get; set;}
    	public String firstName {get; set;}
    	public String lastName {get; set;}
    	public String email {get; set;}

    	public contactPlotWrapper(Account a,Plot__c p){
    		this.cId = a.id;
    		this.plotName = p.name;
    		this.siteName = p.site_name__c;
    		this.firstname = a.firstname;
    		this.lastname = a.lastname;
    		this.email = a.personemail;
    	}
    }
}