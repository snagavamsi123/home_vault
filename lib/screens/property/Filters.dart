import 'package:flutter/material.dart';
import 'package:home_vault/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_vault/screens/property/PropertiesDataTable.dart';
import 'package:home_vault/screens/property/propertyPage2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FiltersPage extends StatefulWidget {
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  RangeValues priceRange = RangeValues(0, 10000);
  RangeValues mileageRange = RangeValues(0, 10000);
  DateTimeRange? _selectedDateRange;
  String? selectedType;
  String? selectedYear;
  String? enteredName;
  List<DataModel> _data = [];
  final TextEditingController nameController = TextEditingController();

  Future<bool> SearchDetails() async {
    print('calling verify aopiiiipipipi');
    final verifyUrl =
        'https://b6d9-115-98-217-224.ngrok-free.app/api/search_details/';

    final Map<String, dynamic> enteredData = {
      'name': nameController.text,
      'type': selectedType,
      'year': selectedYear,
      'price_range': {
        'min': priceRange.start.round(),
        'max': priceRange.end.round(),
      },
      'mileage_range': {
        'min': mileageRange.start.round(),
        'max': mileageRange.end.round(),
      },
      'date_range': _selectedDateRange != null
          ? {
              'start': _selectedDateRange!.start.toIso8601String(),
              'end': _selectedDateRange!.end.toIso8601String(),
            }
          : null,
    };
    final storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'access_token');

    final response = await http.post(
      Uri.parse(verifyUrl),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token $accessToken",
      },
      body: jsonEncode(enteredData),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print('message--->> $jsonData');

      final dataList = jsonData['data'] as List<dynamic>;
      final List<DataModel> newData =
          dataList.map((item) => DataModel.fromJson(item)).toList();

      setState(() {
        _data = newData;
      });
      return true;
    } else {
      print('Error: ${response.statusCode}');
      return false;
    }

    // if (response.statusCode == 200) {
    //   print('Success');
    //   return true;
    // } else {
    //   print('Error: ${response.statusCode}');
    //   return false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Name to search',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              items: ['Select option', '1BHK', '2BHK', '3BHK', '4BHK']
                  .map((make) => DropdownMenuItem(
                        value: make,
                        child: Text(make),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
              items: [
                'Any Year',
                '2024',
                '2023',
                '2022',
                '2021',
                '2020',
                '2019',
                '2018',
                '2017',
                '2016'
              ]
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  initialDateRange: _selectedDateRange,
                );

                if (picked != null) {
                  setState(() {
                    _selectedDateRange = picked;
                  });
                }
              },
              child: Text('Select Date Range'),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: EdgeInsets.all(16),
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_selectedDateRange != null)
              Text(
                'Selected Range: ${_selectedDateRange!.start.toString()} - ${_selectedDateRange!.end.toString()}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Text('Price'),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 10000,
              divisions: 20,
              labels: RangeLabels(
                '\$${priceRange.start.round()}',
                '\$${priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$0 - \$5,000'),
                Text('\$5,000 - \$10,000'),
              ],
            ),
            SizedBox(height: 20),
            // Text('Mileage'),
            // RangeSlider(
            //   values: mileageRange,
            //   min: 0,
            //   max: 10000,
            //   divisions: 20,
            //   labels: RangeLabels(
            //     '${mileageRange.start.round()} mi',
            //     '${mileageRange.end.round()} mi',
            //   ),
            //   onChanged: (RangeValues values) {
            //     setState(() {
            //       mileageRange = values;
            //     });
            //   },
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('0 - 5,000'),
            //     Text('5,000 - 10,000'),
            //   ],
            // ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool success = await SearchDetails();
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Search successful')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Search failed')),
                      );
                    }
                  },
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            if (_data.isNotEmpty)
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
          ],
        ),
      ),
    );
  }
}
