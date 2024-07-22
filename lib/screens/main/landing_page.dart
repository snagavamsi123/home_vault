import 'package:home_vault/constants.dart';
import 'package:home_vault/controllers/MenuAppController.dart';
import 'package:home_vault/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:home_vault/screens/main/components/bottom_nav.dart';
import 'package:home_vault/responsive.dart';
import 'package:home_vault/screens/user/signin_page.dart';

import 'package:home_vault/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_vault/auth/generate_access_token.dart';

// import 'package:home_vault/constants.dart';
// import 'package:home_vault/controllers/MenuAppController.dart';
// import 'package:home_vault/screens/main/main_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final String loginUrl = 'http://10.0.2.2:9001/api/token/';
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  // currently commented
  Future<void> checkLoggedIn() async {
    print('message im in chjeckloggedin ');
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    print('access_tokennnn  $accessToken');
    print('refreshToken  $refreshToken');

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text('Error'),
    //       content: Text('Helloo Unknown error $accessToken  $refreshToken'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );

    if (accessToken != null) {
      print('verifyinnining access token');
      final isValid = await verifyAccessToken(accessToken);
      if (isValid) {
        // Token is still valid, proceed to the LandingPage
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LandingPage()),
        // );
      } else if (refreshToken != null) {
        // Token has expired, attempt to refresh it
        // String newAccessToken = await GenerateAccessToken();
        String result = await GenerateAccessToken.refreshToken();

        if (result != 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => LandingPage()),
          // );
        }
        // else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => LoginPage()),
        //   );
        // }
      }
    }
  }

// currently commented
  Future<bool> verifyAccessToken(String accessToken) async {
    print('calling verify aopiiiipipipi');
    final verifyUrl = 'http://10.0.2.2:9001/api/verify-token/';
    final response = await http.post(
      Uri.parse(verifyUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter home_vault Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        // home: MainScreen(),

        home: _buildInitialScreen(context),
        //
      ),
    );
  }
}

Widget _buildInitialScreen(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    print("object111111");
    return MainScreen();
  } else {
    print("object2222");
    return NavBarState(
      title: 'Flutter home_vault Panel',
      nav_index: '0',
    );
  }
}
