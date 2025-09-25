import 'package:get_it/get_it.dart';
import 'package:user_addresses_app/src/core/db/app_database.dart';
import 'package:user_addresses_app/src/features/user/data/datasources/address_dao.dart';
import 'package:user_addresses_app/src/features/user/data/datasources/user_local_datasource.dart';
import 'package:user_addresses_app/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:user_addresses_app/src/features/user/domain/repositories/user_repository.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/add_address.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/create_user.dart';
import 'package:user_addresses_app/src/features/user/domain/usecases/get_users.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase.instance);

  // DAOs
  sl.registerLazySingleton<AddressDao>(() => AddressDao(sl<AppDatabase>()));

  // Data sources
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(db: sl<AppDatabase>()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(localDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => AddAddress(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
}
