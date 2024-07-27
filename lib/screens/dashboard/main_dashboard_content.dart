import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:home_vault/screens/components/file_reader_modal.dart';
import 'package:home_vault/screens/dashboard/components/custom_button.dart';
import 'package:home_vault/screens/dashboard/components/initial_intro_page.dart';
import 'package:home_vault/screens/dashboard/components/card_design.dart';
import 'package:home_vault/screens/dashboard/components/recent_files.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RenderDashboards extends StatefulWidget {
  const RenderDashboards({Key? key}) : super(key: key);

  @override
  _RenderDashboardsState createState() => _RenderDashboardsState();
}

class _RenderDashboardsState extends State<RenderDashboards> {
  List<Map<String, dynamic>> data = [];
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final accessToken = await storage.read(key: 'access_token');

      final headers = {
        'Authorization': 'Token $accessToken',
      };
      final response = await http.get(
        Uri.parse(
            'https://b6d9-115-98-217-224.ngrok-free.app/api/fetch_recent_data'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          data = List<Map<String, dynamic>>.from(responseData.map((item) => {
                'name': item['project_name'],
                'imageurl':
                    "https://b6d9-115-98-217-224.ngrok-free.app/static_media/download.jpeg",
                'area': item['street_name'],
                'price': item['expenses'],
                'projectID': item['records_id'],
              }));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.isNotEmpty) ...[
            IntroContextPage(),
            SizedBox(height: 50),
            RecentFiles(data: data)
          ] else ...[
            IntroContextPage(),
            SizedBox(height: 100),
            CustomCardWithButton(),
          ],
        ],
      ),
    );
  }
}
