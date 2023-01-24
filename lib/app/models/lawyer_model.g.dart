// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lawyer _$LawyerFromJson(Map<String, dynamic> json) => Lawyer(
      lawyerId: json['lawyerId'] as String?,
      lawyerName: json['lawyerName'] as String?,
      lawyerPicture: json['lawyerPicture'] as String?,
      lawyerPrice: json['lawyerBasePrice'] as int?,
      lawyerShortBiography: json['lawyerBiography'] as String?,
      categories: json['categories']  as dynamic,
      lawyerHospital: json['lawyerHospital'] as String?,
      accountStatus: json['accountStatus'] as String?,
    );

Map<String, dynamic> _$LawyerToJson(Lawyer instance) => <String, dynamic>{
      'lawyerId': instance.lawyerId,
      'lawyerName': instance.lawyerName,
      'lawyerPicture': instance.lawyerPicture,
      'lawyerBasePrice': instance.lawyerPrice,
      'lawyerBiography': instance.lawyerShortBiography,
      'lawyerCategory': instance.categories,
      'lawyerHospital': instance.lawyerHospital,
      'accountStatus': instance.accountStatus,
    };
