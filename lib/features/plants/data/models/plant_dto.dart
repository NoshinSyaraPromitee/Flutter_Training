import 'package:json_annotation/json_annotation.dart';
import 'package:plantpal/features/plants/domain/entities/plant.dart';

part 'plant_dto.g.dart';

/// Wire-format DTO for a plant, generated via json_serializable.
///
/// Run `dart run build_runner build --delete-conflicting-outputs` after
/// editing this class to regenerate plant_dto.g.dart.
@JsonSerializable()
class PlantDto {
  PlantDto({
    required this.id,
    required this.nickname,
    required this.species,
    this.image = '',
    this.location = '',
    this.sunlight = '',
    this.health,
    this.status = '',
    this.humidity = '',
    this.lastScan,
    this.wateringFrequencyDays = 7,
    this.lastWatered,
    this.nextWatering,
    this.waterLevel = 'Not set',
    this.fertilizerNote = '',
  });

  @JsonKey(name: '_id')
  final String id;
  final String nickname;
  final String species;
  final String image;
  final String location;
  final String sunlight;
  final int? health;
  final String status;
  final String humidity;
  final DateTime? lastScan;
  final int wateringFrequencyDays;
  final DateTime? lastWatered;
  final DateTime? nextWatering;
  final String waterLevel;
  final String fertilizerNote;

  factory PlantDto.fromJson(Map<String, dynamic> json) => _$PlantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PlantDtoToJson(this);

  factory PlantDto.fromEntity(Plant p) => PlantDto(
        id: p.id,
        nickname: p.nickname,
        species: p.species,
        image: p.imageUrl,
        location: p.location,
        sunlight: p.sunlight,
        health: p.health,
        status: p.status,
        humidity: p.humidity,
        lastScan: p.lastScan,
        wateringFrequencyDays: p.wateringFrequencyDays,
        lastWatered: p.lastWatered,
        nextWatering: p.nextWatering,
        waterLevel: p.waterLevel,
        fertilizerNote: p.fertilizerNote,
      );

  Plant toEntity() => Plant(
        id: id,
        nickname: nickname,
        species: species,
        imageUrl: image,
        location: location,
        sunlight: sunlight,
        health: health,
        status: status,
        humidity: humidity,
        lastScan: lastScan,
        wateringFrequencyDays: wateringFrequencyDays,
        lastWatered: lastWatered,
        nextWatering: nextWatering,
        waterLevel: waterLevel,
        fertilizerNote: fertilizerNote,
      );

  static Map<String, dynamic> newPlantToJson(NewPlant p) => {
        'nickname': p.nickname.trim(),
        'species': p.species.trim(),
        'location': p.location.trim(),
        'sunlight': p.sunlight.trim(),
        'wateringFrequencyDays': p.wateringFrequencyDays,
        if (p.lastWatered != null) 'lastWatered': p.lastWatered!.toUtc().toIso8601String(),
      };
}
