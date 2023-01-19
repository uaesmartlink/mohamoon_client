// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      timeSlotId: json['timeSlotId'] as String?,
      timeSlot: TimeSlot._dateTimeFromJson(json['timeSlot'] as Timestamp?),
      duration: json['duration'] as int?,
      price: double.parse(json['price'].toString()),
      bookedAmount: json['bookedAmount'] != null ? double.parse(json['price'].toString()) : 0.0,
      bookedDuration: json['bookedDuration'] as int?,
      available: json['available'] as bool?,
      lawyerid: json['lawyerId'] as String?,
      lawyer: json['lawyer'] == null
          ? null
          : Lawyer.fromJson(json['lawyer'] as Map<String, dynamic>),
      purchaseTime:
          TimeSlot._dateTimeFromJson(json['purchaseTime'] as Timestamp?),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'timeSlotId': instance.timeSlotId,
      'timeSlot': TimeSlot._dateTimeToJson(instance.timeSlot),
      'duration': instance.duration,
      'price': instance.price,
      'bookedDuration': instance.bookedDuration,
      'bookedAmount': instance.bookedAmount,
      'available': instance.available,
      'lawyerId': instance.lawyerid,
      'lawyer': TimeSlot.lawyerToJson(instance.lawyer),
      'purchaseTime': TimeSlot._dateTimeToJson(instance.purchaseTime),
      'status': instance.status,
    };
