import 'dart:async';
import 'package:flutter/material.dart';
import 'package:api_vliil/main.dart';
import 'package:api_vliil/station.dart';
import 'package:api_vliil/detailPage.dart';

class favPage extends StatelessWidget {
  final List<int> favStation;
  final List<Station> display_list;

  favPage({required this.favStation, required this.display_list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Page des favoris")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: display_list.length,
                itemBuilder: ((context, index) {
                  if (display_list[index].etat == "EN SERVICE") {
                    for (var i = 0; i < favStation.length; i++) {
                      if (display_list[index].libelle == favStation[i]) {
                        return SizedBox(
                            width: 200,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.blue,
                                elevation: 10,
                                child: InkWell(
                                  onTap: (() {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => detailPage(
                                                  longitude: display_list[index]
                                                      .longitude,
                                                  latitude: display_list[index]
                                                      .latitude,
                                                  nom: display_list[index].nom,
                                                )));
                                  }),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(8.0),
                                            leading: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
                                            ),
                                            trailing: IconButton(
                                                icon: Icon(favStation.contains(
                                                        display_list[index]
                                                            .libelle)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border),
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
                                                    favStation.remove(
                                                        display_list[index]
                                                            .libelle);
                                                  } else {
                                                    favStation.removeAt(
                                                        display_list[index]
                                                            .libelle);
                                                  }
                                                }),
                                            title: Text(display_list[index].nom,
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    'Nombre de place disponible : ${display_list[index].nbplacesdispo}',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                                Text(
                                                    'Nombre de vélos disponibles : ${display_list[index].nbvelosdispo}',
                                                    style: const TextStyle(
                                                        color: Colors.white))
                                              ],
                                            )),
                                      ]),
                                )));
                      }
                    }
                    return const SizedBox();
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
