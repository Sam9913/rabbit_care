
class ServiceCenter{
	final String id;
	final String name;
	final String state;
	final String contactNumber;
	final String address;
	final String link;

	ServiceCenter({this.id, this.name, this.state, this.contactNumber, this.address, this.link});

	factory ServiceCenter.fromJson(Map<String, dynamic> json) {
		return ServiceCenter(
				id: json['CenterID'],
				name: json['Name'],
				address: json['Address'],
				state: json['State'],
				contactNumber: json['ContactNumber'],
				link: json['Link']
		);
	}
}

class FilteredServiceCenter {
	static List<String> condition = [
		'All Centers',
		'Johor',
		'Kedah',
		'Kelantan',
		'Kuala Lumpur',
		'Labuan',
		'Malacca',
		'Negeri Sembilan',
		'Pahang',
		'Putrajaya',
		'Penang',
		'Perak',
		'Perlis',
		'Sarawak',
		'Sabah',
		'Selangor',
		'Terengganu',
	];

	static List<String> getSuggestions(String query) {
		List<String> matches = List();
		matches.addAll(condition);

		matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
		return matches;
	}
}