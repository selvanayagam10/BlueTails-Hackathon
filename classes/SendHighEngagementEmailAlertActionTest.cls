@isTest
public class SendHighEngagementEmailAlertActionTest {
    
    @isTest
    static void testSendEmail() {
        
        // Create sample input
        SendHighEngagementEmailAlertAction.EmailInput input = new SendHighEngagementEmailAlertAction.EmailInput();
        input.ReceiverEmail = 'testuser@example.com';
        input.ContactListData = new List<String>{
            'John Doe||123456',
            'Jane Smith||654321'
        };
        
        List<SendHighEngagementEmailAlertAction.EmailInput> inputs = new List<SendHighEngagementEmailAlertAction.EmailInput>{ input };
        
        // Start Test Context
        Test.startTest();
        
        // Call the Agentforce Apex Action
        List<String> results = SendHighEngagementEmailAlertAction.sendEmail(inputs);
        
        Test.stopTest();
        
        // Assertions to check results
        System.assertEquals(1, results.size(), 'Should return one success message.');
        System.assert(results[0].contains('Email sent successfully'), 'Email send result should contain success message.');
    }
}