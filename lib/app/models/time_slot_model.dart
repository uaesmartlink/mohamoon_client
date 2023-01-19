import 'package:cloud_firestore/cloud_firestore.dart';
import 'lawyer_model.dart';

// class TimeSlot {
//   TimeSlot(
//       {this.timeSlotId,
//       this.timeSlot,
//       this.duration,
//       this.price,
//       this.available,
//       this.lawyerid,
//       this.lawyer,
//       this.purchaseTime,
//       this.status});
//   static const String _timeSlotId = 'timeSlotId';
//   static const String _timeSlot = 'timeSlot';
//   static const String _duration = 'duration';
//   static const String _price = 'price';
//   static const String _available = 'available';
//   static const String _lawyerId = 'lawyerId';
//   static const String _lawyer = 'lawyer';
//   static const String _purchaseTime = 'purchaseTime';
//   static const String _status = 'status';

//   String? timeSlotId;
//   DateTime? timeSlot;
//   int? duration;
//   int? price;
//   bool? available;
//   String? lawyerid;
//   Lawyer? lawyer;
//   DateTime? purchaseTime;
//   String? status;

//   factory TimeSlot.fromJson(Map<String, dynamic> jsonData) {
//     return TimeSlot(
//       timeSlotId: jsonData[_timeSlotId],
//       timeSlot: (jsonData[_timeSlot] as Timestamp).toDate(),
//       duration: jsonData[_duration],
//       price: jsonData[_price],
//       available: jsonData[_available],
//       lawyerid: jsonData[_lawyerId],
//       lawyer:
//           jsonData[_lawyer] != null ? Lawyer.fromJson(jsonData[_lawyer]) : null,
//       purchaseTime: jsonData[_purchaseTime] != null
//           ? (jsonData[_purchaseTime] as Timestamp).toDate()
//           : null,
//       status: jsonData[_status],
//     );
//   }
// }

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_slot_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TimeSlot {
  TimeSlot(
      {this.timeSlotId,
      this.timeSlot,
      this.duration,
      this.bookedAmount,
      this.bookedDuration,
      this.price,
      this.available,
      this.lawyerid,
      this.lawyer,
      this.purchaseTime,
      this.status});

  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _bookedDuration = 'bookedDuration';
  static const String _bookedAmount = 'bookedAmount';
  static const String _available = 'available';
  static const String _lawyerId = 'lawyerId';
  static const String _bookByWho = 'bookByWho';
  static const String _purchaseTime = 'purchaseTime';
  static const String _status = 'status';
  static const String _pastTimeSlot = 'pastTimeSlot';
  static const String _repeatTimeSlot = 'repeatTimeSlot';
  static const String _parentTimeslotId = 'parentTimeslotId';

  String? id;
  @JsonKey(name: 'timeSlotId')
  String? timeSlotId;
  @JsonKey(
      name: 'timeSlot', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? timeSlot;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'bookedDuration')
  int? bookedDuration;
  @JsonKey(name: 'bookedAmount')
  double? bookedAmount;
  @JsonKey(name: 'available')
  bool? available;
  @JsonKey(name: 'lawyerId')
  String? lawyerid;
  @JsonKey(name: 'lawyer', toJson: lawyerToJson)
  Lawyer? lawyer;
  @JsonKey(
      name: 'purchaseTime',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  DateTime? purchaseTime;
  @JsonKey(name: 'status')
  String? status;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);

  factory TimeSlot.fromFirestore(DocumentSnapshot doc) =>
      TimeSlot.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;

  static Map<String, dynamic>? lawyerToJson(Lawyer? lawyer) => lawyer?.toJson();

  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp _dateTimeToJson(DateTime? dateTime) =>
      Timestamp.fromDate(dateTime!);

  Map<String, dynamic> toMap(TimeSlot timeSlot) {
    if (timeSlot.timeSlot == null) {
      return {
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _bookedDuration: timeSlot.bookedDuration,
        _bookedAmount: timeSlot.bookedAmount,
        _available: timeSlot.available,
        _lawyerId: timeSlot.lawyerid,
      };
    } else {
      return {
        _timeSlot: Timestamp.fromDate(timeSlot.timeSlot!),
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _bookedDuration: timeSlot.bookedDuration,
        _bookedAmount: timeSlot.bookedAmount,
        _available: timeSlot.available,
        _lawyerId: timeSlot.lawyerid,
      };
    }
  }
}
