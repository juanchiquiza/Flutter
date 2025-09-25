import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'package:user_addresses_app/src/features/user/presentation/providers/user_providers.dart';
import 'address_form_page.dart';

class UserDetailPage extends ConsumerWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    return usersAsync.when(
      data: (users) {
        final current =
            users.firstWhere((u) => u.id == user.id, orElse: () => user);
        return Scaffold(
            appBar:
                AppBar(title: Text('${current.firstName} ${current.lastName}')),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${current.firstName}'),
                  Text('Apellido: ${current.lastName}'),
                  Text('DOB: ${current.dob?.toIso8601String() ?? '-'}'),
                  const SizedBox(height: 12),
                  const Text('Direcciones',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: current.addresses.isEmpty
                        ? const Center(child: Text('No hay direcciones'))
                        : ListView.builder(
                            itemCount: current.addresses.length,
                            itemBuilder: (ctx, i) {
                              final a = current.addresses[i];
                              return ListTile(
                                  title: Text(a.line),
                                  subtitle: Text(
                                      '${a.country} / ${a.department} / ${a.municipality}'));
                            },
                          ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddressFormPage(userId: current.id))),
                child: const Icon(Icons.add_location_alt)));
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
