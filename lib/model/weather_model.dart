class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feelLike;
  int? pressure;
  Weather(
      {this.cityName,
      this.temp,
      this.wind,
      this.humidity,
      this.feelLike,
      this.pressure});
  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    pressure = json['main']['pressure'];
    humidity = json['main']['humidity'];
    feelLike = json['main']['feels_like'];
  }
}
