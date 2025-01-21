import 'location.dart';

class Cruise {
	int? id;
	int? rooms;
	int? maxCapacity;
	String? description;
	bool? isActive;
	Location? location;

	Cruise({
		this.id, 
		this.rooms, 
		this.maxCapacity, 
		this.description, 
		this.isActive, 
		this.location, 
	});

	factory Cruise.fromJson(Map<String, dynamic> json) => Cruise(
				id: json['id'] as int?,
				rooms: json['rooms'] as int?,
				maxCapacity: json['maxCapacity'] as int?,
				description: json['description'] as String?,
				isActive: json['isActive'] as bool?,
				location: json['location'] == null
						? null
						: Location.fromJson(json['location'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'rooms': rooms,
				'maxCapacity': maxCapacity,
				'description': description,
				'isActive': isActive,
				'location': location?.toJson(),
			};
}
