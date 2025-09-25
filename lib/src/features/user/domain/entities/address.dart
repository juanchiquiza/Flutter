class Address {
  final String id;
  final String userId;
  final String line;
  final String country;
  final String department;
  final String municipality;
  final bool isPhysicalToAccount;

  Address({
    required this.id,
    required this.userId,
    required this.line,
    required this.country,
    required this.department,
    required this.municipality,
    this.isPhysicalToAccount = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'line': line,
        'country': country,
        'department': department,
        'municipality': municipality,
        'isPhysicalToAccount': isPhysicalToAccount ? 1 : 0,
      };

  static Address fromMap(Map<String, dynamic> m) => Address(
        id: m['id'] as String,
        userId: m['userId'] as String,
        line: m['line'] as String,
        country: m['country'] as String,
        department: m['department'] as String,
        municipality: m['municipality'] as String,
        isPhysicalToAccount: (m['isPhysicalToAccount'] ?? 0) == 1,
      );
}
