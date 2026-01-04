import 'package:flutter/material.dart';
import '../models/compte.dart';
import '../services/api_service.dart';

class UpdateComptePage extends StatefulWidget {
  final Compte compte;

  UpdateComptePage({required this.compte});

  @override
  _UpdateComptePageState createState() => _UpdateComptePageState();
}

class _UpdateComptePageState extends State<UpdateComptePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _soldeController;
  late String _type;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _soldeController = TextEditingController(text: widget.compte.solde.toString());
    _type = widget.compte.type;
  }

  @override
  void dispose() {
    _soldeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier le Compte')),
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
                    final updatedCompte = Compte(
                      id: widget.compte.id,  // keep the existing ID
                      solde: double.parse(_soldeController.text),
                      dateCreation: widget.compte.dateCreation,
                      type: _type,
                    );

                    await apiService.updateCompte(updatedCompte); // your API method for updating
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Mettre à jour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
