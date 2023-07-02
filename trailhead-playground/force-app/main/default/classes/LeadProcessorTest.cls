@IsTest
public class LeadProcessorTest{

    @IsTest
    static void TesteUpdateLeadSource(){

        List<Lead> leads = ObjectFactory.generateLead(200, 'any', 'any');
        Database.insert(leads);

        Test.startTest();
        Database.executeBatch(new LeadProcessor());
        Test.stopTest();

        List<Lead> updatedLeads = new List<Lead>([select Id from Lead where LeadSource =: 'Dreamforce']);
        System.assert(updatedLeads.size() == 200);
        
    }
}