import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Customer extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String surName;

  @HiveField(3)
  String address;

  @HiveField(4)
  String civic;

  @HiveField(5)
  String zipCode;

  @HiveField(6)
  String city;

  @HiveField(7)
  String phone;

  @HiveField(8)
  String email;

  @HiveField(9)
  String lat;

  @HiveField(10)
  String lon;

  Customer(
      {this.id,
      this.firstName,
      this.surName,
      this.address,
      this.civic,
      this.zipCode,
      this.city,
      this.phone,
      this.email,
      this.lat,
      this.lon});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: (json['id'] as String),
        firstName: json['firstName'] as String,
        surName: json['surName'] as String,
        address: json['address'] as String,
        civic: json['civic'] as String,
        zipCode: json['zipCode'] as String,
        city: json['city'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        lat: json['lat'] as String,
        lon: json['lon'] as String);
  }
}

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  Customer read(BinaryReader reader) {
    return Customer()
      ..id = reader.read()
      ..firstName = reader.read()
      ..surName = reader.read()
      ..address = reader.read()
      ..civic = reader.read()
      ..zipCode = reader.read()
      ..city = reader.read()
      ..phone = reader.read()
      ..email = reader.read()
      ..lat = reader.read()
      ..lon = reader.read();
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer.write(obj.id);
    writer.write(obj.firstName);
    writer.write(obj.surName);
    writer.write(obj.address);
    writer.write(obj.civic);
    writer.write(obj.zipCode);
    writer.write(obj.city);
    writer.write(obj.phone);
    writer.write(obj.email);
    writer.write(obj.lat);
    writer.write(obj.lon);
  }
}
