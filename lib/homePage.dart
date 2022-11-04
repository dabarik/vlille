import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                '',
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: Text("Station name"),
            ),
          ),
          DataColumn(
            label: Flexible(child: Text('Bikes')),
          ),
          DataColumn(
            label: Flexible(child: Text('Places')),
          ),
        ],
        rows: [],
    );
  }
}