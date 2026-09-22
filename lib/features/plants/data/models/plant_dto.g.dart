// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantDto _$PlantDtoFromJson(Map<String, dynamic> json) => PlantDto(
  id: json['_id'] as String,
  nickname: json['nickname'] as String,
  species: json['species'] as String,
  image: json['image'] as String? ?? '',
  location: json['location'] as String? ?? '',
  sunlight: json['sunlight'] as String? ?? '',
  health: (json['health'] as num?)?.toInt(),
  status: json['status'] as String? ?? '',
  humidity: json['humidity'] as String? ?? '',
  lastScan: json['lastScan'] == null
      ? null
      : DateTime.parse(json['lastScan'] as String),
  wateringFrequencyDays: (json['wateringFrequencyDays'] as num?)?.toInt() ?? 7,
  lastWatered: json['lastWatered'] == null
      ? null
      : DateTime.parse(json['lastWatered'] as String),
  nextWatering: json['nextWatering'] == null
      ? null
      : DateTime.parse(json['nextWatering'] as String),
  waterLevel: json['waterLevel'] as String? ?? 'Not set',
  fertilizerNote: json['fertilizerNote'] as String? ?? '',
);

Map<String, dynamic> _$PlantDtoToJson(PlantDto instance) => <String, dynamic>{
  '_id': instance.id,
  'nickname': instance.nickname,
  'species': instance.species,
  'image': instance.image,
  'location': instance.location,
  'sunlight': instance.sunlight,
  'health': instance.health,
  'status': instance.status,
  'humidity': instance.humidity,
  'lastScan': instance.lastScan?.toIso8601String(),
  'wateringFrequencyDays': instance.wateringFrequencyDays,
  'lastWatered': instance.lastWatered?.toIso8601String(),
  'nextWatering': instance.nextWatering?.toIso8601String(),
  'waterLevel': instance.waterLevel,
  'fertilizerNote': instance.fertilizerNote,
};
