class PackageImage {
	int? id;
	int? packageId;
	String? packageImg;
	dynamic alt;
	dynamic deletedAt;
	DateTime? createdAt;
	DateTime? updatedAt;

	PackageImage({
		this.id, 
		this.packageId, 
		this.packageImg, 
		this.alt, 
		this.deletedAt, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory PackageImage.fromJson(Map<String, dynamic> json) => PackageImage(
				id: json['id'] as int?,
				packageId: json['package_id'] as int?,
				packageImg: json['package_img'] as String?,
				alt: json['alt'] as dynamic,
				deletedAt: json['deleted_at'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'package_id': packageId,
				'package_img': packageImg,
				'alt': alt,
				'deleted_at': deletedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};
}
