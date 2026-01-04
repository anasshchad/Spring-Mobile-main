import 'package:flutter/material.dart';
import '../models/compte.dart';
import '../services/api_service.dart';

class AddComptePage extends StatefulWidget {
  @override
  _AddComptePageState createState() => _AddComptePageState();
}

class _AddComptePageState extends State<AddComptePage> {
  final _formKey = GlobalKey<FormState>();
  final _soldeController = TextEditingController();
  String _type = 'COURANT';
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un Compte')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Solde input
              TextFormField(
                controller: _soldeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Solde',
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Entrez un solde';
                  if (double.tryParse(value) == null) return 'Solde invalide';
                  return null;
                },
              ),
              SizedBox(height: 24),
              // Type radio buttons
              Card(
                color: Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('COURANT'),
                      value: 'COURANT',
                      groupValue: _type,
                      onChanged: (value) => setState(() => _type = value!),
                    ),
                    RadioListTile<String>(
                      title: Text('EPARGNE'),
                      value: 'EPARGNE',
                      groupValue: _type,
                      onChanged: (value) => setState(() => _type = value!),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final compte = Compte(
                      id : null,
                      solde: double.parse(_soldeController.text),
                      dateCreation: DateTime.now().toIso8601String().split('T')[0],
                      type: _type,
                    );
                    print('Compte to send: ${compte.toJson()}');
                    await apiService.createCompte(compte);
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
