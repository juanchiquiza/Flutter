import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_addresses_app/src/features/user/domain/entities/address.dart';
import 'package:user_addresses_app/src/features/user/presentation/providers/user_providers.dart';
import 'package:uuid/uuid.dart';

class AddressFormPage extends ConsumerStatefulWidget {
  final String userId;

  const AddressFormPage({super.key, required this.userId});

  @override
  ConsumerState<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _line = TextEditingController();
  String _country = 'Colombia';
  String _department = 'Cundinamarca';
  String _municipality = 'Bogotá';
  bool _isPhysical = false;

  final countries = ['Colombia', 'México'];
  final departments = {
    'Colombia': ['Cundinamarca', 'Antioquia'],
    'México': ['Ciudad de México']
  };
  final municipalities = {
    'Cundinamarca': ['Bogotá', 'Soacha'],
    'Antioquia': ['Medellín'],
    'Ciudad de México': ['CDMX']
  };

  @override
  void dispose() {
    _line.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() != true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Complete fields')));
      return;
    }
    final a = Address(
        id: const Uuid().v4(),
        userId: widget.userId,
        line: _line.text.trim(),
        country: _country,
        department: _department,
        municipality: _municipality,
        isPhysicalToAccount: _isPhysical);
    try {
      await ref.read(addAddressProvider).call(a);
      ref.invalidate(usersProvider);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Direccion guardada')));
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar direccion: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deps = departments[_country]!;
    final munis = municipalities[_department] ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar dirección')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
                controller: _line,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requerido' : null),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
                value: _country,
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() {
                      _country = v!;
                      _department = departments[_country]!.first;
                      _municipality = municipalities[_department]!.first;
                    }),
                decoration: const InputDecoration(labelText: 'País')),
            DropdownButtonFormField<String>(
                value: _department,
                items: deps
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() {
                      _department = v!;
                      _municipality = municipalities[_department]!.first;
                      ;
                    }),
                decoration: const InputDecoration(labelText: 'Departamento')),
            DropdownButtonFormField<String>(
                value: _municipality,
                items: munis
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _municipality = v!),
                decoration: const InputDecoration(labelText: 'Municipio')),
            CheckboxListTile(
                value: _isPhysical,
                onChanged: (v) => setState(() => _isPhysical = v ?? false),
                title: const Text('Física a mi cuenta')),
            const Spacer(),
            ElevatedButton(onPressed: _save, child: const Text('Guardar'))
          ]),
        ),
      ),
    );
  }
}
