// // working code
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RecentFiles extends StatefulWidget {
//   const RecentFiles({Key? key}) : super(key: key);

//   @override
//   _RecentFilesState createState() => _RecentFilesState();
// }

// class RecentFile {
//   final String? icon, title, date, size, file_url;

//   RecentFile({this.icon, this.title, this.date, this.size, this.file_url});
// }

// class _RecentFilesState extends State<RecentFiles> {
//   List<RecentFile> recentFiles = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   String _getIcon(String fileType) {
//     switch (fileType.toLowerCase()) {
//       case 'jpg':
//       case 'jpeg':
//       case 'png':
//         print('AAAAAAAAAA');
//         return "assets/icons/media_file.svg";
//       case 'pdf':
//         print('BBBBBBBBB');
//         return "assets/icons/pdf_file.svg";
//       case 'doc':
//       case 'docx':
//         print('VCCCCCC');
//         return "assets/icons/doc_file.svg";
//       // Add more cases for other file types as needed
//       default:
//         return "assets/icons/unknown_file.svg"; // Default icon for unknown file types
//     }
//   }

//   Future<void> fetchData() async {
//     final response =
//         await http.get(Uri.parse('https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/fetch_recent_data'));
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body);
//       print('Response Data: $responseData'); // Enhanced logging
//       setState(() {
//         recentFiles = responseData
//             .map((data) => RecentFile(
//                   title: data['filename'],
//                   icon: _getIcon(data['file_type']),
//                   // data['file_type'],
//                   date: data['created_at'],
//                   size: data['size'],
//                   file_url: data['file_url'],
//                 ))
//             .toList();
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Recent Files",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: isLoading
//                 ? Center(
//                     child:
//                         CircularProgressIndicator()) // Display a loading indicator while fetching data
//                 : DataTable(
//                     columnSpacing: defaultPadding,
//                     columns: [
//                       DataColumn(label: Text("File Name")),
//                       DataColumn(label: Text("Date")),
//                       DataColumn(label: Text("Size")),
//                     ],
//                     rows: recentFiles.map((file) {
//                       return recentFileDataRow(file);
//                     }).toList(),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// DataRow recentFileDataRow(RecentFile fileInfo) {
//   return  DataRow(

//     cells: [
//       DataCell(
//         Container(
//           width: 150, // Set maximum width here
//           child: Row(
//             children: [
//               if (fileInfo.icon != null)
//                 SvgPicture.asset(
//                   fileInfo.icon!,
//                   height: 30,
//                   width: 30,
//                 ),
//               SizedBox(width: 10), // Add spacing between icon and text
//               Flexible(
//                 child: Text(
//                   fileInfo.title ?? 'Unknown',
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           width: 100, // Set maximum width here
//           child: Text(
//             fileInfo.date ?? 'Unknown',
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           width: 100, // Set maximum width here
//           child: Text(
//             fileInfo.size ?? 'Unknown',
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RecentFiles extends StatefulWidget {
//   const RecentFiles({Key? key}) : super(key: key);

//   @override
//   _RecentFilesState createState() => _RecentFilesState();
// }

// class RecentFile {
//   final String? icon, title, date, size, file_url;

//   RecentFile({this.icon, this.title, this.date, this.size, this.file_url});
// }

// class _RecentFilesState extends State<RecentFiles> {
//   List<RecentFile> recentFiles = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   String _getIcon(String fileType) {
//     switch (fileType.toLowerCase()) {
//       case 'jpg':
//       case 'jpeg':
//       case 'png':
//         return "assets/icons/media_file.svg";
//       case 'pdf':
//         return "assets/icons/pdf_file.svg";
//       case 'doc':
//       case 'docx':
//         return "assets/icons/doc_file.svg";
//       default:
//         return "assets/icons/unknown_file.svg"; // Default icon for unknown file types
//     }
//   }

//   Future<void> fetchData() async {
//     final response =
//         await http.get(Uri.parse('https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/fetch_recent_data'));
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body);
//       setState(() {
//         recentFiles = responseData
//             .map((data) => RecentFile(
//                   title: data['filename'],
//                   icon: _getIcon(data['file_type']),
//                   date: data['created_at'],
//                   size: data['size'],
//                   file_url: data['file_url'],
//                 ))
//             .toList();
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Recent Files",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: isLoading
//                 ? Center(
//                     child:
//                         CircularProgressIndicator()) // Display a loading indicator while fetching data
//                 : DataTable(
//                     columnSpacing: defaultPadding,
//                     columns: [
//                       DataColumn(label: Text("File Name")),
//                       DataColumn(label: Text("Date")),
//                       DataColumn(label: Text("Size")),
//                     ],
//                     rows: recentFiles.map((file) {
//                       return recentFileDataRow(context, file);
//                     }).toList(),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// DataRow recentFileDataRow(BuildContext context, RecentFile fileInfo) {
//   return DataRow(
//     onSelectChanged: (bool? selected) {
//       if (selected != null && selected) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text(fileInfo.title ?? 'Unknown'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (fileInfo.file_url != null &&
//                       (fileInfo.file_url!.endsWith('.jpg') ||
//                           fileInfo.file_url!.endsWith('.jpeg') ||
//                           fileInfo.file_url!.endsWith('.png')))
//                     Image.network(fileInfo.file_url!),
//                   if (fileInfo.file_url != null &&
//                       fileInfo.file_url!.endsWith('.pdf'))
//                     Text("PDF file cannot be displayed in the modal."),
//                   // Add more cases for different file types if needed
//                   if (fileInfo.file_url != null &&
//                       !(fileInfo.file_url!.endsWith('.jpg') ||
//                           fileInfo.file_url!.endsWith('.jpeg') ||
//                           fileInfo.file_url!.endsWith('.png') ||
//                           fileInfo.file_url!.endsWith('.pdf')))
//                     Text("Preview not available for this file type."),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("Close"),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     },
//     cells: [
//       DataCell(
//         Container(
//           width: 150, // Set maximum width here
//           child: Row(
//             children: [
//               if (fileInfo.icon != null)
//                 SvgPicture.asset(
//                   fileInfo.icon!,
//                   height: 30,
//                   width: 30,
//                 ),
//               SizedBox(width: 10), // Add spacing between icon and text
//               Flexible(
//                 child: Text(
//                   fileInfo.title ?? 'Unknown',
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           width: 100, // Set maximum width here
//           child: Text(
//             fileInfo.date ?? 'Unknown',
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           width: 100, // Set maximum width here
//           child: Text(
//             fileInfo.size ?? 'Unknown',
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// third one popup working wala
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:home_vault/screens/components/file_reader_modal.dart';
//
//

