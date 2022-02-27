class Church {
  final String id;
  final String churchName;
  final String phoneNumber;
  final String email;
  final String leader;
  final dynamic serviceTime;
  final String street;
  final String streetNumber;
  final String city;
  final String postCode;
  final Map<String, dynamic> latLong;
  final String image;
  final String province;

  Church({
    required this.id,
    required this.churchName,
    required this.phoneNumber,
    required this.email,
    required this.leader,
    required this.serviceTime,
    required this.street,
    required this.streetNumber,
    required this.city,
    required this.postCode,
    required this.latLong,
    required this.image,
    required this.province,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'churchName': churchName,
      'phoneNumber': phoneNumber,
      'email': email,
      'leaders': leader,
      'serviceTime': serviceTime,
      'street': street,
      'streetNumber': streetNumber,
      'city': city,
      'postCode': postCode,
      'latLong': latLong,
      'image': image,
      'province': province,
    };
  }

  factory Church.fromMap(Map<String, dynamic> map) {
    return Church(
      id: map['id'] ?? '',
      churchName: map['churchName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      leader: map['leader'],
      serviceTime: map['serviceTime'],
      street: map['street'] ?? '',
      streetNumber: map['streetNumber'] ?? '',
      city: map['city'] ?? '',
      postCode: map['postcode'] ?? '',
      latLong: Map<String, dynamic>.from(map['latLong']),
      image: map['image'] ?? '',
      province: map['province'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Church(id: $id, churchName: $churchName, phoneNumber: $phoneNumber, email: $email, leader: $leader, serviceTime: $serviceTime, street: $street, streetNumber: $streetNumber, city: $city, postCode: $postCode, latLong: $latLong, image: $image, province: $province)';
  }
}

class ServiceTime {
  final String day;
  final String time;
  ServiceTime({
    required this.day,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'time': time,
    };
  }

  factory ServiceTime.fromMap(Map<String, dynamic> map) {
    return ServiceTime(
      day: map['day'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
