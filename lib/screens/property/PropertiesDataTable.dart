import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_vault/screens/property/propertyPage.dart';
import 'package:home_vault/screens/property/propertyPage2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataModel {
  final int id;
  final String uuid;
  final String recordsId;
  final String projectName;
  final String streetName;
  final String houseNumber;
  final String expenses;
  final String description;
  final String dateOfRenovation;
  final String createdAt;
  final bool isSaved;
  final bool isActive;
  final String createdUsername;
  final int createdBy;

  DataModel({
    required this.id,
    required this.uuid,
    required this.recordsId,
    required this.projectName,
    required this.streetName,
    required this.houseNumber,
    required this.expenses,
    required this.description,
    required this.dateOfRenovation,
    required this.createdAt,
    required this.isSaved,
    required this.isActive,
    required this.createdUsername,
    required this.createdBy,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      uuid: json['uuid'],
      recordsId: json['records_id'],
      projectName: json['project_name'],
      streetName: json['street_name'],
      houseNumber: json['house_number'],
      expenses: json['expenses'],
      description: json['description'],
      dateOfRenovation: json['date_of_renovation'],
      createdAt: json['created_at'],
      isSaved: json['is_saved'],
      isActive: json['is_active'],
      createdUsername: json['created_username'],
      createdBy: json['created_by'],
    );
  }
}

class PaginatedDataTableView extends StatefulWidget {
  const PaginatedDataTableView({super.key});

  @override
  State<PaginatedDataTableView> createState() => _PaginatedDataTableViewState();
}

class _PaginatedDataTableViewState extends State<PaginatedDataTableView> {
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 1;
  List<DataModel> _data = [];
  bool _isLoading = false;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final accessToken = await storage.read(key: 'access_token');
    final headers = {
      "Authorization": "Token $accessToken",
    };

    final response = await http.get(
        Uri.parse(
            'https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/fetch_data_pagination?page=$_currentPage&size=$_pageSize'),
        headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final dataList = jsonData['data'] as List<dynamic>;
      final List<DataModel> newData =
          dataList.map((item) => DataModel.fromJson(item)).toList();

      setState(() {
        _data = newData;
        _totalPages = jsonData['total_pages'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

  void _loadMoreData() {
    if (!_isLoading && _currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
      fetchData();
    }
  }

  void _loadPreviousData() {
    if (!_isLoading && _currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: 550), // Set the minimum height here
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Project Name')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('View')),
                        ],
                        rows: _data
                            .map(
                              (item) => DataRow(
                                cells: [
                                  DataCell(Text(item.projectName)),
                                  DataCell(Text(item.dateOfRenovation)),
                                  DataCell(IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PropertyDetailsPage(
                                                  projectID: item.recordsId),
                                        ),
                                      );
                                      // ImagePreviewScreen(imageUrl: imageFile.path),
                                      // Implement view functionality here
                                      //
                                    },
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: _currentPage > 1 ? _loadPreviousData : null,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text('Page $_currentPage of $_totalPages'),
                      SizedBox(
                        width: 100,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed:
                            _currentPage < _totalPages ? _loadMoreData : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
