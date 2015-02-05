/* 
*Author: Matt Parker
*/
@RestResource(urlMapping='/Lead/*')
global class RightmoveLeadService {

    /*
    * Constructor
    */
    public RightmoveLeadService() {}

    @future(callout=true)
    global static void getRightMoveLeads(){

	String result = '';
        String content = '';
        /*
        * Create Rightmove JSON Request with RightmoveRequest Wrapper class
        */
        RightmoveRequest request = new RightmoveRequest();
        RightmoveRequest.Network network = new RightmoveRequest.Network();
        network.network_id = 7552;

        RightmoveRequest.Brand brand = new RightmoveRequest.Brand();
        brand.brand_id = 27286;

        RightmoveRequest.Export_period export_period = new RightmoveRequest.Export_period();
        Date today = Date.today();
        
        String starttime = String.valueOf(today.day())
                            + '-' 
                            + String.valueOf(today.month())
                            + '-' 
                            + String.valueOf(today.year()) 
                            + ' ' 
                            + '00:00:00';
        String endtime = String.valueOf(today.day())
                            + '-' 
                            + String.valueOf(today.month())
                            + '-' 
                            + String.valueOf(today.year()) 
                            + ' ' 
                            + '23:59:59';

        system.debug('THIS IS THE Start TIME >>> ' + starttime);
        system.debug('THIS IS THE End TIME >>> ' + endtime);

        export_period.start_date_time = starttime;
        export_period.end_date_time = endtime;

        //writing brand,network, and export period to request wrapper object
        request.brand = brand;
        request.network = network;
        request.export_period = export_period;

        content = (String)RightmoveRequest.serialize(request); //serializing the request

        /*
        * Instantiate Request
        */
        HttpRequest req = new HttpRequest();

        req.setClientCertificateName('cloudreach');
        req.setEndpoint('https://adfapi.rightmove.co.uk/v1/property/getbrandemails');
        req.setHeader('Content-Type',  'application/json; charset=utf-8');
        req.setBody(content);
        system.debug('DEBUG REQUEST CONTENT >>> ' + content);
        req.setMethod('POST');

        /*
        * Instantiate Response
        */
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        //req.setCompressed(true); // otherwise we hit a limit of 32000 (however this causes a 400 response if true)

        try {
            res = http.send(req);
            result = res.getBody();
            System.debug('RESPONSE IS >>> ' + result);
        } catch(System.CalloutException ex) {
            System.debug('CALLOUT EXCEPTION >>> ' + ex);
            System.debug(res.toString());
        }

        //parse response into SObject format
        RightmoveResponse responseObj = (RightmoveResponse)RightmoveResponse.parse(result);
        system.debug('THIS IS THE PARSED RESPONSE >>> ' + responseObj);

        //get all the branches, pass them to the createLeads method
        try{
            createLeads(responseObj.branch);
        }catch(Exception ex){
            System.debug('COULD NOT CREATE LEADS >>> ' + ex);
        }
	}

    /*
    * Parse JSON Response with Wrapper class & create new Leads
    */
	public static void createLeads(List<RightmoveResponse.Branch> branches){
        list<Lead> leads = new list<Lead>();
        list<Lead> existingLeads = [select id,email from Lead];
        Set<String> existingEmails = new Set<String>();

        for(Lead l : existingLeads){
            existingEmails.add(l.email); //get all existing Lead emails
        }

        for(RightmoveResponse.Branch br : branches){
            for(RightmoveResponse.Emails em : br.emails){
                if(existingEmails.contains(em.from_address)){ //if we already have the email in the system - skip
                    continue;
                }else{
                    Lead l = new Lead();
                    l.leadsource = 'Direct mail';
                    l.firstname = em.User.User_contact_details.first_name;
                    l.lastname = em.User.User_contact_details.last_name;
                    l.salutation = em.User.User_contact_details.title;
                    l.email = em.from_address;
                    l.mobilephone = em.User.User_contact_details.phone_day;
                    l.street = em.User.User_contact_details.address;
                    l.postalcode = em.User.User_contact_details.postcode;
                    l.country = em.User.User_contact_details.country;
                    l.description = String.valueOf(em.User.User_information.comments);
                    l.to_address__c = em.to_address;
                    //add the lead to the list
                    leads.add(l);  
                }
            }   
        }
        
        insert leads;
	}
}
