import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          _createDataTable(),
          Container(
            
          )
        ],
    );
  }

  DataTable _createDataTable(){
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns(){
    return [
      DataColumn(label: Text('Station name')),
      DataColumn(label: Text('Bikes')),
      DataColumn(label: Text('Places'))
    ];
  }

  List<DataRow> _createRows(){
    return[
      
    ];
  }
}