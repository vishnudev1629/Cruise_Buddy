class BookingType {
	int? id;
	int? packageId;
	String? name;
	String? icon;
	int? bookingPriceRule;
	String? price;
	dynamic pricePerDay;
	String? comparePrice;
	String? minAmountToPay;
	String? pricePerPerson;
	String? pricePerBed;

	BookingType({
		this.id, 
		this.packageId, 
		this.name, 
		this.icon, 
		this.bookingPriceRule, 
		this.price, 
		this.pricePerDay, 
		this.comparePrice, 
		this.minAmountToPay, 
		this.pricePerPerson, 
		this.pricePerBed, 
	});

	factory BookingType.fromJson(Map<String, dynamic> json) => BookingType(
				id: json['id'] as int?,
				packageId: json['packageId'] as int?,
				name: json['name'] as String?,
				icon: json['icon'] as String?,
				bookingPriceRule: json['booking_price_rule'] as int?,
				price: json['price'] as String?,
				pricePerDay: json['price_per_day'] as dynamic,
				comparePrice: json['comparePrice'] as String?,
				minAmountToPay: json['minAmountToPay'] as String?,
				pricePerPerson: json['pricePerPerson'] as String?,
				pricePerBed: json['pricePerBed'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'packageId': packageId,
				'name': name,
				'icon': icon,
				'booking_price_rule': bookingPriceRule,
				'price': price,
				'price_per_day': pricePerDay,
				'comparePrice': comparePrice,
				'minAmountToPay': minAmountToPay,
				'pricePerPerson': pricePerPerson,
				'pricePerBed': pricePerBed,
			};
}
