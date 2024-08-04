import 'package:flutter/material.dart';
import 'package:home_vault/constants.dart';
import 'package:home_vault/screens/property/propertyPage2.dart';
// class CardHorizontal extends StatelessWidget {
//   const CardHorizontal({required Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Image.network(
//             "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT",
//             height: 80,
//             width: 80,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Article Title",
//                   style: TextStyle(color: Colors.deepPurple, fontSize: 16),
//                   textAlign: TextAlign.left,
//                 ),
//                 Text("SAR",
//                     style: TextStyle(color: Colors.black, fontSize: 14),
//                     textAlign: TextAlign.left),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CardHorizontal extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String area;
  final String projectID;

  const CardHorizontal({
    required Key key,
    required this.imageUrl,
    required this.title,
    required this.area,
    required this.projectID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(projectID: projectID),
          ),
        );
      },
      child: SizedBox(
        height: 100, // Define a height for the card
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Image.network(
                imageUrl,
                height: 80,
                width: 80,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title[0].toUpperCase() + title.substring(1),
                        style: TextStyle(color: primaryColor, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        area,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
