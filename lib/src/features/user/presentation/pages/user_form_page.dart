import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/features/user/presentation/providers/user_providers.dart';
import 'package:uuid/uuid.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/user.dart';
import 'address_form_page.dart';

class UserFormPage extends ConsumerStatefulWidget {
  const UserFormPage({super.key});

  @override
  ConsumerState<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  DateTime? _dob;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final p = await showDatePicker(
        context: context,
        initialDate: DateTime(now.year - 20),
        firstDate: DateTime(1900),
        lastDate: now);
    if (p != null) setState(() => _dob = p);
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() != true || _dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complete todos los campos')));
      return;
    }
    final id = const Uuid().v4();
    final user = User(
        id: id,
        firstName: _first.text.trim(),
        lastName: _last.text.trim(),
        dob: _dob);
    try {
      await ref.read(createUserProvider).call(user);
      ref.invalidate(usersProvider);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Usuario creado')));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddressFormPage(userId: id)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el usuario: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear usuario')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _first,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null),
              TextFormField(
                  controller: _last,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                    child: Text(_dob == null
                        ? 'Fecha de nacimiento'
                        : _dob!.toLocal().toString().split(' ')[0])),
                TextButton(
                    onPressed: _pickDate, child: const Text('Seleccionar'))
              ]),
              const Spacer(),
              ElevatedButton(onPressed: _save, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
