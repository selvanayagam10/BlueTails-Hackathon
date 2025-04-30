//Apex class which will be used in Agentforce Action send the email alert for engagement score
public with sharing class SendHighEngagementEmailAlertAction {
    
    @InvocableMethod(label='Send High Engagement Email' description='Sends email with contacts having engagement score >30.')
    public static List<String> sendEmail(List<EmailInput> emailInputs) {
        
        List<String> results = new List<String>();
        
        for (EmailInput input : emailInputs) {
            
            // Step 1: Start building HTML Table
            String htmlTable = '<table border="1" style="border-collapse: collapse;">' +
                               '<thead><tr>' +
                               '<th>Contact Name</th>' +
                               '<th>Unified Customer ID</th>' +
                               '</tr></thead><tbody>';
            
            // Step 2: Process Contact List
            for (Contact contactData : input.ContactListData) {
                //List<String> parts = contactData.split('\\|\\|');
            
                    String contactName = contactData.firstName + ' '+contactData.LastName;
                    String unifiedCustomerId = contactData.Unified_Profile_Id__c;
                    
                    htmlTable += '<tr><td>' + contactName.escapeHtml4() + '</td><td>' + unifiedCustomerId.escapeHtml4() + '</td></tr>';
                }
            
            
            htmlTable += '</tbody></table>';
            
            // Step 3: Final Email Body
            String emailBody = 'Hello,<br/><br/>' +
                               'Here is today\'s list of Contacts with Engagement Score greater than 30:<br/><br/>' +
                               htmlTable +
                               '<br/><br/>Regards,<br/>Salesforce Bot';
            
            // Step 4: Prepare Email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{ input.ReceiverEmail });
            email.setSubject('Daily Report: High Engagement Score Contacts');
            email.setHtmlBody(emailBody);
            
            // Step 5: Send Email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            
            results.add('Email sent successfully to ' + input.ReceiverEmail);
        }
        
        return results;
    }
    
    public class EmailInput {
        @InvocableVariable(required=true label='Receiver Email')
        public String ReceiverEmail;
        
        @InvocableVariable(required=true label='Contact List Data')
        public List<Contact> ContactListData;
    }
}