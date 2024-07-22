// import 'package:flutter/material.dart';

// class TransactionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "Hello, Transaction Page",
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// import 'package:home_vault/responsive.dart';
// import 'package:home_vault/screens/Transaction/components/my_fields.dart';
// import 'package:flutter/material.dart';

// import '../../constants.dart';
// import 'components/header.dart';

// import 'components/recent_files.dart';
// import 'components/storage_details.dart';

// class TransactionScreen extends StatelessWidget {
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
import 'package:home_vault/screens/dashboard/components/header.dart';
import 'package:home_vault/screens/dashboard/components/old_recent_files.dart';

class TransactionScreen extends StatefulWidget {
  final GlobalKey<TransactionScreenState> key;

  TransactionScreen({required this.key}) : super(key: key);

  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen> {
  Widget _currentContent = TransactionContent(); // Default content

  void updateContent(Widget content) {
    setState(() {
      _currentContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
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

class TransactionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              // MyFiles(),
              // SizedBox(height: defaultPadding),
              OldRecentFiles(),
              // if (Responsive.isMobile(context))
              //   SizedBox(height: defaultPadding),
              // if (Responsive.isMobile(context)) StorageDetails(),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: OldRecentFiles(),
          ),
      ],
    );
  }
}
