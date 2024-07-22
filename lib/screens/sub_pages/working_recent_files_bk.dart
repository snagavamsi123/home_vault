// // // // working code
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:home_vault/responsive.dart';
// import 'package:home_vault/data/files_data.dart';
// import 'package:home_vault/screens/components/smallGrid.dart';
// import '../../../constants.dart';
// // import 'package:home_vault/screens/components/Files.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:visibility_detector/visibility_detector.dart';

// class AllFilesCardGridView extends StatelessWidget {
//   const AllFilesCardGridView({
//     Key? key,
//     this.crossAxisCount = 4,
//     this.childAspectRatio = 1,
//     required this.newFiles,
//   }) : super(key: key);

//   final int crossAxisCount;
//   final double childAspectRatio;
//   // final Map<String, dynamic> newFiles;
//   final List<Files> newFiles;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       // physics: AlwaysScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: newFiles.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: defaultPadding,
//         mainAxisSpacing: defaultPadding,
//         childAspectRatio: childAspectRatio,
//       ),
//       // itemBuilder: (context, index) => AllFilesCard(info: demoMyFiles[index]),
//       itemBuilder: (BuildContext context, int index) {
//         return SmallGridWIdgetPage(file: newFiles[index]);
//       },
//     );
//   }
// }

// // // // // working codeee
// class ReportsContent extends StatefulWidget {
//   @override
//   _ReportsContentState createState() => _ReportsContentState();
// }

// class _ReportsContentState extends State<ReportsContent> {
//   List<dynamic> jsonList = [];
//   List<DateWiseFiles> dateWiseFiles = [];
//   // List datesList = [];
//   List<String> datesList = [];

//   // ScrollController _scrollController = ScrollController();
//   int _pageNumber = 1;
//   bool _isLoading = false;
//   bool _isLastPage = false;
//   final int _pageSize = 3;
//   String _loadingText = '';

//   late Future<List<DateWiseFiles>> futureDateWiseFiles;

//   @override
//   void initState() {
//     super.initState();
//     futureDateWiseFiles = fetchData();
//     print('sdsadsasdsasdsasd');
//   }

//   void _updateLoadingText() {
//     print('_isLastPage_isLastPage $_isLastPage');
//     if (!_isLastPage) {
//       fetchData();
//       setState(() {
//         _loadingText = 'loading more records...';
//       });
//     } else {
//       setState(() {
//         _loadingText = 'No more records';
//       });
//     }
//   }

//   Future<List<DateWiseFiles>> fetchData() async {
//     print('@@@@@fncuncuncucn callalalalalall');
//     final response = await http.get(Uri.parse(
//         'http://10.0.2.2:9001/api/fetch_all_data?page=$_pageNumber&size=$_pageSize'));
//     // await http.get(Uri.parse('http://10.0.2.2:9001/api/fetch_all_data'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       final newFiles = DateWiseFiles.fromJsonList(jsonList);
//       if (newFiles.length > 0) {
//         setState(() {
//           print('dateWiseFilesdateWiseFiles ${dateWiseFiles}');
//           _pageNumber++;
//           dateWiseFiles.addAll(newFiles);
//           // for (var dateWiseFile in dateWiseFiles) {
//           //   if (!datesList.contains(dateWiseFile.date)) {
//           //     datesList.add(dateWiseFile.date);
//           //   }
//           // }
//           print('dateWiseFilesdateWiseFiles22222222 ${dateWiseFiles.length}');
//         });
//       } else {
//         _isLastPage = true;
//       }
//       return DateWiseFiles.fromJsonList(jsonList);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;

//     return FutureBuilder<List<DateWiseFiles>>(
//       future: futureDateWiseFiles,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           return Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: Column(
//                   children: [
//                     // for (var dateWiseFile in dateWiseFiles!)
//                     // if dateWiseFile.date not in datesList
//                     //   datesList.add(dateWiseFile.date);
//                     for (var dateWiseFile in dateWiseFiles!)
//                       Column(
//                         children: [
//                           if (!datesList.contains(dateWiseFile.date)) ...[
//                             Chip(
//                               backgroundColor: Colors.black38,
//                               label: Text(dateWiseFile.date),
//                             ),
//                           ],
//                           Container(
//                             child: Responsive(
//                               mobile: AllFilesCardGridView(
//                                 crossAxisCount: _size.width < 650 ? 2 : 4,
//                                 childAspectRatio: _size.width < 650 ? 1 : 1,
//                                 newFiles: dateWiseFile.filesData,
//                               ),
//                               tablet: AllFilesCardGridView(
//                                 newFiles: dateWiseFile.filesData,
//                               ),
//                               desktop: AllFilesCardGridView(
//                                 childAspectRatio:
//                                     _size.width < 1400 ? 1.1 : 1.4,
//                                 newFiles: dateWiseFile.filesData,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     VisibilityDetector(
//                       key: Key('loading-indicator'),
//                       onVisibilityChanged: (VisibilityInfo info) {
//                         if (info.visibleFraction > 0) {
//                           _updateLoadingText();
//                         }
//                       },
//                       child: Center(
//                         child: Text(_loadingText),
//                       ),
//                     ),
//                     //if this one is visible on screen then i want to call one function
//                   ],
//                 ),
//               ),
//             ],
//           );
//         } else {
//           return Center(child: Text('No data available'));
//         }
//       },
//     );
//   }
// }

// String _getIcon(String fileType, String file_url) {
//   switch (fileType.toLowerCase()) {
//     case 'jpg':
//     case 'jpeg':
//     case 'png':
//       return "http://10.0.2.2:9001$file_url";
//     // "assets/icons/media_file.svg";
//     case 'pdf':
//       return "assets/icons/pdf_file.svg";
//     case 'doc':
//     case 'docx':
//       return "assets/icons/doc_file.svg";
//     default:
//       return "assets/icons/unknown_file.svg"; // Default icon for unknown file types
//   }
// }

// class Files {
//   final String fileType;
//   final String fileName;
//   final String fileImage;
//   final String fileUrl;
//   final bool isFolder;

//   Files({
//     required this.fileType,
//     required this.fileName,
//     required this.fileImage,
//     required this.fileUrl,
//     required this.isFolder,
//   });
//   factory Files.fromJson(Map<String, dynamic> json) {
//     return Files(
//       fileType: json['file_type'],
//       fileName: json['filename'],
//       fileImage: _getIcon(
//         json['file_type'],
//         json['file_url'],
//       ),
//       fileUrl: "http://10.0.2.2:9001${json['file_url']}",
//       //
//       //  String formattedUrl = "http://10.0.2.2:9001${fileInfo.file_url}";
//       isFolder: false,
//     );
//   }
// }

// class DateWiseFiles {
//   final String date;
//   final List<Files> filesData;

//   DateWiseFiles({
//     required this.date,
//     required this.filesData,
//   });

//   // Static method to create a list of DateWiseFiles from a list of Maps
//   static List<DateWiseFiles> fromJsonList(List<dynamic> jsonList) {
//     Map<String, List<Files>> dateFilesMap = {};

//     for (var item in jsonList) {
//       Files file = Files.fromJson(item);
//       String date = item['created_at'].split(' ')[0];

//       if (dateFilesMap.containsKey(date)) {
//         dateFilesMap[date]!.add(file);
//       } else {
//         dateFilesMap[date] = [file];
//       }
//     }

//     List<DateWiseFiles> dateWiseFilesList = [];
//     dateFilesMap.forEach((date, files) {
//       dateWiseFilesList.add(DateWiseFiles(date: date, filesData: files));
//     });

//     return dateWiseFilesList;
//   }
// }
