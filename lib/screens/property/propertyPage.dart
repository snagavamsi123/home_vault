import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:home_vault/screens/dashboard/components/header.dart';
import 'package:home_vault/screens/sub_pages/reports_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:home_vault/screens/property/widgets/property_item.dart';

class PropertyPage extends StatefulWidget {
  @override
  PropertyPageState createState() => PropertyPageState();
}

List populars = [
  {
    "image":
        "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Single Villa",
    "price": "\$280k",
    "location": "Phnom Penh, Cambodia",
    "is_favorited": true,
  },
  {
    "image":
        "https://images.unsplash.com/photo-1598928506311-c55ded91a20c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Convertible Studio",
    "price": "\$150k",
    "location": "Phnom Penh, Cambodia",
    "is_favorited": false,
  },
  {
    "image":
        "https://images.unsplash.com/photo-1576941089067-2de3c901e126?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Twin Castle",
    "price": "\$175k",
    "location": "Phnom Penh, Cambodia",
    "is_favorited": false,
  },
  {
    "image":
        "https://images.unsplash.com/photo-1549517045-bc93de075e53?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Twin Villa",
    "price": "\$120k",
    "location": "Phnom Penh, Cambodia",
    "is_favorited": false,
  },
];

class PropertyPageState extends State<PropertyPage> {
  // Widget _currentContent = _buildPopulars(); // Default content

  // void updateContent(Widget content) {
  //   setState(() {
  //     _currentContent = content;
  //   });
  // }

  // Widget _buildPopulars() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 240,
  //       enlargeCenterPage: true,
  //       disableCenter: true,
  //       viewportFraction: .8,
  //     ),
  //     items: List.generate(
  //       populars.length,
  //       (index) => PropertyItem(
  //         data: populars[index],
  //       ),
  //     ),
  //   );
  // }

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
            // _currentContent,
            CarouselSlider(
              options: CarouselOptions(
                height: 240,
                enlargeCenterPage: true,
                disableCenter: true,
                viewportFraction: .8,
              ),
              items: List.generate(
                populars.length,
                (index) => PropertyItem(
                  data: populars[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
