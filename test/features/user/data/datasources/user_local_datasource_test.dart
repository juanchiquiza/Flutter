import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_addresses_app/src/core/db/app_database.dart';
import 'package:user_addresses_app/src/features/user/data/datasources/address_dao.dart';
import 'package:user_addresses_app/src/features/user/data/datasources/user_local_datasource.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockDatabase extends Mock implements Database {}

class MockAddressDao extends Mock implements AddressDao {}

void main() {
  late MockAppDatabase mockAppDb;
  late MockDatabase mockDb;
  late UserLocalDataSourceImpl dataSource;

  setUp(() {
    mockAppDb = MockAppDatabase();
    mockDb = MockDatabase();
    dataSource = UserLocalDataSourceImpl(db: mockAppDb);

    when(() => mockAppDb.database).thenAnswer((_) async => mockDb);
  });

  group('UserLocalDataSourceImpl', () {
    test('createUser should insert into users table', () async {
      final user = User(
        id: "1",
        firstName: 'pedro',
        lastName: 'perez',
        addresses: [],
      );

      when(() => mockDb.insert('users', user.toMap()))
          .thenAnswer((_) async => 1);

      await dataSource.createUser(user);

      verify(() => mockDb.insert('users', user.toMap())).called(1);
    });

    test('getUsers should return list of users with addresses', () async {
      final userMap = {
        'id': '1',
        'firstName': 'pedro',
        'lastName': 'perez',
        'birthDate': DateTime(1990, 1, 1).toIso8601String(),
      };

      final addressMap = {
        'id': '10',
        'userId': '1',
        'line': '1',
        'country': 'Colombia',
        'department': 'Cundinamarca',
        'municipality': 'Bogotá',
      };

      when(() => mockDb.query('users', orderBy: any(named: 'orderBy')))
          .thenAnswer((_) async => [userMap]);

      when(() => mockDb.query('addresses',
              where: any(named: 'where'), whereArgs: any(named: 'whereArgs')))
          .thenAnswer((_) async => [addressMap]);

      final users = await dataSource.getUsers();

      expect(users.length, 1);
      expect(users.first.firstName, 'pedro');
    });
  });
}
