import 'package:user_addresses_app/src/core/db/app_database.dart';
import 'package:user_addresses_app/src/features/user/data/datasources/address_dao.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';

abstract class UserLocalDataSource {
  Future<void> createUser(User user);

  Future<List<User>> getUsers();

  Future<void> addAddress(Address address);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase db;

  UserLocalDataSourceImpl({required this.db});

  @override
  Future<void> createUser(User user) async {
    final database = await db.database;
    await database.insert('users', user.toMap());
  }

  @override
  Future<List<User>> getUsers() async {
    final database = await db.database;
    final usersMaps = await database.query('users', orderBy: 'rowid DESC');
    final List<User> users = [];
    for (final um in usersMaps) {
      final addressMaps = await database
          .query('addresses', where: 'userId = ?', whereArgs: [um['id']]);
      final addrs = addressMaps.map((m) => Address.fromMap(m)).toList();
      users.add(User.fromMap(Map<String, dynamic>.from(um), addrs));
    }
    return users;
  }

  @override
  Future<void> addAddress(Address address) async {
    final dao = AddressDao(db);
    await dao.insertAddress(address);
  }
}
