// import 'package:home_vault/controllers/MenuAppController.dart';
// import 'package:home_vault/responsive.dart';
// import 'package:home_vault/screens/dashboard/dashboard_screen.dart';
// import 'package:home_vault/screens/sub_pages/transaction_screen.dart';
// import 'package:home_vault/screens/sub_pages/reports_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:home_vault/screens/main/components/side_menu.dart';
// import 'package:home_vault/screens/main/components/add_project_form.dart';
// import 'package:home_vault/screens/user/logout_page.dart';

// import 'package:home_vault/screens/property/propertyPage.dart';
// import 'package:home_vault/screens/property/propertyPage2.dart';
// import 'package:home_vault/screens/property/forms/property_details_form.dart';
// import 'package:home_vault/screens/property/propertyListing.dart';

// class MainScreen extends StatelessWidget {
//   final GlobalKey<DashboardScreenState> dashboardKey =
//       GlobalKey<DashboardScreenState>();

//   final int? value;
//   MainScreen([this.value]);

//   Widget getDynamicWidget() {
//     print(value);
//     print("valuevaluevaluevalue");
//     if (value == 1) {
//       return DashboardScreen(key: dashboardKey);
//     } else if (value == 2) {
//       return ReportsScreen();
//     } else if (value == 3) {
//       return PropertyList();
//       // TransactionContent();
//     } else {
//       return
//           // PropertyList();
//           // PropertyDetailsForm();
//           // PropertyDetailsPage();
//           // return PropertyPage();
//           ProfilePage(title: "helloo");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dynamicWidget = getDynamicWidget();
//     return Scaffold(
//       key: context.read<MenuAppController>().scaffoldKey,
//       drawer: SideMenu(
//         selectScreen: (Widget content) {
//           print(content);
//           dashboardKey.currentState?.updateContent(content);
//           Navigator.pop(context); // Close the drawer
//         },
//       ),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (Responsive.isDesktop(context))
//               Expanded(
//                 child: SideMenu(
//                   selectScreen: (Widget content) {
//                     dashboardKey.currentState?.updateContent(content);
//                   },
//                 ),
//               ),
//             Expanded(
//               flex: 5,
//               child: dynamicWidget,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//               // DashboardScreen(key: dashboardKey),

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_vault/controllers/MenuAppController.dart';
import 'package:home_vault/responsive.dart';
import 'package:home_vault/screens/dashboard/dashboard_screen.dart';
import 'package:home_vault/screens/sub_pages/reports_screen.dart';
import 'package:home_vault/screens/property/propertyListing.dart';
import 'package:home_vault/screens/main/components/side_menu.dart';
import 'package:home_vault/screens/user/logout_page.dart';
import 'package:home_vault/screens/property/Filters.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<DashboardScreenState> dashboardKey =
      GlobalKey<DashboardScreenState>();
  final int? value;

  MainScreen([this.value]);

  Widget getDynamicWidget() {
    if (value == 1) {
      return DashboardScreen(key: dashboardKey);
    } else if (value == 2) {
      return FiltersPage();
      // ReportsScreen();
    } else if (value == 3) {
      return PropertyList();
    } else {
      return ProfilePage(title: "Profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamicWidget = getDynamicWidget();
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        selectScreen: (Widget content) {
          dashboardKey.currentState?.updateContent(content);
          Navigator.pop(context); // Close the drawer
        },
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  selectScreen: (Widget content) {
                    dashboardKey.currentState?.updateContent(content);
                  },
                ),
              ),
            Expanded(
              flex: 5,
              child: dynamicWidget,
            ),
          ],
        ),
      ),
    );
  }
}
