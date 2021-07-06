public class ParkLocator {

    public static String[] country(String countryName){
        
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
	        
        //String[] listOfPark = park.byCountry(countryName);
        return park.byCountry(countryName);
    }
}