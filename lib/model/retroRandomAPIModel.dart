import 'package:json_annotation/json_annotation.dart';
part 'retroRandomAPIModel.g.dart';

@JsonSerializable()
class RetroRandomAPIModel {
  final String gender;
  final String email;
  final String phone;
  final Name name;
  final Dob dob;
  final Picture picture;
  final Location location;

  RetroRandomAPIModel(
      {
      this.gender,
      this.email,
      this.phone,
      this.name,
      this.dob,
      this.picture,
      this.location

      });

  factory RetroRandomAPIModel.fromJson(Map<String, dynamic> json)=>_$RetroRandomAPIModelFromJson(json);
  Map<String,dynamic>toJson()=>_$RetroRandomAPIModelToJson(this);
  /*factory RetroRandomAPIModel.fromJson(Map<String, dynamic> json) {
    return RetroRandomAPIModel(
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        name: Name.fromJson(json['name'],),
        picture: Picture.fromJson(json['picture'],),
        location: Location.fromJson(json['location']),
        dob: Dob.fromJson(json['dob'])
    );
  }*/
}

@JsonSerializable()
class Name {
  final String first;
  final String last;

  Name({
    this.first,
    this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json)=>_$NameFromJson(json);
  Map<String,dynamic>toJson()=>_$NameToJson(this);
/*  static Name fromJson(dynamic json) {
    return Name(
      first: json["first"],
      last: json["last"],
    );
  }*/
}

@JsonSerializable()
class Dob {
  final String date;
  final int age;

  Dob({
    this.date,
    this.age,
  });
  factory Dob.fromJson(Map<String, dynamic> json)=>_$DobFromJson(json);
  Map<String,dynamic>toJson()=>_$DobToJson(this);
/*  static Dob fromJson(dynamic json) {
    return Dob(
      date: json["date"],
      age: json["age"],
    );
  }*/
}

@JsonSerializable()
class Picture {
  final String large;
  final String medium;

  Picture({
    this.large,
    this.medium,
  });

  factory Picture.fromJson(Map<String, dynamic> json)=>_$PictureFromJson(json);
  Map<String,dynamic>toJson()=>_$PictureToJson(this);
/*  static Picture fromJson(dynamic json) {
    return Picture(
      large: json["large"],
      medium: json["medium"],
    );
  }*/
}
@JsonSerializable()
class Location {
  final String city;
  final String state;
  final String country;
  // final int postcode;

  Location({this.city, this.state, this.country/*, this.postcode*/});

  factory Location.fromJson(Map<String, dynamic> json)=>_$LocationFromJson(json);
  Map<String,dynamic>toJson()=>_$LocationToJson(this);

/*  static Location fromJson(dynamic json) {
    return Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        // postcode: json["postcode"]
    );
  }*/
}
