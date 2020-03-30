// To parse this JSON data, do
//
//     final forecastWeather = forecastWeatherFromJson(jsonString);

import 'dart:convert';

class ForecastWeather {
  final List<ConsolidatedWeather> consolidatedWeather;
  final DateTime time;
  final DateTime sunRise;
  final DateTime sunSet;
  final String timezoneName;
  final Parent parent;
  final List<Source> sources;
  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  final String timezone;

  ForecastWeather({
    this.consolidatedWeather,
    this.time,
    this.sunRise,
    this.sunSet,
    this.timezoneName,
    this.parent,
    this.sources,
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
    this.timezone,
  });

  factory ForecastWeather.fromRawJson(String str) =>
      ForecastWeather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForecastWeather.fromJson(Map<String, dynamic> json) =>
      ForecastWeather(
        consolidatedWeather: List<ConsolidatedWeather>.from(
            json["consolidated_weather"]
                .map((x) => ConsolidatedWeather.fromJson(x))),
        time: DateTime.parse(json["time"]),
        sunRise: DateTime.parse(json["sun_rise"]),
        sunSet: DateTime.parse(json["sun_set"]),
        timezoneName: json["timezone_name"],
        parent: Parent.fromJson(json["parent"]),
        sources:
            List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        title: json["title"],
        locationType: json["location_type"],
        woeid: json["woeid"],
        lattLong: json["latt_long"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "consolidated_weather":
            List<dynamic>.from(consolidatedWeather.map((x) => x.toJson())),
        "time": time.toIso8601String(),
        "sun_rise": sunRise.toIso8601String(),
        "sun_set": sunSet.toIso8601String(),
        "timezone_name": timezoneName,
        "parent": parent.toJson(),
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "title": title,
        "location_type": locationType,
        "woeid": woeid,
        "latt_long": lattLong,
        "timezone": timezone,
      };
}

class ConsolidatedWeather {
  final int id;
  final String weatherStateName;
  final String weatherStateAbbr;
  final String windDirectionCompass;
  final DateTime created;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final int theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;

  ConsolidatedWeather({
    this.id,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.windDirectionCompass,
    this.created,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.windDirection,
    this.airPressure,
    this.humidity,
    this.visibility,
    this.predictability,
  });

  factory ConsolidatedWeather.fromRawJson(String str) =>
      ConsolidatedWeather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      ConsolidatedWeather(
        id: json["id"],
        weatherStateName: json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"],
        windDirectionCompass: json["wind_direction_compass"],
        created: DateTime.parse(json["created"]),
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        theTemp: json["the_temp"].toDouble().round(),
        windSpeed: json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"],
        humidity: json["humidity"],
        visibility: json["visibility"].toDouble(),
        predictability: json["predictability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weather_state_name": weatherStateName,
        "weather_state_abbr": weatherStateAbbr,
        "wind_direction_compass": windDirectionCompass,
        "created": created.toIso8601String(),
        "applicable_date":
            "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
        "min_temp": minTemp,
        "max_temp": maxTemp,
        "the_temp": theTemp,
        "wind_speed": windSpeed,
        "wind_direction": windDirection,
        "air_pressure": airPressure,
        "humidity": humidity,
        "visibility": visibility,
        "predictability": predictability,
      };
}

class Parent {
  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;

  Parent({
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
  });

  factory Parent.fromRawJson(String str) => Parent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        title: json["title"],
        locationType: json["location_type"],
        woeid: json["woeid"],
        lattLong: json["latt_long"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location_type": locationType,
        "woeid": woeid,
        "latt_long": lattLong,
      };
}

class Source {
  final String title;
  final String slug;
  final String url;
  final int crawlRate;

  Source({
    this.title,
    this.slug,
    this.url,
    this.crawlRate,
  });

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        title: json["title"],
        slug: json["slug"],
        url: json["url"],
        crawlRate: json["crawl_rate"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "url": url,
        "crawl_rate": crawlRate,
      };
}
