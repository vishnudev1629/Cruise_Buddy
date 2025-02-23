import 'cruise.dart';

class Datum {
	int? id;
	String? name;
	String? description;
	bool? isActive;
	int? cruiseId;
	Cruise? cruise;

	Datum({
		this.id, 
		this.name, 
		this.description, 
		this.isActive, 
		this.cruiseId, 
		this.cruise, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				isActive: json['isActive'] as bool?,
				cruiseId: json['cruiseId'] as int?,
				cruise: json['cruise'] == null
						? null
						: Cruise.fromJson(json['cruise'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'description': description,
				'isActive': isActive,
				'cruiseId': cruiseId,
				'cruise': cruise?.toJson(),
			};
}
