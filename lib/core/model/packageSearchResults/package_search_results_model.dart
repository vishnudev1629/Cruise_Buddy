class PackageSearchResultsModel {
  final List<PackageData> data;
  final Links links;
  final Meta meta;

  PackageSearchResultsModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PackageSearchResultsModel.fromJson(Map<String, dynamic> json) {
    return PackageSearchResultsModel(
      data: (json['data'] as List).map((e) => PackageData.fromJson(e)).toList(),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class PackageData {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final int cruiseId;
  final Cruise? cruise;

  PackageData({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.cruiseId,
    this.cruise,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) {
    return PackageData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
      cruiseId: json['cruiseId'],
    cruise: json['cruise'] != null ? Cruise.fromJson(json['cruise']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'cruiseId': cruiseId,
      'cruise': cruise?.toJson(),
    };
  }
}

class Cruise {
  final int id;
  final int rooms;
  final int maxCapacity;
  final String description;
  final bool isActive;
  final CruiseType cruiseType;
  final List<dynamic> ratings;

  Cruise({
    required this.id,
    required this.rooms,
    required this.maxCapacity,
    required this.description,
    required this.isActive,
    required this.cruiseType,
    required this.ratings,
  });

  factory Cruise.fromJson(Map<String, dynamic> json) {
    return Cruise(
      id: json['id'],
      rooms: json['rooms'],
      maxCapacity: json['maxCapacity'],
      description: json['description'],
      isActive: json['isActive'],
      cruiseType: CruiseType.fromJson(json['cruiseType']),
      ratings: json['ratings'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rooms': rooms,
      'maxCapacity': maxCapacity,
      'description': description,
      'isActive': isActive,
      'cruiseType': cruiseType.toJson(),
      'ratings': ratings,
    };
  }
}

class CruiseType {
  final int id;
  final String modelName;
  final String type;
  final String image;

  CruiseType({
    required this.id,
    required this.modelName,
    required this.type,
    required this.image,
  });

  factory CruiseType.fromJson(Map<String, dynamic> json) {
    return CruiseType(
      id: json['id'],
      modelName: json['modelName'],
      type: json['type'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelName': modelName,
      'type': type,
      'image': image,
    };
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<MetaLink> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: (json['links'] as List).map((e) => MetaLink.fromJson(e)).toList(),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links.map((e) => e.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class MetaLink {
  final String? url;
  final String label;
  final bool active;

  MetaLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory MetaLink.fromJson(Map<String, dynamic> json) {
    return MetaLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
