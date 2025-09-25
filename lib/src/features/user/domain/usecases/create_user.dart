import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'package:user_addresses_app/src/features/user/domain/repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;
  CreateUser(this.repository);
  Future<void> call(User user) => repository.createUser(user);
}
