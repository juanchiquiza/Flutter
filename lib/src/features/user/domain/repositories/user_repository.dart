import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> createUser(User user);

  Future<List<User>> getUsers();

  Future<void> addAddress(Address address);
}
