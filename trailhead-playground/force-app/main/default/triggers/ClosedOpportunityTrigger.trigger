trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> taskList = new List<Task>();

    for(Opportunity opp: Trigger.new) if(opp.StageName.equals('Closed Won')) taskList.add(createTask(opp.Id));

    private Task createTask(String opportunityId){
        return new Task(Subject = 'Tarefa de teste de acompanhamento', WhatId = opportunityId);
    }

    try {
        Database.insert(taskList);        
    } catch (DmlException e) {
        System.debug(e.getStackTraceString());        
    }    

}