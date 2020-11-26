// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retroRandomAPIModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetroRandomAPIModel _$RetroRandomAPIModelFromJson(Map<String, dynamic> json) {
  return RetroRandomAPIModel(
    gender: json['gender'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    name: json['name'] == null
        ? null
        : Name.fromJson(json['name'] as Map<String, dynamic>),
    dob: json['dob'] == null
        ? null
        : Dob.fromJson(json['dob'] as Map<String, dynamic>),
    picture: json['picture'] == null
        ? null
        : Picture.fromJson(json['picture'] as Map<String, dynamic>),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RetroRandomAPIModelToJson(
        RetroRandomAPIModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'dob': instance.dob,
      'picture': instance.picture,
      'location': instance.location,
    };

Name _$NameFromJson(Map<String, dynamic> json) {
  return Name(
    first: json['first'] as String,
    last: json['last'] as String,
  );
}

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
    };

Dob _$DobFromJson(Map<String, dynamic> json) {
  return Dob(
    date: json['date'] as String,
    age: json['age'] as int,
  );
}

Map<String, dynamic> _$DobToJson(Dob instance) => <String, dynamic>{
      'date': instance.date,
      'age': instance.age,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) {
  return Picture(
    large: json['large'] as String,
    medium: json['medium'] as String,
  );
}

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    city: json['city'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
