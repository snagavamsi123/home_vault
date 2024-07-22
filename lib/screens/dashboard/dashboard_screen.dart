// import 'package:home_vault/responsive.dart';
// import 'package:home_vault/screens/dashboard/components/my_fields.dart';
// import 'package:flutter/material.dart';

// import '../../constants.dart';
// import 'components/header.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             Header(),
//             SizedBox(height: defaultPadding),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       MyFiles(),
//                       SizedBox(height: defaultPadding),
//                       RecentFiles(),
//                       if (Responsive.isMobile(context))
//                         SizedBox(height: defaultPadding),
//                       if (Responsive.isMobile(context)) StorageDetails(),
//                     ],
//                   ),
//                 ),
//                 if (!Responsive.isMobile(context))
//                   SizedBox(width: defaultPadding),
//                 // On Mobile means if the screen is less than 850 we don't want to show it
//                 if (!Responsive.isMobile(context))
//                   Expanded(
//                     flex: 2,
//                     child: StorageDetails(),
//                   ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:home_vault/responsive.dart';
import 'package:home_vault/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';
import 'package:home_vault/screens/dashboard/components/recent_files.dart';
import 'package:home_vault/screens/dashboard/components/card_design.dart';
import 'package:home_vault/screens/dashboard/components/custom_button.dart';
import 'package:home_vault/screens/dashboard/components/initial_intro_page.dart';
import 'package:home_vault/screens/dashboard/main_dashboard_content.dart';

class DashboardScreen extends StatefulWidget {
  final GlobalKey<DashboardScreenState> key;

  DashboardScreen({required this.key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  Widget _currentContent = DashboardContent(); // Default content

  void updateContent(Widget content) {
    setState(() {
      _currentContent = content;
    });
  }

  void refreshDashboard() {
    print(
        'Yaha8hauahauhuahuahuauhahuuhahua imimim calllelelelelleleldldl%%%%%!!@#!@!#!@#@!#@');
    // recent_refresh()
    updateContent(_currentContent);
  }

  @override
  Widget build(BuildContext context) {
    print('IMIM in fdashboard headerr');
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            _currentContent,
          ],
        ),
      ),
    );
  }
}

// class DashboardContent extends StatelessWidget {
//   final List<Map<String, dynamic>> data = [
//     {
//       "name": "Article 1",
//       "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT1",
//       "datetime": "2024-07-18",
//       "area": "Area 1"
//     },
//     {
//       "name": "Article 2",
//       "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT2",
//       "datetime": "2024-07-19",
//       "area": "Area 2"
//     },
//     // Add more items as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 5,
//           child: Column(
//             children: [
//               MyFiles(),
//               SizedBox(height: defaultPadding),
//               // RecentFiles(),
//               // CardHorizontal(key: Key('1')),
//               ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   return CardHorizontal(
//                     key: Key(index.toString()),
//                     imageUrl: data[index]['imageurl'],
//                     title: data[index]['name'],
//                     area: data[index]['area'],
//                   );
//                 },
//               ),
//               if (Responsive.isMobile(context))
//                 SizedBox(height: defaultPadding),
//               // if (Responsive.isMobile(context)) StorageDetails(),
//             ],
//           ),
//         ),
//         if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
//         // if (!Responsive.isMobile(context))
//         //   Expanded(
//         //     flex: 2,
//         //     child: StorageDetails(),
//         //   ),
//       ],
//     );
//   }
// }

class DashboardContent extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      "name": "Article 111223344",
      "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT1",
      "datetime": "2024-07-18",
      "area": "Area 1"
    },
    {
      "name": "Article 2453234543",
      "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT2",
      "datetime": "2024-07-19",
      "area": "Area 2"
    },
    {
      "name": "Article 3345354534",
      "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT2",
      "datetime": "2024-07-19",
      "area": "Area 2"
    },
    {
      "name": "Article 46567567565",
      "imageurl": "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT2",
      "datetime": "2024-07-19",
      "area": "Area 2"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RenderDashboards()
                // // MyFiles(),
                // SizedBox(height: defaultPadding),
                // // // CardHorizontal(key: Key('1')),
                // // s

                // IntroContextPage(),
                // SizedBox(height: 100),
                // RecentFiles(data: data)

                // // CustomCardWithButton(),
              ],
            ),
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // if (!Responsive.isMobile(context))
        //   Expanded(
        //     flex: 2,
        //     child: StorageDetails(),
        //   ),
      ],
    );
  }
}
