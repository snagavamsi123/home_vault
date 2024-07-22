// import 'package:flutter/material.dart';

// class ImageGrid extends StatelessWidget {
//   final List<String> imageUrls;

//   ImageGrid({required this.imageUrls});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Image.network(
//                   imageUrls[0],
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Image.network(
//                         imageUrls[1],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Image.network(
//                         imageUrls[2],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           color: Colors.black,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '+91 91335 75784',
//                 style: TextStyle(color: Colors.white),
//               ),
//               Icon(Icons.send, color: Colors.green),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.file(File(widget.path));
    // _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true); // Optional: loop the video
  }

  // @override
  // void dispose() {
  //   _controller
  //       .dispose(); // Dispose the controller when the widget is disposed.
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.crop_rotate, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.title, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 27),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Image.network(widget.path),
          AspectRatio(
            aspectRatio: MediaQuery.of(context).size.width *
                1 /
                MediaQuery.of(context).size.height *
                1,
            child: Image.network(widget.path),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black38,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 17),
                maxLines: 6,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add Caption....",
                  prefixIcon: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 27,
                  ),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.tealAccent[700],
                    child: Icon(Icons.check, color: Colors.white, size: 27),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
