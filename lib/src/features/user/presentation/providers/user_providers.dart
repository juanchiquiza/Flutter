import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/core/di/injection.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/add_address.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/create_user.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/get_users.dart';

final usersProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  return sl<GetUsers>().call();
});

final createUserProvider = Provider((ref) => sl<CreateUser>());
final addAddressProvider = Provider((ref) => sl<AddAddress>());
