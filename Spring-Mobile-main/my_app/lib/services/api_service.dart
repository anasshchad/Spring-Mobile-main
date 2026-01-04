import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/compte.dart';

class ApiService {
  static const String baseUrl = "http://(ipconfig -> ur ip address):8082/banque";



  // GET all comptes
  Future<List<Compte>> fetchComptes() async {
    final response = await http.get(Uri.parse('$baseUrl/comptes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Compte.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comptes');
    }
  }

  // GET compte by ID
  Future<Compte> fetchCompteById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/comptes/$id'));
    if (response.statusCode == 200) {
      return Compte.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Compte not found');
    }
  }

  // POST new compte
  Future<Compte> createCompte(Compte compte) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comptes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(compte.toJson()),
    );
    

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Compte.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create compte');
    }
  }

Future<void> updateCompte(Compte compte) async {
  final response = await http.put(
    Uri.parse('$baseUrl/comptes/${compte.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(compte.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update compte');
  }
}


  // DELETE compte
  Future<void> deleteCompte(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/comptes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete compte');
    }
  }
}
