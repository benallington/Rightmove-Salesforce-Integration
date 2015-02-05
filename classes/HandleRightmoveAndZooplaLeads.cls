/* Author: Mohammed Abdul Qadeer
 * Company: Cloudreach Ltd
 * Date: 25th April 2014
 * Business case: Mapping few fields that that needs to be trasnfered upon Lead Convert. 
 * Assigning the lead to appropriate queue when the Affordability Check is completed
 * Updated by: Matt Parker
 * Updated on: 24th June 2014
 * Update on: 2nd Feb 2015
 * Rightmove Parsing is now via API, no longer using email services 
 */
global class HandleRightmoveAndZooplaLeads implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Creating an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    
    String emailBody = email.plainTextBody;
    emailBody = emailBody.toLowerCase();
    String emailSubject = email.subject.toLowerCase();
    System.debug('Complete Email Subject : ' + emailSubject);                                                          
    System.debug('Complete Email Body : ' + emailBody);
  
    try {
      /*
        Rightmove Templates
      */  
      /*if(emailSubject.contains('rightmove')){
        if(emailSubject.contains('buying in') && emailSubject.contains('coming soon')){
            processRightMoveBuyingInComingSoon(emailBody, emailSubject);
        }
        if(emailSubject.contains('buying in')){
            processRightMoveBuyingIn(emailBody, emailSubject);
        }
        if(emailSubject.contains('coming soon enquiry')){
            processRightMoveComingSoonEnquiry(emailBody, emailSubject);
        }
        if(emailSubject.contains('coming soon')){
            processRightMoveSiteEnquiry(emailBody, emailSubject);
        }
        else{
            processRightMoveSiteEnquiry(emailBody, emailSubject);
        }
      }*/
      /*
        Zoopla Templates
      */
      if(emailSubject.contains('zoopla')){
        if(emailBody.contains('buyer enquiry')){
            processZooplaLeadBuyer(emailBody);
        }
        if(emailBody.contains('viewing request')){
            processZooplaLeadViewing(emailBody);
        }
        if(emailBody.contains('brochure request')){
            processZooplaLeadViewing(emailBody);
        }
        if(emailBody.contains('applicant enquiry')){
            processZooplaLeadBuyer(emailBody);
        }
        if(emailBody.contains('property details request')){
            processZooplaLeadViewing(emailBody);
        }
      }
      result.success = true;
    }
   catch (Exception ex) {
       Reach.Utils.CreateSystemException(ex); 
       result.success = false;
   }
   
   return result;
  }

  /*public void processRightMoveSiteEnquiry(String emailBody, String emailSubject){
      
        System.debug('This a rightmove lead');
      String header = emailBody.split('contact details', 2)[1].split('search criteria', 2)[0];
      system.debug('Header Part : ' + header);
      List<String> name = header.split('name:')[1].split('email:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Rightmove';
        if(name.size() > 2){ //if salutation
          l.Salutation = name[0];
          l.FirstName = name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
            //for(integer i = 2; i < name.size() ; i++) if(name[i] != null) l.lastName += name[i];
            l.LastName = name[1];
        }
        l.lastName = l.lastName.replace('null', '');
        l.Email = header.split('email:')[1].split('phone:')[0].trim().replace('*', '').split(' ',0)[0];
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('phone:')[1].split('property')[0].trim().replace('*', '');
        List<String> address = header.split('address:')[1].split('price')[0].replace('*', '').trim().split(',', 0);
        l.PostalCode = address[address.size()-1];
        //l.PostalCode = header.split('Address:')[1].split('PROPERTY')[0].trim().replace('*', '').replace(',','');
        system.debug('Postal Code >>> ' + l.PostalCode);
        for(Integer i = 0; i < address.size()-1; i++) l.Street += address[i] + ' '; 
        l.Street = l.Street.replace('null','');
        //l.Street = header.split('PROPERTY')[1].split('Price:')[0].trim().replace('*', '');
        system.debug('Street Address >>> ' + l.Street);
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(emailSubject.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        if(emailBody.contains('comments')){
          l.Description = emailBody.split('comments')[1].split('search criteria')[0].trim().replace('*', '');
        }
        //system.debug('Between Comments and Search >>> ' + l.Description);
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;

        if(Helper.runOnce()){
            try{
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.assignmentRuleHeader.useDefaultRule = true;
                Database.insert(l,dmo);
            }catch (Exception e) {
               System.debug('Unable to Insert Rightmove lead record using APEX Email Services: ' + e.getMessage());
            }
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }


  public void processRightMoveBuyingIn(String emailBody, String emailSubject){
      
        System.debug('This a rightmove lead');
      String header = emailBody.split('contact details', 2)[1].split('buying criteria', 2)[0];
      system.debug('Header Part : ' + header);
      List<String> name = header.split('name:')[1].split('email:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Rightmove';
        if(name.size() > 2){ //if salutation
          l.Salutation = name[0];
          l.FirstName = name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
            //for(integer i = 2; i < name.size() ; i++) if(name[i] != null) l.lastName += name[i];
            l.LastName = name[1];
        }
        l.lastName = l.lastName.replace('null', '');
        l.Email = header.split('email:')[1].split('phone:')[0].trim().replace('*', '').split(' ',0)[0];
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('phone:')[1].split('buying criteria')[0].trim().replace('*', '');
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(emailSubject.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        
        l.Description = emailBody.split('buying criteria')[1].split('based on')[0].trim().replace('*', '');
        system.debug('Between Comments and Search >>> ' + l.Description);
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Rightmove lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }

    public void processRightMoveComingSoonEnquiry(String emailBody, String emailSubject){
      
      System.debug('This a rightmove lead');
      String header = emailBody.split('contact details', 2)[1].split('please note', 2)[0];
      system.debug('Header Part : ' + header);
      List<String> name = header.split('name:')[1].split('email:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Rightmove';
        if(name.size() > 2){ //if salutation
          l.Salutation = name[0];
          l.FirstName = name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
            //for(integer i = 2; i < name.size() ; i++) if(name[i] != null) l.lastName += name[i];
            l.LastName = name[1];
        }
        l.lastName = l.lastName.replace('null', '');
        l.Email = header.split('email:')[1].split('phone:')[0].trim().replace('*', '').split(' ',0)[0];
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('phone:')[1].split('address:')[0].trim().replace('*', '');
        List<String> address = header.split('address:')[1].split('please note')[0].replace('*', '').trim().split(',', 0);
        l.PostalCode = address[address.size()-1];
        //l.PostalCode = header.split('Address:')[1].split('PROPERTY')[0].trim().replace('*', '').replace(',','');
        system.debug('Postal Code >>> ' + l.PostalCode);
        for(Integer i = 0; i < address.size()-1; i++) l.Street += address[i] + ' '; 
        l.Street = l.Street.replace('null','');
        //l.Street = header.split('PROPERTY')[1].split('Price:')[0].trim().replace('*', '');
        system.debug('Street Address >>> ' + l.Street);
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(emailSubject.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }

        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Rightmove lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }

    public void processRightMoveBuyingInComingSoon(String emailBody, String emailSubject){
      
        System.debug('This a rightmove lead');
      String header = emailBody.split('contact details', 2)[1].split('based on', 2)[0];
      system.debug('Header Part : ' + header);
      List<String> name = header.split('name:')[1].split('email:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Rightmove';
        if(name.size() > 2){ //if salutation
          l.Salutation = name[0];
          l.FirstName = name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
            //for(integer i = 2; i < name.size() ; i++) if(name[i] != null) l.lastName += name[i];
            l.LastName = name[1];
        }
        l.lastName = l.lastName.replace('null', '');
        l.Email = header.split('email:')[1].split('phone:')[0].trim().replace('*', '').split(' ',0)[0];
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('phone:')[1].split('buying in')[0].trim().replace('*', '');
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(emailSubject.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        
        l.Description = emailBody.split('buying criteria')[1].split('please note')[0].trim().replace('*', '');
        system.debug('Between Comments and Search >>> ' + l.Description);
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Rightmove lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }

    /*public void processRightMoveLeadGeneralEnquiry(String emailBody, String emailSubject){
      
        System.debug('This a rightmove lead');
      String header = emailBody.split('contact details', 2)[1].split('property', 2)[0];
      system.debug('Header Part : ' + header);
      List<String> name = header.split('name:')[1].split('email:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Rightmove';
        if(name.size() > 2){ //if salutation
          l.Salutation = name[0];
          l.FirstName = name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
            //for(integer i = 2; i < name.size() ; i++) if(name[i] != null) l.lastName += name[i];
            l.LastName = name[1];
        }
        l.lastName = l.lastName.replace('null', '');
        l.Email = header.split('email:')[1].split('phone:')[0].trim().replace('*', '').split(' ',0)[0];
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('phone:')[1].split('comments')[0].trim().replace('*', '');
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(emailSubject.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        
        l.Description = emailBody.split('comments')[1].split('bedrooms:')[0].trim().replace('*', '');
        system.debug('Between Comments and Search >>> ' + l.Description);
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Rightmove lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }*/

  public void processZooplaLeadBuyer(String emailBody){
      System.debug('This a Zoopla Buyer Enquiry');
        //String header = emailBody.split('Applicant\'s details', 2)[1];
        String header = emailBody.split('converting this lead.', 2)[1].split('search for your', 2)[0];
    system.debug('Header Part : ' + header);
        List<String> name = header.split('name:')[1].split('email address:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Zoopla';
        if(name.size() > 2){
          l.FirstName = name[0] + ' ' + name[1];
          l.LastName = name[2];
           /* if(name[0].toLowerCase().contains('mr')){
                l.Salutation = 'Mr.';
                l.FirstName = name[1];
            l.LastName = name[2];
            }  
            else if(name[0].toLowerCase().contains('mrs')){
                l.Salutation = 'Mrs.';
                l.FirstName = name[1];
            l.LastName = name[2];
            }
            else if(name[0].toLowerCase().contains('dr')){
                l.Salutation = 'Dr.';
                l.FirstName = name[1];
            l.LastName = name[2];
            }
            else if(name[0].toLowerCase().contains('prof')){
                l.Salutation = 'Prof.';
                l.FirstName = name[1];
            l.LastName = name[2];
            }
            else{
                l.FirstName = name[0] + ' ' + name[1];
            l.LastName = name[2];
            } */
        }
        else{
          l.FirstName = name[0];
          l.LastName = name[1];
        }
        l.Email = header.split('email address:')[1].split('telephone number:')[0].trim().replace('*', '');
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('telephone number:')[1].split('type of enquiry:')[0].trim().deleteWhiteSpace().replace('*', '');
        l.Description = header.split('message:')[1].split('development:')[0].trim().replace('*', '');
        string siteInterested = header.split('strata -')[1].toLowerCase().deleteWhiteSpace();
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(siteInterested.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        /*List<String> address = header.split('Location:')[1].split('Type of property:')[0].replace('*', '').trim().split(',', 0);
        l.PostalCode = address[address.size()-1];
        system.debug('Postal Code >>> ' + l.PostalCode);
        for(Integer i = 0; i < address.size()-1; i++) l.Street += address[i] + ' '; 
        l.Street = l.Street.replace('null','');
        system.debug('Street Address >>> ' + l.Street);*/
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Zoopla lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
  }
    public void processZooplaLeadViewing(String emailBody){
           System.debug('This a Zoopla Viewing Request');
        String header = emailBody.split('applicant\'s details', 2)[1];
        system.debug('Header Part : ' + header);
        List<String> name = header.split('name:')[1].split('email address:')[0].trim().replace('*', '').split(' ',0);
        System.debug('Name List : ' + name);
        Lead l = new Lead();
        l.LeadSource = 'Direct mail';
        l.Lead_Sub_Source__c = 'Zoopla';
        if(name.size() > 2){
            l.FirstName = name[0] + ' ' + name[1];
          l.LastName = name[2];
        }
        else{
            l.FirstName = name[0];
          l.LastName = name[1];
        }
        l.Email = header.split('email address:')[1].split('telephone number:')[0].trim().replace('*', '');
        l.Email = l.Email.substringBefore('<');
        l.Phone = header.split('telephone number:')[1].split('type of enquiry:')[0].trim().deleteWhiteSpace().
        replace('*', '');
        l.Description = header.split('type of enquiry:')[1].split('your property ref:')[0].trim().replace('*', '');
        string siteInterested = header.split('your property ref:')[1].toLowerCase();
        List<Schema.PicklistEntry> pick_list_values = Lead.Site_Name__c.getDescribe().getPickListValues();
        for(Schema.PicklistEntry pe : pick_list_values) {
          if(siteInterested.contains(pe.getValue().toLowerCase()))
            {
                l.Site_Name__c = pe.getValue();
                break;
            }
        }
        Trigger_Switch__c tc = Trigger_Switch__c.getOrgDefaults();
        tc.Disable_Lead_Validation__c = True;
        //update tc;
        try{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            Database.insert(l,dmo);
        }catch (Exception e) {
           System.debug('Unable to Insert Zoopla lead record using APEX Email Services: ' + e.getMessage());
        }
        tc.Disable_Lead_Validation__c = False;
        //update tc;
 }

}