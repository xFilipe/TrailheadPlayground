public class LeadProcessor implements  Database.Batchable<SObject>{ 

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('select Id, LeadSource from Lead');
    }

    public void execute(Database.BatchableContext context, List<Lead> executionList) {

        for(Lead lead: executionList) lead.LeadSource = 'Dreamforce';
        
        try { Database.update(executionList); } catch (Exception ex) { throw ex; } }

    public void finish(Database.BatchableContext context){}
    
}