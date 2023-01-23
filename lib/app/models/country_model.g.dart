// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) =>
    Country(
      countryId: json['countryId'] as String?,
      countryName: json['countryName'] as String?,
      countryTranslation: json['countryTranslation'] as String?,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$LawyerCategoryToJson(Country instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'countryTranslation': instance.countryTranslation,
      'iconUrl': instance.iconUrl,
    };
