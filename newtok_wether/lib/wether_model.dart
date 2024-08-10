// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));



class Welcome {
  Location location;
    Current current;
    Forecast forecast;

    Welcome({
       required this.location,  
        required this.current,
        required this.forecast,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
      location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
    );

    
}
class Location {
    String name;
    String region;
    String country;
    String localtime;

    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.localtime,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        localtime: json["localtime"],
    );
}

class Current {
    int lastUpdatedEpoch;
    String lastUpdated;
    double tempC;
    int isDay;
    Condition condition;
    double windKph;
    int humidity;

    Current({
        required this.lastUpdatedEpoch,
        required this.lastUpdated,
        required this.tempC,
        required this.isDay,
        required this.condition,
        required this.windKph,
        required this.humidity,
    });

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json["last_updated_epoch"],
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"]?.toDouble(),
        humidity: json["humidity"],
    );

    
}

class Condition {
    String text;
    String icon;
    int code;

    Condition({
        required this.text,
        required this.icon,
        required this.code,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
    );

    
}

class Forecast {
    List<Forecastday> forecastday;

    Forecast({
        required this.forecastday,
    });

    factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
    );

    
}

class Forecastday {
    DateTime date;
    int dateEpoch;
    Day day;
    Astro astro;
    List<Hour> hour;

    Forecastday({
        required this.date,
        required this.dateEpoch,
        required this.day,
        required this.astro,
        required this.hour,
    });

    factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: Day.fromJson(json["day"]),
        astro: Astro.fromJson(json["astro"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
    );

    
}

class Astro {
    String sunrise;
    String sunset;
    String moonrise;
    String moonset;
    String moonPhase;
    int moonIllumination;
    int isMoonUp;
    int isSunUp;

    Astro({
        required this.sunrise,
        required this.sunset,
        required this.moonrise,
        required this.moonset,
        required this.moonPhase,
        required this.moonIllumination,
        required this.isMoonUp,
        required this.isSunUp,
    });

    factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        moonIllumination: json["moon_illumination"],
        isMoonUp: json["is_moon_up"],
        isSunUp: json["is_sun_up"],
    );

    
}

class Day {
    double maxtempC;
    double avgtempC;
    Condition condition;

    Day({
        required this.maxtempC,
        required this.avgtempC,
        required this.condition,
    });

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"]?.toDouble(),
        avgtempC: json["avgtemp_c"]?.toDouble(),
        condition: Condition.fromJson(json["condition"]),
    );

    
}

class Hour {
    int timeEpoch;
    String time;
    double tempC;
    int isDay;
    Condition condition;
    double? tempF;

    Hour({
        required this.timeEpoch,
        required this.time,
        required this.tempC,
        required this.isDay,
        required this.condition,
        this.tempF,
    });

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json["time_epoch"],
        time: json["time"],
        tempC: json["temp_c"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        tempF: json["temp_f"]?.toDouble(),
    );

}
