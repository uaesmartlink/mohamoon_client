// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerCategory _$LawyerCategoryFromJson(Map<String, dynamic> json) =>
    LawyerCategory(
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryTranslation: json['categoryTranslation'] as String?,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$LawyerCategoryToJson(LawyerCategory instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryTranslation': instance.categoryTranslation,
      'iconUrl': instance.iconUrl,
    };
