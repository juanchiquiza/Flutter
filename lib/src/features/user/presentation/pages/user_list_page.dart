import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/features/user/presentation/pages/user_detail_page.dart';
import 'package:user_addresses_app/src/features/user/presentation/pages/user_form_page.dart';
import 'package:user_addresses_app/src/features/user/presentation/providers/user_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: usersAsync.when(
        data: (users) => users.isEmpty
            ? const Center(child: Text('No hay usuarios'))
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (ctx, i) {
                  final u = users[i];
                  return ListTile(
                    title: Text('${u.firstName} ${u.lastName}'),
                    subtitle: Text('Direcciones: ${u.addresses.length}'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => UserDetailPage(user: u))),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const UserFormPage())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
