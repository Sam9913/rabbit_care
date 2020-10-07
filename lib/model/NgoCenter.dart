
class NgoCenter{
	final String id;
	final String name;
	final String state;
	final String contactNumber;
	final String address;
	final String link;
	final String remarks;

	NgoCenter({this.id, this.name, this.state, this.contactNumber, this.address, this.link, this.remarks});

	factory NgoCenter.fromJson(Map<String, dynamic> json) {
		return NgoCenter(
				id: json['CenterID'],
				name: json['Name'],
				address: json['Address'],
				state: json['State'],
				contactNumber: json['ContactNumber'],
				link: json['Link'],
				remarks: json['Remarks']
		);
	}
}

class FilteredNgoCenter {
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