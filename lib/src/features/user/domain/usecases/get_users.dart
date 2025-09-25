import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'package:user_addresses_app/src/features/user/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;
  GetUsers(this.repository);
  Future<List<User>> call() => repository.getUsers();
}
