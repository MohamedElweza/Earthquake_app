class LocationDetails {
  String? id;
  String? wikidataId;
  String? name;
  String? description;
  String? geonameId;
  String? adminLevel;

  LocationDetails(
      {this.id,
        this.wikidataId,
        this.name,
        this.description,
        this.geonameId,
        this.adminLevel});

  LocationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wikidataId = json['wikidataId'];
    name = json['name'];
    description = json['description'];
    geonameId = json['geonameId'];
    adminLevel = json['adminLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wikidataId'] = this.wikidataId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['geonameId'] = this.geonameId;
    data['adminLevel'] = this.adminLevel;
    return data;
  }
}