import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:home_vault/screens/dashboard/components/header.dart';
import 'package:home_vault/screens/property/PropertiesDataTable.dart';

class PropertyList extends StatefulWidget {
  @override
  PropertyListState createState() => PropertyListState();
}

class PropertyListState extends State<PropertyList> {
  Widget _currentContent = PaginatedDataTableView(); 

  void updateContent(Widget content) {
    setState(() {
      _currentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            _currentContent,
          ],
        ),
      ),
    );
  }
}
