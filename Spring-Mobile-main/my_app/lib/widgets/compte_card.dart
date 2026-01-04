import 'package:flutter/material.dart';
import '../models/compte.dart';

class CompteCard extends StatelessWidget {
  final Compte compte;
  final VoidCallback onDelete;
  final VoidCallback? onEdit; // <--- added edit callback

  const CompteCard({
    Key? key,
    required this.compte,
    required this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${compte.id}'),
            SizedBox(height: 8),
            Text('Solde: ${compte.solde.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Text('Type: ${compte.type}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onEdit != null)
                  ElevatedButton(
                    onPressed: onEdit,
                    child: Text('Modifier'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onDelete,
                  child: Text('Supprimer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
