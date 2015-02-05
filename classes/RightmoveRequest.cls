//@isTest
public class RightmoveRequest {

	public Network network;
	public Brand brand;
	public Export_period export_period;
	
	public class Network {
		public Integer network_id;
	}

	public class Brand {
		public Integer brand_id;
	}

	public class Export_period {
		public String start_date_time;
		public String end_date_time;
	}

	public static String serialize(RightmoveRequest request) {
		return (String) System.JSON.serialize(request);
	}
}