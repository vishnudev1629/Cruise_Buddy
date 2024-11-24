import 'image.dart';
import 'package.dart';

class Datum {
	int? id;
	int? rooms;
	int? maxCapacity;
	String? description;
	bool? isActive;
	String? avgRating;
	List<Image>? images;
	List<Package>? packages;

	Datum({
		this.id, 
		this.rooms, 
		this.maxCapacity, 
		this.description, 
		this.isActive, 
		this.avgRating, 
		this.images, 
		this.packages, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as int?,
				rooms: json['rooms'] as int?,
				maxCapacity: json['maxCapacity'] as int?,
				description: json['description'] as String?,
				isActive: json['isActive'] as bool?,
				avgRating: json['avgRating'] as String?,
				images: (json['images'] as List<dynamic>?)
						?.map((e) => Image.fromJson(e as Map<String, dynamic>))
						.toList(),
				packages: (json['packages'] as List<dynamic>?)
						?.map((e) => Package.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'rooms': rooms,
				'maxCapacity': maxCapacity,
				'description': description,
				'isActive': isActive,
				'avgRating': avgRating,
				'images': images?.map((e) => e.toJson()).toList(),
				'packages': packages?.map((e) => e.toJson()).toList(),
			};
}
