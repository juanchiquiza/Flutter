import 'package:user_addresses_app/src/features/user/data/datasources/user_local_datasource.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'package:user_addresses_app/src/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<void> createUser(User user) => localDataSource.createUser(user);

  @override
  Future<List<User>> getUsers() => localDataSource.getUsers();

  @override
  Future<void> addAddress(Address address) =>
      localDataSource.addAddress(address);
}
