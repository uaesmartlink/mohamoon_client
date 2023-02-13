import 'lawyer_category_model.dart';

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
      this.categories,
      this.lawyerHospital,
      this.accountStatus,
      this.isOnline,
      });

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
  @JsonKey(name: 'categories')
  List<dynamic>? categories;
  @JsonKey(name: 'lawyerHospital')
  String? lawyerHospital;
  @JsonKey(name: 'accountStatus')
  String? accountStatus;
  @JsonKey(name: 'isOnline')
  bool? isOnline;

  factory Lawyer.fromJson(Map<String, dynamic> json) => _$LawyerFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerToJson(this);

  factory Lawyer.fromFirestore(DocumentSnapshot doc) =>
      Lawyer.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
