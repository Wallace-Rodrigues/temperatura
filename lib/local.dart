class Local {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation; 

  final int elevation;
  final LocalAtual current; 


  Local({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation, 

    required this.current, 

  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      latitude: json['latitude'],
      longitude: json['longitude'], 

      generationtimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'], 

      current: LocalAtual.fromJson(json['current']),
    );
  }
}

class LocalAtual {
  final String time;
  final int interval;
  final double temperature2m;

  LocalAtual({
    required this.time,
    required this.interval,
    required this.temperature2m,
  });

  factory LocalAtual.fromJson(Map<String, dynamic> json) {
    return LocalAtual(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
    );
  }
}