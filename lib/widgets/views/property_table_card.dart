import 'package:flutter/material.dart';
import 'package:wakeandshut/widgets/views/property_table.dart';

class PropertyTableCard extends StatelessWidget {
  final Map<String, dynamic> item;

  PropertyTableCard({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: PropertyTableView(item: item),
      ),
    );
  }
}
