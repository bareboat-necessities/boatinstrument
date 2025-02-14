// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propulsion_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EngineSettings _$EngineSettingsFromJson(Map<String, dynamic> json) =>
    _EngineSettings(
      id: json['id'] as String? ?? '',
      maxRPM: (json['maxRPM'] as num?)?.toInt() ?? 4000,
      rpmRedLine: (json['rpmRedLine'] as num?)?.toInt() ?? 3500,
      maxTemp: (json['maxTemp'] as num?)?.toDouble() ?? kelvinOffset + 120,
      maxOilPressure: (json['maxOilPressure'] as num?)?.toDouble() ?? 500000,
      maxExhaustTemp:
          (json['maxExhaustTemp'] as num?)?.toDouble() ?? kelvinOffset + 600,
    );

Map<String, dynamic> _$EngineSettingsToJson(_EngineSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'maxRPM': instance.maxRPM,
      'rpmRedLine': instance.rpmRedLine,
      'maxTemp': instance.maxTemp,
      'maxOilPressure': instance.maxOilPressure,
      'maxExhaustTemp': instance.maxExhaustTemp,
    };
