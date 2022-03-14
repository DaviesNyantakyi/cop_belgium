class Church {
  String? id;
  final String churchName;
  final String phoneNumber;
  final String email;
  final String leader;
  final dynamic serviceTime; //TODO: change type notation
  final String street;
  final String streetNumber;
  final String city;
  final String postCode;
  final Map<String, dynamic>? latLong;
  String? image; // TODO: Change to imageUrl
  final String province;

  Church({
    this.id,
    required this.churchName,
    required this.phoneNumber,
    required this.email,
    required this.leader,
    required this.serviceTime,
    required this.street,
    required this.streetNumber,
    required this.city,
    required this.postCode,
    this.latLong,
    this.image,
    required this.province,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'churchName': churchName,
      'phoneNumber': phoneNumber,
      'email': email,
      'leader': leader,
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

  factory Church.fromMap({required Map<String, dynamic> map}) {
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

class Churchss {
  String? id;
  final String churchName;
  final String phoneNumber;
  final String email;
  final Map<String, dynamic> leaderInfo;
  final List<Map<String, dynamic>> serviceTime; //TODO: change type notation
  final String street;
  final String streetNumber;
  final String city;
  final String postCode;
  final Map<String, dynamic>? latLong;
  String? image; // TODO: Change to imageUrl
  final String province;

  Churchss({
    this.id,
    required this.churchName,
    required this.phoneNumber,
    required this.email,
    required this.leaderInfo,
    required this.serviceTime,
    required this.street,
    required this.streetNumber,
    required this.city,
    required this.postCode,
    this.latLong,
    this.image,
    required this.province,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'churchName': churchName,
      'phoneNumber': phoneNumber,
      'email': email,
      'leaderInfo': leaderInfo,
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

  factory Churchss.fromMap({required Map<String, dynamic> map}) {
    return Churchss(
      id: map['id'] ?? '',
      churchName: map['churchName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      leaderInfo: map['leaderInfo'],
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
    return 'Church(id: $id, churchName: $churchName, phoneNumber: $phoneNumber, email: $email, leaderInfo: $leaderInfo, serviceTime: $serviceTime, street: $street, streetNumber: $streetNumber, city: $city, postCode: $postCode, latLong: $latLong, image: $image, province: $province)';
  }
}
