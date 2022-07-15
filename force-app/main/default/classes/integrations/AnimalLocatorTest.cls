@IsTest
public class AnimalLocatorTest {
    @IsTest
    private static void testGetAnimalNameById() {
        AnimalLocator.AnimalWrapper animal = new AnimalLocator.AnimalWrapper('1', '2', '3', '4');
        String id = animal.id;
        String eats = animal.eats;
        String says = animal.says;

        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        String name = AnimalLocator.getAnimalNameById(0);
        // Verify that the response received contains fake values
        String expectedValue = 'trailhead';
        System.assertEquals(name, expectedValue);
    }
}
