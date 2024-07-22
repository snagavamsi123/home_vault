// import 'package:home_vault/controllers/MenuAppController.dart';
// import 'package:home_vault/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// import '../../../constants.dart';

// class Header extends StatelessWidget {
//   const Header({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         if (!Responsive.isDesktop(context))
//           IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: context.read<MenuAppController>().controlMenu,
//           ),
//         if (!Responsive.isMobile(context))
//           Text(
//             "Dashboard",
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//         if (!Responsive.isMobile(context))
//           Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
//         Expanded(child: SearchField()),
//         ProfileCard()
//       ],
//     );
//   }
// }

// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
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
//       child: Row(
//         children: [
//           Image.asset(
//             "assets/images/profile_pic.png",
//             height: 38,
//           ),
//           if (!Responsive.isMobile(context))
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//               child: Text("Angelina Jolie"),
//             ),
//           Icon(Icons.keyboard_arrow_down),
//         ],
//       ),
//     );
//   }
// }

// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search",
//         fillColor: secondaryColor,
//         filled: true,
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         suffixIcon: InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.all(defaultPadding * 0.75),
//             margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             child: SvgPicture.asset("assets/icons/Search.svg"),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // Ensure a Material context
      color: Colors
          .transparent, // Use transparent color to blend with existing background
      child: Row(
        children: [
          // if (!Responsive.isDesktop(context))
          //   IconButton(
          //     icon: Icon(Icons.menu),
          //     onPressed: context.read<MenuAppController>().controlMenu,
          //   ),
          if (!Responsive.isMobile(context))
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(
            child:
                //     SizedBox(
                //   width: double.infinity,
                // )
                SearchField(),
          ),
          ProfileCard()
        ],
      ),
    );
  }
}

// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
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
// child: PopupMenuButton<String>(
//   onSelected: (value) {
//     // Handle menu item selection
//     switch (value) {
//       case 'settings':
//         // Navigate to settings page or perform settings action
//         print("Settings selected");
//         break;
//       case 'logout':
//         // Perform logout action
//         print("Logout selected");
//         break;
//     }
//   },
//   itemBuilder: (BuildContext context) => [
//     PopupMenuItem<String>(
//       value: 'settings',
//       child: Text('Settings'),
//     ),
//     PopupMenuItem<String>(
//       value: 'logout',
//       child: Text('Logout'),
//     ),
//   ],
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

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    Future<void> _handleButtonClick(BuildContext context) async {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');

      // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
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
        // padding: EdgeInsets.fromLTRB(500, 500, 500, 5000),
        position: PopupMenuPosition.under,
        onSelected: (value) {
          // Handle menu item selection
          switch (value) {
            case 'settings':
              // Navigate to settings page or perform settings action
              print("Settings selected");
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(title: "helloo"),
                ),
              );
              break;
            case 'logout':
              // Perform logout action
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
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Angelina Jolie"),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
