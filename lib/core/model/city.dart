import 'dart:convert';

class City {
  final String title;
  final LocationType locationType;
  final int woeid;
  final String lattLong;

  City({
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        title: json["title"],
        locationType: locationTypeValues.map[json["location_type"]],
        woeid: json["woeid"],
        lattLong: json["latt_long"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location_type": locationTypeValues.reverse[locationType],
        "woeid": woeid,
        "latt_long": lattLong,
      };
}

enum LocationType { CITY, REGION_STATE_PROVINCE }

final locationTypeValues = EnumValues({
  "City": LocationType.CITY,
  "Region / State / Province": LocationType.REGION_STATE_PROVINCE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
