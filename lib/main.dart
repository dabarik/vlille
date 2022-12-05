import 'dart:convert';
import 'dart:ffi';
import 'package:api_vliil/favPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_vliil/station.dart';
import 'package:api_vliil/station.api.dart';
import 'detailPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = "V'Lille";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late final List<Station> _stations;
  late List<int> favStation = [];

  @override
  void initState() {
    super.initState();
    getStations();
    favStation.clear();
    loadData();
  }

  Future<void> getStations() async {
    _stations = await fetchStation();
    setState(() {});
  }

  late List<Station> display_list = List.from(_stations);

  void updateList(String value) {
    setState(() {
      display_list = _stations
          .where((element) =>
              element.nom.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempo = prefs.getStringList("station_key") ?? [];

    favStation = tempo.map((e) => int.parse(e)).toList();
  }

  _addFavStation(int libelle) async {
    setState(() {
      favStation.add(libelle);
    });
    _saveFavStation();
  }

  _removeFavStation(int libelle) {
    setState(() {
      favStation.remove(libelle);
    });
    _saveFavStation();
  }

  _saveFavStation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempo = favStation.map((e) => e.toString()).toList();
    prefs.setStringList('station_key', tempo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("V'Lille"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => favPage(
                          display_list: display_list,
                          favStation: favStation,
                        )));
              },
              icon: const Icon(Icons.favorite_border),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recherche d'une station : ",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: ((value) => updateList(value)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFE0E0E0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    hintText: "ex : Euratechnologies"),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: display_list.isEmpty
                      ? const Center(
                          child: Text(
                            "Aucun résultat",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: display_list.length,
                          itemBuilder: ((context, index) {
                            if (display_list[index].etat == "EN SERVICE") {
                              return SizedBox(
                                  width: 200,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.blue,
                                      elevation: 10,
                                      child: InkWell(
                                        onTap: (() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailPage(
                                                        longitude:
                                                            display_list[index]
                                                                .longitude,
                                                        latitude:
                                                            display_list[index]
                                                                .latitude,
                                                        nom: display_list[index]
                                                            .nom,
                                                      )));
                                        }),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(8.0),
                                                  leading: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.0),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(favStation
                                                            .contains(
                                                                display_list[
                                                                        index]
                                                                    .libelle)
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border),
                                                    color: favStation.contains(
                                                            display_list[index]
                                                                .libelle)
                                                        ? Colors.red
                                                        : Colors.white70,
                                                    iconSize: 25,
                                                    onPressed: () {
                                                      if (favStation.contains(
                                                          display_list[index]
                                                              .libelle)) {
                                                        _removeFavStation(
                                                            display_list[index]
                                                                .libelle);
                                                      } else {
                                                        _addFavStation(
                                                            display_list[index]
                                                                .libelle);
                                                      }
                                                    },
                                                  ),
                                                  title: Text(
                                                      display_list[index].nom,
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'Nombre de place disponible : ${display_list[index].nbplacesdispo}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                      Text(
                                                          'Nombre de vélos disponibles : ${display_list[index].nbvelosdispo}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white))
                                                    ],
                                                  )),
                                            ]),
                                      )));
                            } else {
                              return const SizedBox();
                            }
                          }),
                        )),
            ],
          ),
        ));
  }
}
