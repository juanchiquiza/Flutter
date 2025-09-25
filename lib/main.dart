import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/features/user/presentation/pages/user_list_page.dart';
import 'src/core/di/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuarios y Direcciones',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListPage(),
    );
  }
}
