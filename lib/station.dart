class Station {
  final String nom;
  final int nbvelosdispo;
  final int nbplacesdispo;
  final String etat;
  final double latitude;
  final double longitude;

  Station({
    required this.nom,
    required this.nbvelosdispo,
    required this.nbplacesdispo,
    required this.etat,
    required this.latitude,
    required this.longitude
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      nom: json['nom'] as String,
      nbvelosdispo: json['nbvelosdispo'] as int,
      nbplacesdispo: json['nbplacesdispo'] as int,
      etat: json['etat'] as String,
      latitude: json['localisation'][0] as double,
      longitude: json['localisation'][1] as double,
    );
  }

  static List<Station> stationFromSnapshot(List snapshot){
    return snapshot.map((data){
      return Station.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Station {nom: $nom, nbvelosdispo: $nbvelosdispo, nbplacesdispo: $nbplacesdispo, etat: $etat, latitude: $latitude, longitude: $longitude}';
  }
}
