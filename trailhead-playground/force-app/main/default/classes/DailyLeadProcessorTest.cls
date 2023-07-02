@IsTest
public class DailyLeadProcessorTest {

    private static String  CRON = '0 0 0 15 3 ? 2042';

    @IsTest
    static void TesteUpdateLeadSource(){

        List<Lead> leads = ObjectFactory.generateLead(200, 'any', 'any');
        Database.insert(leads);

        Test.startTest();

        String jobId = System.schedule('TesteUpdateLeadSource', CRON, new DailyLeadProcessor());

        Test.stopTest();

        List<Lead> updatedLeads = new List<Lead>([select Id from Lead where LeadSource =: 'Dreamforce']);
        System.assert(updatedLeads.size() == 200);
        
    }





}