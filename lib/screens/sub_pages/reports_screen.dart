import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:home_vault/screens/dashboard/components/header.dart';
import 'package:home_vault/screens/sub_pages/reports_content.dart';

class ReportsScreen extends StatefulWidget {
  @override
  ReportsScreenState createState() => ReportsScreenState();
}

class ReportsScreenState extends State<ReportsScreen> {
  Widget _currentContent = ReportsContent(); // Default content

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
