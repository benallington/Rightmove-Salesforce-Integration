### Integration with Rightmove's REST API and Salesforce.com
- Integrating the Rightmove webservice GetBrandEmails and the Lead SObject in Salesforce
- Uses Scheduled Apex to poll Rightmove every 15 minutes for new Email Brand Leads

####To Schedule ApexScheduler.cls
Execute Anonymous:
```java
System.schedule('Rightmove Job 1', '0 0 * * * ?', new ApexScheduler());
System.schedule('Rightmove Job 2', '0 15 * * * ?', new ApexScheduler());
System.schedule('Rightmove Job 3', '0 30 * * * ?', new ApexScheduler());
System.schedule('Rightmove Job 4', '0 45 * * * ?', new ApexScheduler());
```
