import 'package:equatable/equatable.dart';

class Place extends Equatable{

  final String name;
  final String? country;
  final double latitude;
  final double longitude;

  const Place({
    required this.name,
    this.country,
    required this.latitude,
    required this.longitude,

  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    name: json['name'] as String,
    country: json['country'] as String?,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );


  @override
  // TODO: implement props
  List<Object?> get props => [name, country, latitude, longitude];

}