class RecentFiles extends StatefulWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  _RecentFilesState createState() => _RecentFilesState();
}

class RecentFile {
  final String? icon, title, date, size, file_url;

  RecentFile({this.icon, this.title, this.date, this.size, this.file_url});
}

class _RecentFilesState extends State<RecentFiles> {
  List<RecentFile> recentFiles = [];
  bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  late final IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    fetchData();
    // Connect to WebSocket server
    channel = IOWebSocketChannel.connect('ws://10.0.2.2:9001/ws/recent_data');
    // Listen for messages
    channel.stream.listen((message) {
      // Handle message
      setState(() {
        recentFiles = (json.decode(message) as List)
            .map((data) => RecentFile(
                  title: data['filename'],
                  icon: _getIcon(data['file_type']),
                  date: data['created_at'],
                  size: data['size'],
                  file_url: data['file_url'],
                ))
            .toList();

        print('recentFielesss $recentFiles');
        isLoading = false;
      });
    });
  }

  // void recent_refresh() {
  //   setState(() {});
  // }

  String _getIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return "assets/icons/media_file.svg";
      case 'pdf':
        return "assets/icons/pdf_file.svg";
      case 'doc':
      case 'docx':
        return "assets/icons/doc_file.svg";
      default:
        return "assets/icons/unknown_file.svg"; // Default icon for unknown file types
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/fetch_recent_data'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        recentFiles = responseData
            .map((data) => RecentFile(
                  title: data['filename'],
                  icon: _getIcon(data['file_type']),
                  date: data['created_at'],
                  size: data['size'],
                  file_url: data['file_url'],
                ))
            .toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : DataTable(
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(label: Text("File Name")),
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Size")),
                    ],
                    rows: recentFiles.map((file) {
                      return recentFileDataRow(context, file);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(BuildContext context, RecentFile fileInfo) {
  String formattedUrl =
      "https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app${fileInfo.file_url}";
  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () {
            showFilePreviewDialog(context, fileInfo.title, formattedUrl);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: Text(fileInfo.title ?? 'Unknown'),
            //       content: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           if (fileInfo.file_url != null &&
            //               (fileInfo.file_url!.endsWith('.jpg') ||
            //                   fileInfo.file_url!.endsWith('.jpeg') ||
            //                   fileInfo.file_url!.endsWith('.png')))
            //             Image.network(formattedUrl),
            //           if (fileInfo.file_url != null &&
            //               fileInfo.file_url!.endsWith('.pdf'))
            //             Container(
            //               width: double.maxFinite,
            //               height: 400,
            //               child: SfPdfViewer.network(formattedUrl),
            //             ),

            //           // Text("PDF file cannot be displayed in the modal."),
            //           // Add more cases for different file types if needed
            //           if (fileInfo.file_url != null &&
            //               !(fileInfo.file_url!.endsWith('.jpg') ||
            //                   fileInfo.file_url!.endsWith('.jpeg') ||
            //                   fileInfo.file_url!.endsWith('.png') ||
            //                   fileInfo.file_url!.endsWith('.pdf')))
            //             Text("Preview not available for this file type."),
            //         ],
            //       ),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: Text("Close"),
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
          child: Container(
            width: 150, // Set maximum width here
            child: Row(
              children: [
                if (fileInfo.icon != null)
                  SvgPicture.asset(
                    fileInfo.icon!,
                    height: 30,
                    width: 30,
                  ),
                SizedBox(width: 10), // Add spacing between icon and text
                Flexible(
                  child: Text(
                    fileInfo.title ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      DataCell(
        Container(
          width: 100, // Set maximum width here
          child: Text(
            fileInfo.date ?? 'Unknown',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Container(
          width: 100, // Set maximum width here
          child: Text(
            fileInfo.size ?? 'Unknown',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}
