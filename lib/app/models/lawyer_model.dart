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
part 'lawyer_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Lawyer {
  Lawyer(
      {this.id,
      this.lawyerId,
      this.lawyerName,
      this.lawyerPicture,
      this.lawyerPrice,
      this.lawyerShortBiography,
      this.lawyerCategory,
      this.lawyerHospital,
      this.accountStatus});
  String? id;
  @JsonKey(name: 'lawyerId')
  String? lawyerId;
  @JsonKey(name: 'lawyerName')
  String? lawyerName;
  @JsonKey(name: 'lawyerPicture')
  String? lawyerPicture;
  @JsonKey(name: 'lawyerBasePrice')
  int? lawyerPrice;
  @JsonKey(name: 'lawyerBiography')
  String? lawyerShortBiography;
  @JsonKey(name: 'lawyerCategory', toJson: lawyercategoryToJson)
  LawyerCategory? lawyerCategory;
  @JsonKey(name: 'lawyerHospital')
  String? lawyerHospital;
  @JsonKey(name: 'accountStatus')
  String? accountStatus;
  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);
  Map<String, dynamic> toJson() => _$LawyerToJson(this);
  factory Lawyer.fromFirestore(DocumentSnapshot doc) =>
      Lawyer.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
  static Map<String, dynamic>? lawyercategoryToJson(
          LawyerCategory? lawyercategory) =>
      lawyercategory?.toJson();
}
