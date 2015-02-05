//@isTest
public class RightmoveResponse {

	public List<Branch> branch;

	public class User {
		public User_contact_details user_contact_details;
		public User_information user_information;
	}

	public class Branch {
		public Integer branch_id;
		public List<Emails> emails;
	}

	public class Emails {
		public Integer email_id;
		public String from_address;
		public String to_address;
		public String email_date;
		public List<Integer> email_types;
		public User user;
		public Property property;
	}

	public class User_contact_details {
		public String title;
		public String address;
		public String postcode;
		public String country;
		public String first_name;
		public String last_name;
		public String phone_day;
		public String phone_evening;
		public Boolean dpa_flag;
	}

	public class User_information {
		public String comments;
		public String move_date;
		public String moving_reason;
		public String property_to_sell;
		public String property_to_rent;
		public Boolean financial_advice;
		public Boolean part_exchange;
	}

	public class Property {
		public Integer price;
		public String postcode;
		public Integer bedrooms;
		public String agent_ref;
		public Integer rightmove_id;
		public String rightmove_url;
		public String style;
		public Integer property_type;
	}
	
	public static RightmoveResponse parse(String json) {
		return (RightmoveResponse) System.JSON.deserialize(json, RightmoveResponse.class);
	}
	
}