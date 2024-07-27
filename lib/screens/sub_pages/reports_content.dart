// // // working code
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:home_vault/responsive.dart';
import 'package:home_vault/data/files_data.dart';
import 'package:home_vault/screens/components/smallGrid.dart';
import '../../../constants.dart';
import 'package:home_vault/screens/components/Files.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:intl/intl.dart';

class AllFilesCardGridView extends StatelessWidget {
  const AllFilesCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.newFiles,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  // final Map<String, dynamic> newFiles;
  final List<Files> newFiles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      // physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: newFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      // itemBuilder: (context, index) => AllFilesCard(info: demoMyFiles[index]),
      itemBuilder: (BuildContext context, int index) {
        return SmallGridWIdgetPage(file: newFiles[index]);
      },
    );
  }
}

// // // // working codeee
class ReportsContent extends StatefulWidget {
  @override
  _ReportsContentState createState() => _ReportsContentState();
}

class _ReportsContentState extends State<ReportsContent> {
  List<dynamic> jsonList = [];
  List<DateWiseFiles> dateWiseFiles = [];
  // List datesList = [];
  List<String> datesList = [];

  // ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  // DateTime _startingDate = DateTime.now();
  String _formattedDate = '';
  bool isLastRow = false;
  num _datacounter = 0;

  bool _isLoading = false;
  bool _isLastPage = false;
  final int _pageSize = 3;
  String _loadingText = '';

  late Future<List<DateWiseFiles>> futureDateWiseFiles;

  @override
  void initState() {
    super.initState();
    futureDateWiseFiles = fetchData();
    print('sdsadsasdsasdsasd');
  }

  void _updateLoadingText() {
    print('_isLastPage_isLastPage $_isLastPage');
    if (!_isLastPage) {
      fetchData();
      setState(() {
        _loadingText = 'loading more records...';
      });
    } else {
      setState(() {
        _loadingText = 'No more records';
      });
    }
  }

  Future<List<DateWiseFiles>> fetchData() async {
    print('@@@@@fncuncuncucn callalalalalall $_formattedDate  $_datacounter');
    final response = await http.get(Uri.parse(
        'https://b6d9-115-98-217-224.ngrok-free.app/api/fetch_all_data?date=$_formattedDate&counter=$_datacounter'));
    // await http.get(Uri.parse('https://b6d9-115-98-217-224.ngrok-free.app/api/fetch_all_data'));
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);

      print('jsonListjsonList $jsonList');
      final resp_status = jsonList['status'];
      print('resp_statusresp_status ${resp_status}');
      final resp_data;
      if (resp_status == 'success') {
        resp_data = jsonList['data'];
      } else {
        resp_data = [];
      }

      _formattedDate = jsonList["most_recent_date"];
      _isLastPage = jsonList["last_page"];
      print('_formattedDate_formattedDate  $_formattedDate $_isLastPage');
      _datacounter = _datacounter + resp_data.length;

