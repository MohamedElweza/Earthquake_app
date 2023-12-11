import 'location_details.dart';

class Data {
  String? id;
  String? magnitude;
  String? type;
  String? title;
  String? date;
  String? time;
  String? updated;
  String? url;
  String? detailUrl;
  String? felt;
  String? cdi;
  String? mmi;
  String? alert;
  String? status;
  String? tsunami;
  String? sig;
  String? net;
  String? code;
  String? ids;
  String? sources;
  String? types;
  String? nst;
  String? dmin;
  String? rms;
  String? gap;
  String? magType;
  String? geometryType;
  String? depth;
  String? latitude;
  String? longitude;
  String? place;
  String? distanceKM;
  String? placeOnly;
  String? location;
  String? continent;
  String? country;
  String? subnational;
  String? city;
  String? locality;
  String? postcode;
  String? what3words;
  String? timezone;
  List<LocationDetails>? locationDetails;

  Data(
      {this.id,
        this.magnitude,
        this.type,
        this.title,
        this.date,
        this.time,
        this.updated,
        this.url,
        this.detailUrl,
        this.felt,
        this.cdi,
        this.mmi,
        this.alert,
        this.status,
        this.tsunami,
        this.sig,
        this.net,
        this.code,
        this.ids,
        this.sources,
        this.types,
        this.nst,
        this.dmin,
        this.rms,
        this.gap,
        this.magType,
        this.geometryType,
        this.depth,
        this.latitude,
        this.longitude,
        this.place,
        this.distanceKM,
        this.placeOnly,
        this.location,
        this.continent,
        this.country,
        this.subnational,
        this.city,
        this.locality,
        this.postcode,
        this.what3words,
        this.timezone,
        this.locationDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    magnitude = json['magnitude'];
    type = json['type'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    updated = json['updated'];
    url = json['url'];
    detailUrl = json['detailUrl'];
    felt = json['felt'];
    cdi = json['cdi'];
    mmi = json['mmi'];
    alert = json['alert'];
    status = json['status'];
    tsunami = json['tsunami'];
    sig = json['sig'];
    net = json['net'];
    code = json['code'];
    ids = json['ids'];
    sources = json['sources'];
    types = json['types'];
    nst = json['nst'];
    dmin = json['dmin'];
    rms = json['rms'];
    gap = json['gap'];
    magType = json['magType'];
    geometryType = json['geometryType'];
    depth = json['depth'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    place = json['place'];
    distanceKM = json['distanceKM'];
    placeOnly = json['placeOnly'];
    location = json['location'];
    continent = json['continent'];
    country = json['country'];
    subnational = json['subnational'];
    city = json['city'];
    locality = json['locality'];
    postcode = json['postcode'];
    what3words = json['what3words'];
    timezone = json['timezone'];
    if (json['locationDetails'] != null) {
      locationDetails = <LocationDetails>[];
      json['locationDetails'].forEach((v) {
        locationDetails!.add(LocationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['magnitude'] = this.magnitude;
    data['type'] = this.type;
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    data['updated'] = this.updated;
    data['url'] = this.url;
    data['detailUrl'] = this.detailUrl;
    data['felt'] = this.felt;
    data['cdi'] = this.cdi;
    data['mmi'] = this.mmi;
    data['alert'] = this.alert;
    data['status'] = this.status;
    data['tsunami'] = this.tsunami;
    data['sig'] = this.sig;
    data['net'] = this.net;
    data['code'] = this.code;
    data['ids'] = this.ids;
    data['sources'] = this.sources;
    data['types'] = this.types;
    data['nst'] = this.nst;
    data['dmin'] = this.dmin;
    data['rms'] = this.rms;
    data['gap'] = this.gap;
    data['magType'] = this.magType;
    data['geometryType'] = this.geometryType;
    data['depth'] = this.depth;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['place'] = this.place;
    data['distanceKM'] = this.distanceKM;
    data['placeOnly'] = this.placeOnly;
    data['location'] = this.location;
    data['continent'] = this.continent;
    data['country'] = this.country;
    data['subnational'] = this.subnational;
    data['city'] = this.city;
    data['locality'] = this.locality;
    data['postcode'] = this.postcode;
    data['what3words'] = this.what3words;
    data['timezone'] = this.timezone;
    if (this.locationDetails != null) {
      data['locationDetails'] =
          this.locationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}