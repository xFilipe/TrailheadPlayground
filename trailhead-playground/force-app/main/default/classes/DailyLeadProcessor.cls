public class DailyLeadProcessor implements Schedulable{

    public void execute(SchedulableContext context) {
        List<Lead> leads = [select Id, LeadSource from Lead order by CreatedDate desc limit 200];
        for(Lead lead: leads) lead.LeadSource = 'Dreamforce';
        Database.update(leads);
    }

}