// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:home_vault/screens/dashboard/dashboard_screen.dart';
import 'package:home_vault/screens/sub_pages/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:home_vault/screens/main/main_screen.dart';
import 'package:home_vault/file_handling/file_upload_options.dart';
import 'dart:io';
import 'package:home_vault/file_handling/image_preview_screen.dart';
import 'package:home_vault/file_handling/image_preview.dart';

import 'package:home_vault/screens/main/components/add_project_form.dart';

class NavBarState extends StatefulWidget {
  NavBarState({Key? key, required this.title, required this.nav_index})
      : super(key: key);
  String title;
  final String nav_index;
  @override
  _NavBarStateState createState() => _NavBarStateState(
        int.parse(nav_index),
      );
}

class _NavBarStateState extends State<NavBarState> {
  int _currentIndex = 0;
  bool isExpanded = false;

  _NavBarStateState(int currentIndex) {
    _currentIndex = currentIndex;
  }

  // int _currentIndex = 0;

  List<Widget> _tabScreens = [
    MainScreen(1),
    MainScreen(2),
    MainScreen(3),
    MainScreen(4),
  ];

  List<String> _nav_titles = [
    'A',
    'B',
    'C',
    'D',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.title = index.toString();
    });
    widget.title = _nav_titles[index];
    switch (index) {
      case 0:
        // perform operations for first tab
        break;
      case 1:
        // perform operations for second tab
        break;
      case 2:
        // perform operations for third tab
        break;
      case 3:
        // perform operations for fourth tab
        break;
      default:
        break;
    }
  }

  // showFileUploadOptions(context, (File imageFile) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   // ImagePreviewScreen(imageUrl: imageFile.path),
  //                   VideoViewPage(
  //                     path: imageFile.path,
  //                   )),
  //         );
  //         print('Image saved: ${imageFile.path}');
  //       }

  //       ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _tabScreens[_currentIndex],
      // if _currentIndex ==0: display floatingAction btn
      floatingActionButton: _currentIndex == 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isExpanded) ...[
                  FloatingActionButton(
                    onPressed: () {
                      // Add new action

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // ImagePreviewScreen(imageUrl: imageFile.path),
                                RenovationFormPage()),
                      );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Add new action tapped')),
                      // );
                    },
                    backgroundColor: Colors.blue,
                    heroTag: 'add',
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Edit action tapped')),
                      );
                    },
                    backgroundColor: Colors.blue,
                    heroTag: 'edit',
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(height: 10),
                ],
                FloatingActionButton(
                  onPressed: () {
                    // setState(() {
                    //   isExpanded = !isExpanded;
                    // });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // ImagePreviewScreen(imageUrl: imageFile.path),
                              RenovationFormPage()),
                    );
                  },
                  backgroundColor: Colors.red,
                  child: Icon(isExpanded ? Icons.close : Icons.add),
                ),
              ],
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: 'Filters',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            label: 'Reports',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
