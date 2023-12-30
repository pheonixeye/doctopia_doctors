// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      weekday: json['weekday'] as String,
      intday: json['intday'] as int,
      start: json['start'] as int,
      end: json['end'] as int,
      slots: json['slots'] as int,
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'intday': instance.intday,
      'start': instance.start,
      'end': instance.end,
      'slots': instance.slots,
    };
