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

class RecentFiles extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const RecentFiles({Key? key, required this.data}) : super(key: key);

  @override
  _RecentFilesState createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  bool isLoading = false;

  late final IOWebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Details",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        var item = widget.data[index];
                        return CardHorizontal(
                          key: Key(index.toString()),
                          imageUrl: item['imageurl'] ?? 'Unknown',
                          title: item['name'] ?? 'Unknown',
                          area: item['area'] ?? 'Unknown',
                          projectID: item['projectID'] ?? 'Unknown',
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
