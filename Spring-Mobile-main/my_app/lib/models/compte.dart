class Compte {
  final int? id;
  final double solde;
  final String dateCreation;
  final String type;

  Compte({
    required this.id,
    required this.solde,
    required this.dateCreation,
    required this.type,
  });

  factory Compte.fromJson(Map<String, dynamic> json) {
    return Compte(
      id: json['id'],
      solde: json['solde'].toDouble(),
      dateCreation: json['dateCreation'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'solde': solde,
      'dateCreation': dateCreation,
      'type': type,
    };
  }
}
