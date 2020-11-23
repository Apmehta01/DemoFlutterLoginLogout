class RandomAPIModel {
  final String gender;
  final String email;
  final String phone;
  final Name name;
  final Dob dob;
  final Picture picture;
  final Location location;

  RandomAPIModel(
      {
      this.gender,
      this.email,
      this.phone,
      this.name,
      this.dob,
      this.picture,
      this.location

      });

  factory RandomAPIModel.fromJson(Map<String, dynamic> json) {
    return RandomAPIModel(
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        name: Name.fromJson(json['name'],),
        picture: Picture.fromJson(json['picture'],),
        location: Location.fromJson(json['location']),
        dob: Dob.fromJson(json['dob'])
    );
  }
}

class Name {
  final String first;
  final String last;

  Name({
    this.first,
    this.last,
  });

  static Name fromJson(dynamic json) {
    return Name(
      first: json["first"],
      last: json["last"],
    );
  }
}

class Dob {
  final String date;
  final int age;

  Dob({
    this.date,
    this.age,
  });

  static Dob fromJson(dynamic json) {
    return Dob(
      date: json["date"],
      age: json["age"],
    );
  }
}

class Picture {
  final String large;
  final String medium;

  Picture({
    this.large,
    this.medium,
  });

  static Picture fromJson(dynamic json) {
    return Picture(
      large: json["large"],
      medium: json["medium"],
    );
  }
}

class Location {
  final String city;
  final String state;
  final String country;
  // final int postcode;

  Location({this.city, this.state, this.country/*, this.postcode*/});

  static Location fromJson(dynamic json) {
    return Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        // postcode: json["postcode"]
    );
  }
}
