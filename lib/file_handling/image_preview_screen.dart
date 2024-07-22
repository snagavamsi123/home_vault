// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ImagePreviewScreen extends StatefulWidget {
//   final String imagePath;

//   ImagePreviewScreen({required this.imagePath});

//   @override
//   _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
// }

// class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
//   final TextEditingController _commentController = TextEditingController();

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveImageWithComments() async {
//     final comment = _commentController.text;
//     final directory = await getApplicationDocumentsDirectory();

//     // Check if imagePath is not null or empty before proceeding
//     if (widget.imagePath.isNotEmpty) {
//       final imageFileName = widget.imagePath.split('/').last;
//       final savedImagePath = '${directory.path}/$imageFileName';
//       final imageFile = File(widget.imagePath);

//       // Save the image to the app's local storage
//       await imageFile.copy(savedImagePath);

//       // Save the comment and image path to SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('saved_image_path', savedImagePath);
//       await prefs.setString('image_comment', comment);

//       // After saving, navigate back or show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image and comment saved successfully!')),
//       );
//       Navigator.pop(context);
//     } else {
//       // Handle the case where imagePath is null or empty
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image not found')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Preview'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (widget.imagePath.isNotEmpty)
//               Image.file(File(widget.imagePath))
//             else
//               Text('No image selected'),
//             SizedBox(height: 16),
//             TextField(
//               controller: _commentController,
//               decoration: InputDecoration(
//                 labelText: 'Add a comment',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveImageWithComments,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// image_preview_screen.dart

// image_preview_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  ImagePreviewScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveImage(imageUrl, "commentController.text");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(imageUrl),
          TextField(
            // controller: "commentController",
            decoration: InputDecoration(
              labelText: 'Enter your comment',
            ),
          ),
        ],
      ),
    );
  }

  void _saveImage(String imageUrl, String comment) {
    // Implement your saving logic here
    // For example, you can save the image to local storage
    // and associate it with the entered comment
    print('Image saved: $imageUrl');
    print('Comment: $comment');
  }
}
