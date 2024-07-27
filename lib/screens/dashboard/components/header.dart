import 'package:home_vault/controllers/MenuAppController.dart';
import 'package:home_vault/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:home_vault/screens/user/logout_page.dart';
import '../../../constants.dart';
import 'package:home_vault/screens/user/signin_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:home_vault/screens/property/propertyPage2.dart';

class Header extends StatelessWidget {
  final Future<List<Map<String, dynamic>>>? searchResults;
  const Header({
    Key? key,
    this.searchResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              if (!Responsive.isMobile(context))
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (!Responsive.isMobile(context))
                Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              Expanded(child: SearchField()),
              ProfileCard()
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    // final first_letter = storage.read
    // String? refreshToken =  storage.read(key: 'refresh_token');

    Future<void> _handleButtonClick(BuildContext context) async {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    Future<String?> getName() async {
      final name = await storage.read(key: 'username');
      if (name != null && name.isNotEmpty) {
        print('message ${name[0]}');
        return name[0];
      } else {
        print('message AAJANAJNAJNANJ');
        return "A";
      }
    }

    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: PopupMenuButton(
        position: PopupMenuPosition.under,
        onSelected: (value) {
          switch (value) {
            case 'settings':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(title: "helloo"),
                ),
              );
              break;
            case 'logout':
              _handleButtonClick(context);
              break;
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: 'settings',
            child: Text('Settings'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('Logout'),
          ),
        ],
        child: Row(
          children: [
            FutureBuilder<String?>(
              future: getName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or any other loading indicator
                } else if (snapshot.hasError) {
                  return CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                        'https://dummyimage.com/600x400/000/fff&text=A'), // handle error case with a default value
                  );
                } else if (snapshot.hasData) {
                  final name = snapshot.data ?? 'A';
                  return CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                        'https://dummyimage.com/600x400/000/fff&text=$name'),
                  );
                } else {
                  return CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                        'https://dummyimage.com/600x400/000/fff&text=A'), // handle no data case with a default value
                  );
                }
              },
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        // child: Row(
        //   children: [
        //     new CircleAvatar(
        //       radius: 10,
        //       backgroundImage: NetworkImage(
        //           'https://dummyimage.com/600x400/000/fff&text=${getName()}'),
        //     ),
        //     Icon(Icons.keyboard_arrow_down),
        //   ],
        // ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? _searchResults;
  final storage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> fetchSearchResults(String query) async {
    final verifyUrl =
        'https://b6d9-115-98-217-224.ngrok-free.app/api/search_details/';
    final enteredData = {'name': query, 'is_top_search': true};
    final accessToken = await storage.read(key: 'access_token');

    final response = await http.post(
      Uri.parse(verifyUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      },
      body: jsonEncode(enteredData),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context, List<Map<String, dynamic>> results) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                title: Text(result['project_name']),
                onTap: () {
                  _controller.text = result['project_name'];
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PropertyDetailsPage(projectID: result['records_id']),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            fetchSearchResults(value).then((results) {
              if (_overlayEntry != null) {
                _overlayEntry!.remove();
              }
              _showOverlay(context, results);
            });
          },
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search",
            fillColor: secondaryColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}


// class Header extends StatelessWidget {
//   final Future<List<Map<String, dynamic>>>? searchResults;

//   const Header({
//     Key? key,
//     this.searchResults,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               if (!Responsive.isMobile(context))
//                 Text(
//                   "Dashboard",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               if (!Responsive.isMobile(context))
//                 Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
//               Expanded(child: SearchField()),
//               ProfileCard()
//             ],
//           ),
//           if (searchResults != null)
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: searchResults,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Text('No results found');
//                 } else {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final result = snapshot.data![index];
//                       return ListTile(
//                         title: Text(result['project_name']),
//                         onTap: () {
//                           // Handle result selection
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             )
//         ],
//       ),
//     );
//   }
// }

// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final storage = FlutterSecureStorage();

//     Future<void> _handleButtonClick(BuildContext context) async {
//       await storage.delete(key: 'access_token');
//       await storage.delete(key: 'refresh_token');

//       // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }

//     return Container(
//       margin: EdgeInsets.only(left: defaultPadding),
//       padding: EdgeInsets.symmetric(
//         horizontal: defaultPadding,
//         vertical: defaultPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: Colors.white10),
//       ),
//       child: PopupMenuButton(
//         // padding: EdgeInsets.fromLTRB(500, 500, 500, 5000),
//         position: PopupMenuPosition.under,
//         onSelected: (value) {
//           // Handle menu item selection
//           switch (value) {
//             case 'settings':
//               // Navigate to settings page or perform settings action
//               print("Settings selected");
//               //
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProfilePage(title: "helloo"),
//                 ),
//               );
//               break;
//             case 'logout':
//               // Perform logout action
//               _handleButtonClick(context);
//               break;
//           }
//         },
//         itemBuilder: (BuildContext context) => [
//           PopupMenuItem<String>(
//             value: 'settings',
//             child: Text('Settings'),
//           ),
//           PopupMenuItem<String>(
//             value: 'logout',
//             child: Text('Logout'),
//           ),
//         ],
//         child: Row(
//           children: [
//             Image.asset(
//               "assets/images/profile_pic.png",
//               height: 38,
//             ),
//             if (!Responsive.isMobile(context))
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//                 child: Text("Angelina Jolie"),
//               ),
//             Icon(Icons.keyboard_arrow_down),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchField extends StatefulWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _SearchFieldState createState() => _SearchFieldState();
// }

// class _SearchFieldState extends State<SearchField> {
//   final TextEditingController _controller = TextEditingController();
//   Future<List<Map<String, dynamic>>>? _searchResults;

//   final storage = FlutterSecureStorage();

//   Future<List<Map<String, dynamic>>> fetchSearchResults(String query) async {
//     print('queryqueryquery $query');
//     final verifyUrl = 'https://b6d9-115-98-217-224.ngrok-free.app/api/search_details/';
//     final enteredData = {'name': query, 'is_top_search': true};
//     final accessToken = await storage.read(key: 'access_token');

//     final response = await http.post(
//       Uri.parse(verifyUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Token $accessToken',
//       },
//       body: jsonEncode(enteredData),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = jsonDecode(response.body);
//       return jsonData.cast<Map<String, dynamic>>();
//     } else {
//       throw Exception('Failed to load search results');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           onChanged: (value) {
//             setState(() {
//               _searchResults = fetchSearchResults(value);
//             });
//           },
//           controller: _controller,
//           decoration: InputDecoration(
//             hintText: "Search",
//             fillColor:
//                 secondaryColor, // Replace secondaryColor with actual color
//             filled: true,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//         if (_searchResults != null)
//           Positioned(
//             top: 60, // Adjust this value based on the TextField height
//             left: 0,
//             right: 0,
//             child: Material(
//               child: Container(
//                 child: FutureBuilder<List<Map<String, dynamic>>>(
//                   future: _searchResults,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Text('No results found');
//                     } else {
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           final result = snapshot.data![index];
//                           print('messagejvcvbng $result');
//                           return ListTile(
//                             title: Text(result['project_name']),
//                             onTap: () {
//                               _controller.text = result['project_name'];
//                               setState(() {
//                                 _searchResults = null;
//                               });
//                             },
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//           )
//       ],
//     );
//   }
// }


