import 'package:home_vault/constants.dart';
import 'package:home_vault/controllers/MenuAppController.dart';
import 'package:home_vault/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:home_vault/screens/main/components/bottom_nav.dart';
import 'package:home_vault/responsive.dart';
import 'package:home_vault/screens/user/signin_page.dart';
import 'package:home_vault/screens/main/landing_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_vault/auth/generate_access_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => MenuAppController(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter home_vault Panel',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: bgColor,
//           textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
//               .apply(bodyColor: Colors.white),
//           canvasColor: secondaryColor,
//         ),
//         // home: MainScreen(),

//         home:
//             // _buildInitialScreen(context),
//             LoginPage(),
//         //
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   checkLoggedIn();
  // }

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
          home: LandingPage()
          // _buildInitialScreen(context),
          ),
    );
  }
}

// Widget _buildInitialScreen(BuildContext context) {
//   final storage = FlutterSecureStorage();

//   Future<bool> verifyAccessToken(String accessToken) async {
//     print('calling verify aopiiiipipipi');
//     final verifyUrl = 'https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/verify-token/';
//     final response = await http.post(
//       Uri.parse(verifyUrl),
//       headers: {'Authorization': 'Token $accessToken'},
//     );
//     return response.statusCode == 200;
//   }

//   Future<bool> checkLoggedIn() async {
//     print('message im in chjeckloggedin ');
//     final accessToken = await storage.read(key: 'access_token');
//     final refreshToken = await storage.read(key: 'refresh_token');
//     if (accessToken != null) {
//       final isValid = await verifyAccessToken(accessToken);
//       if (isValid) {
//         return true;
//       } else if (refreshToken != null) {
//         String result = await GenerateAccessToken.refreshToken();
//         if (result == 'success') {
//           return true;
//         } else {
//           return false;
//         }
//       }
//     }
//     return false;
//   }

//   if (checkLoggedIn() == true) {
//     return LoginPage();
//   } else {
//     return LandingPage();
//   }
// }
