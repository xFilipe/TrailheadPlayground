@RestResource(urlMapping='/creditAnalysis/*')
global without sharing class CreditAnalysis {
    
    public class ClientProfileWrapper{
        //public String postalCode {get;set;}
        public String amout {get;set;}
        public String idade {get;set;}
    }
    
    @HttpGet
    global static List<String> doGet(){
        
        
        RestRequest request = RestContext.request;        
        //System.debug('request header' + JSON.serializePretty(request.headers));
        
        String body = request.requestBody.toString();        
        //System.debug('request body' + JSON.serializePretty(request.requestBody.toString()));        
        
        CreditAnalysis.ClientProfileWrapper clientProfile;
        if(String.isNotBlank(body)) clientProfile = (CreditAnalysis.ClientProfileWrapper)JSON.deserialize(body,CreditAnalysis.ClientProfileWrapper.class);
        
        system.debug('clientProfile > ' + JSON.serializePretty(clientProfile));
        
        List<String> response = new List<String>();
        
        if(null != clientProfile){
            try{
                response = callExpressionSet(clientProfile);
            }catch(Exception ex){
                System.debug('deu ruim ');                
            }
        } 
        
        
        return response;
    }
    
    @HttpPost
    global static void doPost(){
        
    }
    
    private static List<String> callExpressionSet(ClientProfileWrapper profile){
        List<String> teste = new List<String>();
      
        String sessionId = UserInfo.getSessionId();
        String expressionSetName = 'CreditAnalysisCard';
        String version = '55.0';
        String endpointUrl = URL.getOrgDomainUrl().toExternalForm() + '/services/data/v' + version + '/connect/business-rules/expressionSet/' + expressionSetName;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + sessionId);

        // Converter a lista de input para JSON e definir como o corpo da requisição
        Map<String, List<Object>> inputMap = new Map<String, List<Object>>();
        List<Object> profiles = new List<Object>();
        profiles.add(profile);
        inputMap.put('inputs', profiles);
        
        String requestBody = JSON.serialize(inputMap);
        
        System.debug('request ' + requestBody);
        request.setBody(requestBody);
        
        System.debug('request ' + request);

        // Enviar a chamada REST
        HttpResponse response = new Http().send(request);

        System.debug('response ' + response);
        // Processar a resposta
        if (response.getStatusCode() == 200) {
            // A chamada foi bem-sucedida
            String responseBody = response.getBody();
            System.debug('Resposta da Expression Set: ' + responseBody);
        } else {
            // A chamada falhou
            String errorMessage = 'Erro na chamada da Expression Set. Código de status: ' + response.getStatusCode();
            System.debug(errorMessage);
        }
    
        
        
        
        
        return teste;
    }
    
    
    
    //CreditAnalysisCard
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}