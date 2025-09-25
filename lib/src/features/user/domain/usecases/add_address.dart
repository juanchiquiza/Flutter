import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';
import 'package:user_addresses_app/src/features/user/domain/repositories/user_repository.dart';

class AddAddress {
  final UserRepository repository;

  AddAddress(this.repository);

  Future<void> call(Address address) => repository.addAddress(address);
}
