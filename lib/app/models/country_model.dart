
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Country {
  String? id;
  @JsonKey(name: 'countryId')
  String? countryId;
  @JsonKey(name: 'countryName')
  String? countryName;
  @JsonKey(name: 'countryTranslation')
  String? countryTranslation;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  Country({this.id, this.countryId, this.countryName,this.countryTranslation, this.iconUrl});
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$LawyerCategoryToJson(this);
  factory Country.fromFirestore(DocumentSnapshot doc) =>
      Country.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
