@isTest
public class TestVerifyDate {
    
    @isTest
    static void CheckDateWithinNextThirty() {

        
        Test.startTest();
        Date dateOne = Date.today(); 
        Date dateTwo = Date.today().addDays(1);
        Date checkedDate = VerifyDate.CheckDates(dateOne, dateTwo);
        System.assertEquals(checkedDate ,dateTwo);
        Test.stopTest();
    }

    @isTest
    static void CheckDateWithoutNextThirty() {

        Test.startTest();
        Date dateOne = Date.today(); 
        Date dateTwo = Date.today().addDays(1);
        Date checkedDate = VerifyDate.CheckDates(dateTwo, dateOne);
        System.assertEquals(checkedDate.day(), Date.daysInMonth(dateOne.year(), dateOne.month()));
        Test.stopTest();
    }

}

