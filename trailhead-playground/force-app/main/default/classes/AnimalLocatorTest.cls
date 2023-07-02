@IsTest
public class AnimalLocatorTest{
        
    @IsTest
    static void TestGetAnimalById(){

        Test.startTest();
        String name = AnimalLocator.getAnimalNameById(2);
        System.assert(name.equals('Test'));
        Test.stopTest(); 
    }

}