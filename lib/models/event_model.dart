//TODO: For now the can add the address.
// Don't forget to add lat/long, street, number, postcode,...
// The full address wil be stored in a property.
// E.g: Event(address: , street: , number: , city: ,  latLong:, )

class Event {
  DateTime startDate;
  DateTime endDate;
  String title;
  String description;
  String image;
  String? link;
  String? address;

  Event({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.description,
    required this.image,
    this.link,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'image': image,
      'link': link,
      'address': address,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      address: map['address'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Event(startDate: $startDate, endDate: $endDate, title: $title, description: $description, image: $image, link: $link, address: $address)';
  }
}
