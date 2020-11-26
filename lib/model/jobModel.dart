import 'package:json_annotation/json_annotation.dart';
part 'jobModel.g.dart';
@JsonSerializable()
class Job {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String website;
  final Address address;

  Job({this.id, this.name, this.email, this.phone,this.city,this.website,this.address});

  factory Job.fromJson(Map<String, dynamic> json)=>_$JobFromJson(json);
  Map<String,dynamic>toJson()=>_$JobToJson(this);

 /* factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
      website: json['website'],
      address: Address.fromJson(
        json['address'],
      ),
    );
  }*/
}
@JsonSerializable()
class Address {
  final String city;

  Address({
    this.city,
  });
  factory Address.fromJson(Map<String, dynamic> json)=>_$AddressFromJson(json);
  Map<String,dynamic>toJson()=>_$AddressToJson(this);
  /*static Address fromJson(dynamic json) {
    return Address(
      city: json["city"],
    );
  }*/
}
