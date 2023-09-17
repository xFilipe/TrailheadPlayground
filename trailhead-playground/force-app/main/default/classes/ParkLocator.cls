public with sharing class ParkLocator {
    
    public static List<String> country(){        
        ParkService.ParksImplPort parkService = new ParkService.ParksImplPort();
        return new List<String>(parkService.byCountry('Brazil'));
    }
}