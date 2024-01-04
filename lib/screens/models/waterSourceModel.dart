class WaterSource {
  final String name;
  final double currentLevel;
  final String quality;
  final String desc;
  final double latitude;
  final double longitude;

  WaterSource({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.currentLevel,
    required this.quality,
    required this.desc,
  });
  factory WaterSource.fromJson(Map<String, dynamic> json) {
    return WaterSource(
      name: json['name'],
      currentLevel: json['currentLevel'].toDouble(),
      quality: json['quality'],
      desc: json['desc'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
