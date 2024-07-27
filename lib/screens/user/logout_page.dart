// import 'package:flutter/material.dart';
// import 'package:home_vault/constants.dart';
// import 'package:home_vault/screens/user/signin_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ProfilePage extends StatefulWidget {
//   ProfilePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _ProfilePageState createState() => new _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final _width = MediaQuery.of(context).size.width;
//     final _height = MediaQuery.of(context).size.height;
//     final storage = FlutterSecureStorage();

//     Future<void> _handleButtonClick(BuildContext context) async {
//       await storage.delete(key: 'access_token');
//       await storage.delete(key: 'refresh_token');

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.amber),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       body: new Container(
//         child: new Stack(
//           children: <Widget>[
//             new Container(
//               decoration: new BoxDecoration(
//                   gradient: new LinearGradient(colors: [
//                 secondaryColor,
//                 secondaryColor,
//               ], begin: Alignment.topCenter, end: Alignment.center)),
//             ),
//             new Scaffold(
//               backgroundColor: Colors.transparent,
//               body: new Container(
//                 child: new Stack(
//                   children: <Widget>[
//                     new Align(
//                       alignment: Alignment.center,
//                       child: new Padding(
//                         padding: new EdgeInsets.only(top: _height / 15),
//                         child: new Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             new CircleAvatar(
//                               // backgroundImage:
//                               //     new AssetImage('assets/profile_img.jpeg'),
//                               radius: _height / 10,
//                             ),
//                             new SizedBox(
//                               height: _height / 30,
//                             ),
//                             new Text(
//                               'Vamsi',
//                               style: new TextStyle(
//                                   fontSize: 18.0,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     new Padding(
//                       padding: new EdgeInsets.only(top: _height / 2.2),
//                       child: new Container(
//                         color: secondaryColor,
//                       ),
//                     ),
//                     new Padding(
//                       padding: new EdgeInsets.only(
//                           top: _height / 2.6,
//                           left: _width / 20,
//                           right: _width / 20),
//                       child: new Column(
//                         children: <Widget>[
//                           new Container(
//                             decoration: new BoxDecoration(
//                                 color: Color.fromARGB(255, 156, 193, 108),
//                                 boxShadow: [
//                                   new BoxShadow(
//                                       color: Colors.black45,
//                                       blurRadius: 2.0,
//                                       offset: new Offset(0.0, 2.0))
//                                 ]),
//                             child: new Padding(
//                               padding: new EdgeInsets.all(_width / 20),
//                               child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     headerChild('Uploads', 114),
//                                     headerChild('Downloads', 1205),
//                                     headerChild('Shares', 360),
//                                   ]),
//                             ),
//                           ),
//                           new Padding(
//                             padding: new EdgeInsets.only(top: _height / 20),
//                             child: new Column(
//                               children: <Widget>[
//                                 infoChild(_width, Icons.email,
//                                     'snagavamsi@gmail.com'),
//                                 new SizedBox(
//                                   height: 10,
//                                 ),
//                                 infoChild(_width, Icons.call, '+91-9985547754'),
//                                 new SizedBox(
//                                   height: 10,
//                                 ),
//                                 infoChild(
//                                     _width, Icons.person, 'snagavamsi123'),
//                                 new SizedBox(
//                                   height: 10,
//                                 ),
//                                 // infoChild(_width, Icons.chat_bubble,
//                                 //     'Show all comments'),
//                                 new Padding(
//                                   padding:
//                                       new EdgeInsets.only(top: _height / 30),
//                                   child: new GestureDetector(
//                                     onTap: () {
//                                       _handleButtonClick(context);
//                                     },
//                                     child: new Container(
//                                       width: _width / 3,
//                                       height: _height / 20,
//                                       decoration: new BoxDecoration(
//                                         color: Colors.red[
//                                             300], // Updated background color
//                                         borderRadius: new BorderRadius.all(
//                                           new Radius.circular(_height / 40),
//                                         ),
//                                         boxShadow: [
//                                           new BoxShadow(
//                                             color: Colors.black87,
//                                             blurRadius: 2.0,
//                                             offset: new Offset(0.0, 1.0),
//                                           ),
//                                         ],
//                                       ),
//                                       child: new Center(
//                                         child: new Text(
//                                           'Logout',
//                                           style: new TextStyle(
//                                             fontSize: 12.0,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget headerChild(String header, int value) => new Expanded(
//           child: new Column(
//         children: <Widget>[
//           new Text(header),
//           new SizedBox(
//             height: 8.0,
//           ),
//           new Text(
//             '$value',
//             style: new TextStyle(
//                 fontSize: 14.0,
//                 color: primaryColor,
//                 fontWeight: FontWeight.bold),
//           )
//         ],
//       ));

//   Widget infoChild(double width, IconData icon, data) => new Padding(
//         padding: new EdgeInsets.only(bottom: 8.0),
//         child: new InkWell(
//           child: new Row(
//             children: <Widget>[
//               new SizedBox(
//                 width: width / 10,
//               ),
//               new Icon(
//                 icon,
//                 color: tertiaryColor,
//                 size: 20.0,
//               ),
//               new SizedBox(
//                 width: width / 20,
//               ),
//               new Text(data)
//             ],
//           ),
//           onTap: () {
//             print('Info Object selected');
//           },
//         ),
//       );
// }

import 'package:flutter/material.dart';
import 'package:home_vault/constants.dart';
import 'package:home_vault/screens/user/signin_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FlutterSecureStorage();
  String name = "";
  int uploadsCount = 0;
  int downloadsCount = 0;
  int sharesCount = 0;
  String email = "";
  String username = "";
  String mobile = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('https://b6d9-115-98-217-224.ngrok-free.app/profile'),
      headers: {
        'Authorization': 'Token $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        name = data['name'];
        uploadsCount = data['uploads_count'];
        downloadsCount = data['downloads_count'];
        sharesCount = data['shares_count'];
        email = data['email'];
        username = data['username'];
        mobile = data['mobile'];
      });
    } else {
      // Handle the error case here
      print('Failed to load profile data');
    }
  }

  Future<void> _handleButtonClick(BuildContext context) async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                secondaryColor,
                secondaryColor,
              ], begin: Alignment.topCenter, end: Alignment.center)),
            ),
            new Scaffold(
              backgroundColor: Colors.transparent,
              body: new Container(
                child: new Stack(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.center,
                      child: new Padding(
                        padding: new EdgeInsets.only(top: _height / 15),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // new CircleAvatar(
                            //   radius: _height / 10,
                            // ),
                            new CircleAvatar(
                              radius: _height / 10,
                              backgroundImage: NetworkImage(
                                  'https://dummyimage.com/600x400/000/fff&text=${name.isNotEmpty ? name[0] : ''}'),
                            ),
                            new SizedBox(
                              height: _height / 30,
                            ),
                            new Text(
                              name,
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: _height / 2.2),
                      child: new Container(
                        color: secondaryColor,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                          top: _height / 2.6,
                          left: _width / 20,
                          right: _width / 20),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 156, 193, 108),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 2.0,
                                      offset: new Offset(0.0, 2.0))
                                ]),
                            child: new Padding(
                              padding: new EdgeInsets.all(_width / 20),
                              child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    headerChild('Uploads', uploadsCount),
                                    headerChild('Downloads', downloadsCount),
                                    headerChild('Shares', sharesCount),
                                  ]),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: _height / 20),
                            child: new Column(
                              children: <Widget>[
                                infoChild(_width, Icons.email, email),
                                new SizedBox(
                                  height: 10,
                                ),
                                infoChild(_width, Icons.call, mobile),
                                new SizedBox(
                                  height: 10,
                                ),
                                infoChild(_width, Icons.person, username),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Padding(
                                  padding:
                                      new EdgeInsets.only(top: _height / 30),
                                  child: new GestureDetector(
                                    onTap: () {
                                      _handleButtonClick(context);
                                    },
                                    child: new Container(
                                      width: _width / 3,
                                      height: _height / 20,
                                      decoration: new BoxDecoration(
                                        color: Colors.red[
                                            300], // Updated background color
                                        borderRadius: new BorderRadius.all(
                                          new Radius.circular(_height / 40),
                                        ),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 2.0,
                                            offset: new Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: new Center(
                                        child: new Text(
                                          'Logout',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: primaryColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: tertiaryColor,
                size: 20.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
