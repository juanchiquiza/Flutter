import 'package:sqflite/sqflite.dart';
import 'package:user_addresses_app/src/core/db/app_database.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';

class AddressDao {
  final AppDatabase appDb;
  AddressDao(this.appDb);

  Future<void> insertAddress(Address address) async {
    final db = await appDb.database;
    await db.insert(
      'addresses',
      address.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
