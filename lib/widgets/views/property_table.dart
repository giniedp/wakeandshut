import 'dart:typed_data';

import 'package:flutter/material.dart';

class PropertyTableView extends StatelessWidget {
  final Map<String, dynamic> item;

  PropertyTableView({@required this.item});

  Table _buildTable(BuildContext context, Map<String, dynamic> data) {
    return Table(
      columnWidths: {
        0: IntrinsicColumnWidth(),
      },
      children: data == null
          ? []
          : data.entries.map((entry) {
              return _buildTableRow(context, entry.key, entry.value);
            }).toList(),
    );
  }

  TableRow _buildTableRow(BuildContext context, String key, dynamic value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 2, 16, 2),
        child: Text(key,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right),
      ),
      _buildValueView(context, value),
    ]);
  }

  Widget _buildValueView(BuildContext context, dynamic val) {
    if (val == null) {
      return Text('');
    }
    if (val is String) {
      return Text(val);
    }
    if (val is Uint8List) {
      return Text(String.fromCharCodes(val));
    }
    if (val is Map) {
      return _buildTable(context, val);
    }

    return Text(val.toString());
  }

  @override
  Widget build(BuildContext context) {
    return _buildTable(context, item);
  }
}
