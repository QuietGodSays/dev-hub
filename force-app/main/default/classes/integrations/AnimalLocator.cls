public class AnimalLocator {
    public class AnimalWrapper {
        public String id { get; set; }
        public String name { get; set; }
        public String eats { get; set; }
        public String says { get; set; }

        public AnimalWrapper(String id, String name, String eats, String says) {
            this.id = id;
            this.name = name;
            this.eats = eats;
            this.says = says;
        }
    }

    public static String getAnimalNameById(Integer id) {
        String animalName = null;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            Map<String, Object> animals = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Object o = animals.get('animal');
            String animalWrapperJson = JSON.serialize(o);

            AnimalWrapper animal = (AnimalWrapper) JSON.deserialize(
                animalWrapperJson,
                AnimalLocator.AnimalWrapper.class
            );
            animalName = animal.name;
        }
        return animalName;
    }
}
