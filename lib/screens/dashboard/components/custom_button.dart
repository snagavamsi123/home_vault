import 'package:flutter/material.dart';
import 'package:home_vault/constants.dart';
import 'package:home_vault/screens/main/components/add_project_form.dart';

class CustomCardWithButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Container(
          width: 300,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                top: 80,
                left: 120,
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child:

                        // Icon(
                        //   Icons.add,
                        //   color: Colors.white,
                        //   size: 40,
                        // ),

                        IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RenovationFormPage()),
                        );
                        // ImagePreviewScreen(imageUrl: imageFile.path),
                        // Implement view functionality here
                        //
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
