import 'address.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime? dob;
  final List<Address> addresses;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.dob,
    this.addresses = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'dob': dob?.toIso8601String(),
      };

  static User fromMap(Map<String, dynamic> m, List<Address> addrs) => User(
        id: m['id'] as String,
        firstName: m['firstName'] as String,
        lastName: m['lastName'] as String,
        dob: m['dob'] != null ? DateTime.parse(m['dob'] as String) : null,
        addresses: addrs,
      );
}
