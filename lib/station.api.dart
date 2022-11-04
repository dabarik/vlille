import 'dart:convert';
import 'package:api_vliil/station.dart';
import 'package:http/http.dart' as http;


Future<List<Station>> fetchStation() async {
  final response = await http.get(Uri.https('opendata.lillemetropole.fr', '/api/records/1.0/search/', {"dataset": "vlille-realtime", "rows": "9999"}));
  
  Map data = jsonDecode(response.body);
  List _temp = [];

  for (var i in data["records"]){
    _temp.add(i['fields']);
  }

  return Station.stationFromSnapshot(_temp);
}
