// class LawyerCategory {
//   String? categoryId;
//   String? categoryName;
//   String? iconUrl;
//   LawyerCategory({this.categoryId, this.categoryName, this.iconUrl});

//   static const String _categoryName = 'categoryName';
//   static const String _iconUrl = 'iconUrl';
//   static const String _categoryId = 'categoryId';

//   factory LawyerCategory.fromJson(Map<String, dynamic> data) {
//     return LawyerCategory(
//       categoryId: data[_categoryId],
//       categoryName: data[_categoryName],
//       iconUrl: data[_iconUrl],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lawyer_category_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class LawyerCategory {
  String? id;
  @JsonKey(name: 'categoryId')
  String? categoryId;
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'categoryTranslation')
  String? categoryTranslation;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  LawyerCategory({this.id, this.categoryId, this.categoryName,this.categoryTranslation, this.iconUrl});
  factory LawyerCategory.fromJson(Map<String, dynamic> json) =>
      _$LawyerCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$LawyerCategoryToJson(this);
  factory LawyerCategory.fromFirestore(DocumentSnapshot doc) =>
      LawyerCategory.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
