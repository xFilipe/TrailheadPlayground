

public class SchedulerUtils {
    
    
    /*
     * Como usar:
	 *
	 *	
	 * duas formas:
     *    * passando: Nome da Batch, hora que vai rodar todo dia, minuto 
     *    * SchedulerUtils.jobScheduler('nomeDaBatch', 21, 0);
     * 
     * 	  * passando: Nome da Batch, hora que vai rodar todo dia, minuto e uma data de execução
     * 	  * SchedulerUtils.jobScheduler('nomeDaBatch', 21, 0, Date.newInstance(2023, 9, 16));
     * 
     * 
     * 
     * 	  * Obs: para o nome da batch to usando like, então é possível fazer buscas como: 
     * 	  *  SchedulerUtils.jobScheduler('atualização monetária', 21, 0);  OU  testeFilipe2.jobScheduler('restituição', 21, 0);
     * 
     * 
     *  
	*/
    
    
    public static void jobScheduler(String name, Integer hour, Integer minute) {
        String cronExpression = '0 ' + minute + ' ' + hour + ' * * ? *';
        System.schedule(name, cronExpression, new BatchSchedulable(name));
    }

	
    public static void jobScheduler(String name, Integer hour, Integer minute, Date executionDate) {
        String cronExpression = '0 ' + minute + ' ' + hour + ' * * ? *';
        System.schedule(name, cronExpression, new BatchSchedulable(name, executionDate));
    }
    
    public class BatchSchedulable implements Schedulable {
        private final String batchNotFound = 'Batch não encontrada. Revise o nome: ';
        private String batchName;
        private Date executionDate;
        
        public BatchSchedulable(String batchName) {
            this.batchName = batchName;
        }
        
        public BatchSchedulable(String batchName, Date executionDate) {
            this.batchName = batchName;
            this.executionDate = executionDate;
        }

        
        public void execute(SchedulableContext sc) {
            if (String.isNotBlank(batchName)) {
                Integer batchCode = getBatchCode(batchName.toLowerCase());
                
                switch on batchCode {                    
                    when 1 { Database.executeBatch(new LeadProcessor());}
                    //when 2 { Database.executeBatch(new LeadProcessor(this.executionDate));}
                }    
            }else{
                System.debug(batchNotFound + batchName);
            }
        }
        
        private Integer getBatchCode(String batchName) {
            if (batchName.containsIgnoreCase('restituição')) {
                return 1;
            } else if (batchName.containsIgnoreCase('fatura') && batchName.containsIgnoreCase('agrupada')) {
                return 2;
            } else if (batchName.containsIgnoreCase('LeadProcessor') || batchName.containsIgnoreCase('Cancelamento LLZ') || batchName.containsIgnoreCase('CancelBatch')){
                return 3;
            } else if (batchName.containsIgnoreCase('LeadProcessor') || (batchName.containsIgnoreCase('agrup') && (batchName.containsIgnoreCase('Repass') || batchName.containsIgnoreCase('Comiss')) )){
                return this.executionDate == null ? 4 : 5;
            } else if (batchName.containsIgnoreCase('LeadProcessor') || (batchName.containsIgnoreCase('atualiza') && batchName.containsIgnoreCase('monet'))){
                return this.executionDate == null ? 6 : 7;
            }             
            return 0;
        }
        
    }
    
    
    
    
    
    
    
}