// // file_upload_options.dart
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:home_vault/file_handling/image_preview_screen.dart';

// Future<void> showFileUploadOptions(BuildContext context) async {
//   final ImagePicker _picker = ImagePicker();

//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return SafeArea(
//         child: Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.camera),
//               title: Text('Open Camera'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final pickedFile =
//                     await _picker.pickImage(source: ImageSource.camera);
//                 if (pickedFile != null) {
//                   try {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             ImagePreviewScreen(imagePath: pickedFile.path),
//                       ),
//                     );
//                   } catch (e, stackTrace) {
//                     print('Error navigating to ImagePreviewScreen: $e');
//                     print(stackTrace);
//                   }
//                 }
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('Upload from Gallery'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final pickedFile =
//                     await _picker.pickImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ImagePreviewScreen(imagePath: pickedFile.path),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('No image selected')),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// file_upload_options.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_vault/file_handling/image_preview_screen.dart';

Future<void> showFileUploadOptions(
    BuildContext context, Function(File) saveCallback) async {
  final ImagePicker _picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Open Camera'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  saveCallback(File(pickedFile.path));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Upload from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  print(File(pickedFile.path));
                  print('22222');
                  saveCallback(File(pickedFile.path));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No image selected')),
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
