import 'cruises_image.dart';
import 'package.dart';

class Datum {
	int? id;
	int? ownerId;
	int? cruiseTypeId;
	int? locationId;
	String? name;
	int? rooms;
	dynamic beds;
	int? maxCapacity;
	String? description;
	String? slug;
	bool? isActive;
	dynamic deletedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	dynamic avgRating;
	List<CruisesImage>? cruisesImages;
	List<Package>? packages;

	Datum({
		this.id, 
		this.ownerId, 
		this.cruiseTypeId, 
		this.locationId, 
		this.name, 
		this.rooms, 
		this.beds, 
		this.maxCapacity, 
		this.description, 
		this.slug, 
		this.isActive, 
		this.deletedAt, 
		this.createdAt, 
		this.updatedAt, 
		this.avgRating, 
		this.cruisesImages, 
		this.packages, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as int?,
				ownerId: json['owner_id'] as int?,
				cruiseTypeId: json['cruise_type_id'] as int?,
				locationId: json['location_id'] as int?,
				name: json['name'] as String?,
				rooms: json['rooms'] as int?,
				beds: json['beds'] as dynamic,
				maxCapacity: json['max_capacity'] as int?,
				description: json['description'] as String?,
				slug: json['slug'] as String?,
				isActive: json['is_active'] as bool?,
				deletedAt: json['deleted_at'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				avgRating: json['avg_rating'] as dynamic,
				cruisesImages: (json['cruises_images'] as List<dynamic>?)
						?.map((e) => CruisesImage.fromJson(e as Map<String, dynamic>))
						.toList(),
				packages: (json['packages'] as List<dynamic>?)
						?.map((e) => Package.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'owner_id': ownerId,
				'cruise_type_id': cruiseTypeId,
				'location_id': locationId,
				'name': name,
				'rooms': rooms,
				'beds': beds,
				'max_capacity': maxCapacity,
				'description': description,
				'slug': slug,
				'is_active': isActive,
				'deleted_at': deletedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'avg_rating': avgRating,
				'cruises_images': cruisesImages?.map((e) => e.toJson()).toList(),
				'packages': packages?.map((e) => e.toJson()).toList(),
			};
}
