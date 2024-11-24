class Image {
	int? id;
	int? cruiseId;
	String? cruiseImg;
	String? alt;

	Image({this.id, this.cruiseId, this.cruiseImg, this.alt});

	factory Image.fromJson(Map<String, dynamic> json) => Image(
				id: json['id'] as int?,
				cruiseId: json['cruiseId'] as int?,
				cruiseImg: json['cruiseImg'] as String?,
				alt: json['alt'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'cruiseId': cruiseId,
				'cruiseImg': cruiseImg,
				'alt': alt,
			};
}
