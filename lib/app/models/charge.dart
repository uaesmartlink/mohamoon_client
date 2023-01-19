import 'lawyer_category_model.dart';

// class Lawyer {
//   Lawyer(
//       {this.lawyerId,
//       this.lawyerName,
//       this.lawyerPicture,
//       this.lawyerPrice,
//       this.lawyerShortBiography,
//       this.lawyerCategory,
//       this.lawyerHospital,
//       this.accountStatus});
//   static const String _lawyerId = 'lawyerId';
//   static const String _lawyerName = 'lawyerName';
//   static const String _lawyerPicture = 'lawyerPicture';
//   static const String _lawyerPrice = 'lawyerBasePrice';
//   static const String _lawyerShortBiography = 'lawyerBiography';
//   static const String _lawyerCategory = 'lawyerCategory';
//   static const String _lawyerHospital = 'lawyerHospital';
//   static const String _accountStatus = 'accountStatus';
//   String? lawyerId;
//   String? lawyerName;
//   String? lawyerPicture;
//   int? lawyerPrice;
//   String? lawyerShortBiography;
//   LawyerCategory? lawyerCategory;
//   String? lawyerHospital;
//   String? accountStatus;

//   factory Lawyer.fromJson(Map<String, dynamic> data) {
//     return Lawyer(
//         lawyerId: data[_lawyerId],
//         lawyerName: data[_lawyerName],
//         lawyerPicture: data[_lawyerPicture],
//         lawyerPrice: data[_lawyerPrice],
//         lawyerShortBiography: data[_lawyerShortBiography],
//         lawyerCategory: data[_lawyerCategory] != null
//             ? LawyerCategory.fromJson(data[_lawyerCategory])
//             : null,
//         lawyerHospital: data[_lawyerHospital],
//         accountStatus: data[_accountStatus]);
//   }
//    Map<String, dynamic> toJson() => {
//         _lawyerId: lawyerId,
//         _lawyerName: lawyerName,
//         _lawyerPicture: lawyerPicture,
//         _lawyerPrice: lawyerPrice,
//         _lawyerShortBiography: lawyerShortBiography,_lawyerCategory: lawyerCategory
//       };
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charge.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Charge {
  Charge({
    this.id,
    this.chargeId,
    this.userId,
    this.currency,
    this.createdAt,
    this.amount,
    this.status,

  });

  String? id;
  @JsonKey(name: 'chargeId')
  String? chargeId;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'userId')
  String? userId;

  factory Charge.fromJson(Map<String, dynamic> json) => _$ChargeFromJson(json);

  Map<String, dynamic> toJson() => ChargeToJson(this);

  factory Charge.fromFirestore(DocumentSnapshot doc) =>
      Charge.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;

}