      final newFiles = DateWiseFiles.fromJsonList(resp_data);
      if (newFiles.length > 0) {
        setState(() {
          print('dateWiseFilesdateWiseFiles ${dateWiseFiles}');
          _pageNumber++;
          dateWiseFiles.addAll(newFiles);
          // for (var dateWiseFile in dateWiseFiles) {
          //   if (!datesList.contains(dateWiseFile.date)) {
          //     datesList.add(dateWiseFile.date);
          //   }
          // }
          print('dateWiseFilesdateWiseFiles22222222 ${dateWiseFiles.length}');
        });
      } else {
        // _isLastPage = true;
      }
      return DateWiseFiles.fromJsonList(resp_data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return FutureBuilder<List<DateWiseFiles>>(
      future: futureDateWiseFiles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // for (var dateWiseFile in dateWiseFiles!)
                    // if dateWiseFile.date not in datesList
                    //   datesList.add(dateWiseFile.date);
                    for (var dateWiseFile in dateWiseFiles!)
                      Column(
                        children: [
                          if (!datesList.contains(dateWiseFile.date)) ...[
                            Chip(
                              backgroundColor: Colors.black38,
                              label: Text(dateWiseFile.date),
                            ),
                          ],
                          Container(
                            child: Responsive(
                              mobile: AllFilesCardGridView(
                                crossAxisCount: _size.width < 650 ? 2 : 4,
                                childAspectRatio: _size.width < 650 ? 1 : 1,
                                newFiles: dateWiseFile.filesData,
                              ),
                              tablet: AllFilesCardGridView(
                                newFiles: dateWiseFile.filesData,
                              ),
                              desktop: AllFilesCardGridView(
                                childAspectRatio:
                                    _size.width < 1400 ? 1.1 : 1.4,
                                newFiles: dateWiseFile.filesData,
                              ),
                            ),
                          ),
                        ],
                      ),
                    VisibilityDetector(
                      key: Key('loading-indicator'),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleFraction > 0) {
                          _updateLoadingText();
                        }
                      },
                      child: Center(
                        child: Text(_loadingText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}


// // scrollbar infinite one
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:home_vault/responsive.dart';
// // import 'package:home_vault/data/files_data.dart';
// // import 'package:home_vault/screens/components/smallGrid.dart';
// // import '../../../constants.dart';
// // import 'package:home_vault/screens/components/Files.dart';
// // import 'package:http/http.dart' as http;

// // class AllFilesCardGridView extends StatelessWidget {
// //   const AllFilesCardGridView({
// //     Key? key,
// //     this.crossAxisCount = 4,
// //     this.childAspectRatio = 1,
// //     required this.newFiles,
// //     required this.scrollController,
// //   }) : super(key: key);

// //   final int crossAxisCount;
// //   final double childAspectRatio;
// //   final dynamic scrollController;
// //   final List<Files> newFiles;

// //   @override
// //   Widget build(BuildContext context) {
// //     return GridView.builder(
// //       controller: scrollController,
// //       physics: NeverScrollableScrollPhysics(),
// //       shrinkWrap: true,
// //       itemCount: newFiles.length,
// //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: crossAxisCount,
// //         crossAxisSpacing: defaultPadding,
// //         mainAxisSpacing: defaultPadding,
// //         childAspectRatio: childAspectRatio,
// //       ),
// //       itemBuilder: (BuildContext context, int index) {
// //         return SmallGridWIdgetPage(file: newFiles[index]);
// //       },
// //     );
// //   }
// // }

// // class ReportsContent extends StatefulWidget {
// //   @override
// //   _ReportsContentState createState() => _ReportsContentState();
// // }

// // class _ReportsContentState extends State<ReportsContent> {
// //   List<DateWiseFiles> dateWiseFiles = [];
// //   ScrollController _scrollController = ScrollController();
// //   int _pageNumber = 0;
// //   bool _isLoading = false;
// //   final int _pageSize = 20;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchData();
// //     _scrollController.addListener(_scrollListener);
// //   }

// //   void _scrollListener() {
// //     if (_scrollController.position.pixels >=
// //             _scrollController.position.maxScrollExtent * 0.7 &&
// //         !_isLoading) {
// //       _fetchData();
// //     }
// //   }

// //   Future<void> _fetchData() async {
// //     if (_isLoading) return;
// //     setState(() {
// //       _isLoading = false;
// //     });
// //     try {
// //       final response = await http.get(Uri.parse(
// //           'https://b6d9-115-98-217-224.ngrok-free.app/api/fetch_all_data?page=$_pageNumber&size=$_pageSize'));
// //       if (response.statusCode == 200) {
// //         final List<dynamic> jsonList = json.decode(response.body);
// //         final newFiles = DateWiseFiles.fromJsonList(jsonList);
// //         setState(() {
// //           _isLoading = false;
// //         });
// //         setState(() {
// //           _pageNumber++;
// //           dateWiseFiles.addAll(newFiles);
// //         });
// //       } else {
// //         throw Exception('Failed to load data');
// //       }
// //     } catch (e) {
// //       // Handle error
// //       print(e);
// //     } finally {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final Size _size = MediaQuery.of(context).size;

// //     return FutureBuilder<void>(
// //       future: _fetchData(),
// //       builder: (context, snapshot) {
// //         if (_isLoading && dateWiseFiles.isEmpty) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (snapshot.hasError && dateWiseFiles.isEmpty) {
// //           return Center(child: Text('Error: ${snapshot.error}'));
// //         } else {
// //           return Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Expanded(
// //                 flex: 5,
// //                 child: Column(
// //                   children: [
// //                     for (var dateWiseFile in dateWiseFiles)
// //                       Column(
// //                         children: [
// //                           Chip(
// //                             backgroundColor: Colors.black38,
// //                             label: Text(dateWiseFile.date),
// //                           ),
// //                           Container(
// //                             child: Responsive(
// //                               mobile: AllFilesCardGridView(
// //                                   crossAxisCount: _size.width < 650 ? 2 : 4,
// //                                   childAspectRatio: _size.width < 650 ? 1 : 1,
// //                                   newFiles: dateWiseFile.filesData,
// //                                   scrollController: _scrollController),
// //                               tablet: AllFilesCardGridView(
// //                                   newFiles: dateWiseFile.filesData,
// //                                   scrollController: _scrollController),
// //                               desktop: AllFilesCardGridView(
// //                                   childAspectRatio:
// //                                       _size.width < 1400 ? 1.1 : 1.4,
// //                                   newFiles: dateWiseFile.filesData,
// //                                   scrollController: _scrollController),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     if (_isLoading) Center(child: CircularProgressIndicator()),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         }
// //       },
// //     );
// //   }
// // }




