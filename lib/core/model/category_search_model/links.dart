class Links {
	String? first;
	String? last;
	dynamic prev;
	dynamic next;

	Links({this.first, this.last, this.prev, this.next});

	factory Links.fromJson(Map<String, dynamic> json) => Links(
				first: json['first'] as String?,
				last: json['last'] as String?,
				prev: json['prev'] as dynamic,
				next: json['next'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'first': first,
				'last': last,
				'prev': prev,
				'next': next,
			};
}
