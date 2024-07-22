// import 'package:flutter/material.dart';
// import 'package:home_vault/screens/components/Files.dart';
// // import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_file_view/flutter_file_view.dart';

// // import 'package:home_vault/Screen/Home.dart';

// class SmallGridWIdget extends StatelessWidget {
//   // This widget is the root of your application.
//   SmallGridWIdget({Key? key, required this.file}) : super(key: key);

//   Files file;
//   @override
//   Widget build(BuildContext context) {
//     return SmallGridWIdgetPage(
//       file: file,
//     );
//   }
// }

// class SmallGridWIdgetPage extends StatefulWidget {
//   SmallGridWIdgetPage({Key? key, required this.file}) : super(key: key);

//   Files file;

//   @override
//   _SmallGridWIdgetPageState createState() => _SmallGridWIdgetPageState();
// }

// class _SmallGridWIdgetPageState extends State<SmallGridWIdgetPage> {
//   @override
//   Widget build(BuildContext context) {
//     print('hellooo hahahahah ${widget.file.fileImage}');
//     return Container(
//         padding: EdgeInsets.only(
//           left: 10,
//           right: 10,
//         ),
//         child: Container(
//           height: 290,
//           padding: EdgeInsets.only(bottom: 5, top: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               widget.file.isFolder
//                   ? Container(
//                       margin: EdgeInsets.only(top: 20),
//                       height: 100,
//                       child: Container(
//                           padding: EdgeInsets.only(
//                               top: 5, left: 20, right: 20, bottom: 10),
//                           child: Icon(
//                             Icons.folder,
//                             size: 120,
//                             color: Colors.grey[500],
//                           )),
//                     )
//                   : Container(
//                       margin: EdgeInsets.only(top: 20),
//                       height: 100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.grey[200]),
//                       child: Container(
//                           padding:
//                               EdgeInsets.only(top: 30, left: 20, right: 20),
//                           child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: InteractiveViewer(
//                                 panEnabled: false, // Set it to false
//                                 boundaryMargin: EdgeInsets.all(80),
//                                 minScale: 0.5,
//                                 maxScale: 3,
//                                 child: loadFile(widget.file.fileType,
//                                     widget.file.fileImage),
//                               ))),
//                       // child:
//                       // Icon(Icons.menu)
//                     ),
//               Container(
//                 padding: EdgeInsets.only(top: 10, left: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     widget.file.isFolder
//                         ? SizedBox.shrink()
//                         : Container(
//                             height: 25,
//                             width: 20,
//                             child: fileImage(widget.file.fileType)),
//                     Container(
//                         child: Text(
//                       widget.file.fileName,
//                       style: TextStyle(fontSize: 13),
//                     )),
//                     Container(
//                       child: Icon(Icons.more_vert),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// fileImage(String filename) {
//   if (filename == 'docs') {
//     return Image.asset("assets/images/google-docs.png");
//   } else if (filename == 'image') {
//     return Image.asset("assets/images/photo.png");
//   } else if (filename == 'pdf') {
//     return Image.asset("assets/images/pdf.png");
//   } else if (filename == 'sheets') {
//     return Image.asset("assets/images/google-sheets.png");
//   } else if (filename == 'video') {
//     return Image.asset("assets/images/photographic-flim.png");
//   } else {
//     return Image.asset(
//       "assets/pdf.png",
//       color: Colors.blue,
//     );
//   }
// }

// loadFile(String fileType, dynamic fileUrl) {
//   if (fileType == 'docs') {
//     return Image.asset("assets/images/google-docs.png");
//   } else if (fileType == 'image') {
//     return Image.network(
//       fileUrl,
//       fit: BoxFit.cover,
//       width: 130,
//       height: 130,
//     );
//   } else if (fileType == 'pdf') {
//     return Image.asset("assets/images/pdf.png");
//   } else if (fileType == 'sheets') {
//     return Image.asset("assets/images/google-sheets.png");
//   } else if (fileType == 'video') {
//     return Image.asset("assets/images/photographic-flim.png");
//   } else {
//     return Image.network(
//       fileUrl,
//       fit: BoxFit.cover,
//       width: 130,
//       height: 130,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:home_vault/screens/components/Files.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:home_vault/screens/components/file_reader_modal.dart';

class SmallGridWIdget extends StatelessWidget {
  SmallGridWIdget({Key? key, required this.file}) : super(key: key);

  final Files file;

  @override
  Widget build(BuildContext context) {
    return SmallGridWIdgetPage(
      file: file,
    );
  }
}

class SmallGridWIdgetPage extends StatefulWidget {
  SmallGridWIdgetPage({Key? key, required this.file}) : super(key: key);

  final Files file;

  @override
  _SmallGridWIdgetPageState createState() => _SmallGridWIdgetPageState();
}

class _SmallGridWIdgetPageState extends State<SmallGridWIdgetPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxWidth * 0.4;
        double imageHeight = constraints.maxWidth * 0.2;
        double iconSize = containerHeight * 0.8;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.file.isFolder
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        height: containerHeight,
                        child: Center(
                          child: Icon(
                            Icons.folder,
                            size: iconSize,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          showFilePreviewDialog(context, widget.file.fileType,
                              widget.file.fileUrl);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: containerHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: InteractiveViewer(
                              panEnabled: false,
                              boundaryMargin: EdgeInsets.all(30),
                              minScale: 0.5,
                              maxScale: 3,
                              child: loadFile(
                                widget.file.fileType,
                                widget.file.fileImage,
                                imageHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.file.isFolder
                          ? SizedBox.shrink()
                          : Container(
                              height: 25,
                              width: 20,
                              child: fileImage(widget.file.fileType)),
                      Flexible(
                        child: Text(
                          widget.file.fileName,
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.more_vert),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget fileImage(String fileType) {
  switch (fileType) {
    case 'docs':
      return Image.asset("assets/images/google-docs.png");
    case 'jpg':
    case 'png':
    case 'jpeg':
    case 'image':
      return Image.asset("assets/images/photo.png");
    case 'pdf':
      return Image.asset("assets/images/pdf.png");
    case 'sheets':
      return Image.asset("assets/images/google-sheets.png");
    case 'video':
      return Image.asset("assets/images/photographic-flim.png");
    default:
      return Image.asset(
        "assets/pdf.png",
        color: Colors.blue,
      );
  }
}

Widget loadFile(String fileType, dynamic fileUrl, double size) {
  print('fileTypefileType $fileType');
  switch (fileType) {
    case 'docs':
      return Image.asset(
        "assets/images/google-docs.png",
        fit: BoxFit.cover,
        width: size,
        height: size,
      );

    case 'jpg':
    case 'png':
    case 'jpeg':
    case 'image':
      return Image.network(
        fileUrl,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    case 'pdf':
      return Image.asset(
        "assets/images/pdf.png",
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    case 'sheets':
      return Image.asset(
        "assets/images/google-sheets.png",
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    case 'video':
      return Image.asset(
        "assets/images/photographic-flim.png",
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    default:
      return Image.network(
        fileUrl,
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
  }
}
