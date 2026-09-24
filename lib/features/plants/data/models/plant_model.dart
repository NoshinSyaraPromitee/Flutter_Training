import '../../domain/entities/plant.dart';

class PlantModel {
  PlantModel._();

  static DateTime? _date(dynamic v) => v is String ? DateTime.tryParse(v)?.toLocal() : null;

  static Plant fromJson(Map<String, dynamic> j) => Plant(
        id: j['_id'].toString(),
        nickname: j['nickname'] as String? ?? '',
        species: j['species'] as String? ?? '',
        imageUrl: j['image'] as String? ?? '',
        location: j['location'] as String? ?? '',
        sunlight: j['sunlight'] as String? ?? '',
        health: (j['health'] as num?)?.round(),
        status: j['status'] as String? ?? '',
        humidity: j['humidity'] as String? ?? '',
        lastScan: _date(j['lastScan']),
        wateringFrequencyDays: (j['wateringFrequencyDays'] as num?)?.toInt() ?? 7,
        lastWatered: _date(j['lastWatered']),
        nextWatering: _date(j['nextWatering']),
        waterLevel: j['waterLevel'] as String? ?? 'Not set',
        fertilizerNote: j['fertilizerNote'] as String? ?? '',
      );

  static Map<String, dynamic> newToJson(NewPlant p) => {
        'nickname': p.nickname.trim(),
        'species': p.species.trim(),
        'location': p.location.trim(),
        'sunlight': p.sunlight.trim(),
        'wateringFrequencyDays': p.wateringFrequencyDays,
        if (p.lastWatered != null) 'lastWatered': p.lastWatered!.toUtc().toIso8601String(),
      };
}