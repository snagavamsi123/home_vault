import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:home_vault/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_vault/screens/property/propertyListing.dart';
import 'package:home_vault/screens/main/main_screen.dart';

import 'package:provider/provider.dart';
import 'package:home_vault/screens/main/components/bottom_nav.dart';
import 'package:home_vault/screens/components/file_reader_modal.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:home_vault/screens/property/forms/edit_property_details.dart';
import 'package:home_vault/screens/property/forms/property_details_form.dart';
import 'package:home_vault/screens/main/landing_page.dart';
import 'package:home_vault/screens/property/forms/room_details_update.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class RadioController {
  bool? value;

  void setValue(bool? newValue) {
    value = newValue;
  }

  bool? getValue() {
    return value;
  }
}

class AccordionWidget extends StatefulWidget {
  final List<Item> data;
  String project_id;

  AccordionWidget({
    required this.data,
    required this.project_id,
  });

  @override
  _AccordionWidgetState createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  List<Item> expandedData = [];

  int _floorCount = 0;
  int _bedroomCount = 0;
  int _bathroomCount = 0;
  int _kitchenCount = 0;
  int _hallCount = 0;
  int _garageCount = 0;

  List<Map<String, dynamic>> _forms = [];

  void _addRoomForm(String roomType) {
    int number = 0;
    setState(() {
      switch (roomType) {
        case 'Floor':
          _floorCount++;
          number = _floorCount;
          break;
        case 'Bedroom':
          _bedroomCount++;
          number = _bedroomCount;
          break;
        case 'Bathroom':
          _bathroomCount++;
          number = _bathroomCount;
          break;
        case 'Kitchen':
          _kitchenCount++;
          number = _kitchenCount;
          break;
        case 'Hall':
          _hallCount++;
          number = _hallCount;
          break;
        case 'Garage':
          _garageCount++;
          number = _garageCount;
          break;
      }

      _forms.add({
        'roomType': roomType,
        'number': number,
        'size': '',
        'isRenovated': false,
        'description': '',
      });
    });
  }

  Future<void> _updateRoom(Map<String, dynamic> updatedRoom) async {
    print('updatedRoom: $updatedRoom');
    final response = await http.put(
      Uri.parse(
          'https://your-backend-api.com/update-room/${updatedRoom['number']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedRoom),
    );

    if (response.statusCode == 200) {
      print('Room updated successfully');
    } else {
      throw Exception('Failed to update room');
    }
  }

  void _showEditRoomDialog(Map<String, dynamic> room) {
    TextEditingController sizeController =
        TextEditingController(text: room['size']);
    TextEditingController descriptionController =
        TextEditingController(text: room['description']);
    // String isRenovated = room['isRenovated'] ? 'Yes' : 'No';
    // ;
    RadioController isRenovatedController = RadioController();
    isRenovatedController.setValue(room['isRenovated']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${room['type']}-${room['number']}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: room['type'],
                  decoration: InputDecoration(labelText: 'Room Type'),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: room['number'].toString(),
                  decoration: InputDecoration(labelText: 'Number'),
                  readOnly: true,
                ),
                TextFormField(
                  controller: sizeController,
                  decoration: InputDecoration(labelText: 'Size'),
                ),
                // SwitchListTile(
                //   value: isRenovated,
                //   onChanged: (value) {
                //     isRenovated = value;
                //     setState(() {});
                //   },
                //   title: Text('Is Renovated'),
                // ),
                ListTile(
                  title: Text(
                    'Is Renovated (${room['type']})',
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: isRenovatedController.getValue(),
                        onChanged: (value) {
                          setState(() {
                            isRenovatedController.setValue(value as bool?);
                          });
                        },
                      ),
                      Text('Yes'),
                      Radio(
                        value: false,
                        groupValue: isRenovatedController.getValue(),
                        onChanged: (value) {
                          setState(() {
                            isRenovatedController.setValue(value as bool?);
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedRoom = {
                  'type': room['type'],
                  'number': room['number'],
                  'size': sizeController.text,
                  'isRenovated': isRenovatedController.getValue(),
                  'description': descriptionController.text,
                };
                await _updateRoom(updatedRoom);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          print('message ${widget.data[index].isExpanded}');
          setState(() {
            if (widget.data[index].isExpanded == true) {
              widget.data[index].isExpanded = false;
            } else {
              widget.data[index].isExpanded = true;
            }
          });
        },
        children: widget.data.map<ExpansionPanel>((Item item) {
          print('messageAAAAAAAA $item');
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('${item.type}-${item.number}'),
                // trailing: InkWell(
                //   onTap: () {
                //     _showEditRoomDialog(item.toMap());
                //     // ("Bedroom");
                //     // print("AAAAA");
                //   },
                //   borderRadius: BorderRadius.circular(
                //       25), // Make the ripple effect circular
                //   child: Container(
                //     width: 40, // Adjust the size as needed
                //     height: 40,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       // color: Colors.grey[200], // Background color
                //     ),
                //     child: Icon(Icons.edit),
                //   ),
                // ),

                //  GestureDetector(
                //   onTap: () => {print("AAAAA")},
                //   child: Icon(Icons.edit),
                // ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Size',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "${item.size}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Renovated',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "${item.isRenovated}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  // ListTile(
                  //   title: Text('Renovated: ${item.isRenovated}'),
                  // ),
                  // ListTile(
                  //   title: Text('Description: ${item.description}'),
                  // ),
                  ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Description',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "${item.description}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ListTile(
                    title: Text('Attached Files: '),
                    subtitle: item.files.isNotEmpty
                        ? Text("")
                        : Text(
                            "No Files attached",
                            style: TextStyle(fontSize: 12),
                          ),
                  ),
                  item.files.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: 80,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            disableCenter: true,
                            viewportFraction: 0.2,
                          ),
                          // CarouselOptions(height: 200.0),
                          items: item.files.map((file) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    showFilePreviewDialog(context, "preview",
                                        "https://b6d9-115-98-217-224.ngrok-free.app$file");

                                    // ImagePreviewScreen(imageUrl: 'https://b6d9-115-98-217-224.ngrok-free.app$file')
                                  },
                                  child: Image.network(
                                      'https://b6d9-115-98-217-224.ngrok-free.app$file'),
                                );
                              },

                              // onclick ImagePreviewScreen(imageUrl: 'https://b6d9-115-98-217-224.ngrok-free.app$file'),
                            );
                          }).toList(),
                        )
                      : Text(""
                          // "No Files attached",
                          // style: TextStyle(fontSize: 12),
                          ),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  final String type;
  final int number;
  final String size;
  final bool isRenovated;
  final String description;
  final List<String> files;
  bool isExpanded;

  Item({
    required this.type,
    required this.number,
    required this.size,
    required this.isRenovated,
    required this.description,
    required this.files,
    this.isExpanded = false, // Default value for isExpanded
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      type: json['type'],
      number: json['number'],
      size: json['size'],
      isRenovated: json['isRenovated'],
      description: json['description'],
      files: List<String>.from(json['files']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'number': number,
      'size': size,
      'isRenovated': isRenovated,
      'description': description,
      'files': files,
      'isExpanded': isExpanded,
    };
  }
}

// class DynamicPropertyFeatures extends StatelessWidget {
//   final Map<String, int> propertyData;

//   DynamicPropertyFeatures({required this.propertyData});

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, IconData> iconMapping = {
//       'bedroom': Icons.bed,
//       'bathroom': Icons.bathtub,
//       'kitchen': Icons.kitchen,
//       'hall': Icons.weekend,
//       'garage': Icons.garage,
//     };

//     final List<Widget> items = propertyData.entries.map((entry) {
//       final String key = entry.key;
//       final int value = entry.value;

//       if (iconMapping.containsKey(key)) {
//         return PropertyFeature(
//           icon: iconMapping[key]!,
//           label:
//               '$value ${key[0].toUpperCase()}${key.substring(1)}${value > 1 ? 's' : ''}',
//         );
//       }

//       return SizedBox
//           .shrink(); // Return an empty widget for keys that are not mapped
//     }).toList();

//     return ListView(
//       scrollDirection: Axis.horizontal,
//       children: items.map((i) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width * 0.3,
//               margin: EdgeInsets.symmetric(horizontal: 5.0),
//               child: i,
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }

class PropertyDetailsPage extends StatefulWidget {
  final String projectID;

  PropertyDetailsPage({
    required this.projectID,
  });
  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final storage = FlutterSecureStorage();

  List<Item> data = [];
  String projectName = '';
  String projectLocation = '';
  String projectDescription = '';
  Map<String, int>? propertyData;

  String Bedrooms = "";
  String Bathrooms = "";
  String Kitchens = "";
  String Halls = "";
  String Dining_Room = "";
  String Garages = "";
  String Swimming_Pool = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchPropertyDetails();
    });
  }

  Future<void> _fetchPropertyDetails() async {
    final accessToken = await storage.read(key: 'access_token');

    final headers = {
      'Authorization': 'Token $accessToken',
    };
    final response = await http.get(
        Uri.parse(
            'https://b6d9-115-98-217-224.ngrok-free.app/api/store_individual_data?project_id=${widget.projectID}'),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);

      print('jsonResponse $jsonResponse');

      setState(() {
        projectName = jsonResponse['resp']['project_name'];
        projectLocation = jsonResponse['resp']['project_location'];
        projectDescription = jsonResponse['resp']['project_description'];
        data = (jsonResponse['resp']['individuals_details'] as List)
            .map((item) => Item.fromJson(item))
            .toList();

        // Floor = jsonResponse['resp']['individuals_counts'][''];
        Bedrooms =
            jsonResponse['resp']['individuals_counts']['bedroom'].toString();
        Bathrooms =
            jsonResponse['resp']['individuals_counts']['bathroom'].toString();
        Kitchens =
            jsonResponse['resp']['individuals_counts']['kitchen'].toString();
        Halls = jsonResponse['resp']['individuals_counts']['hall'].toString();
        Dining_Room =
            jsonResponse['resp']['individuals_counts']['diningroom'].toString();
        Garages =
            jsonResponse['resp']['individuals_counts']['garage'].toString();
        Swimming_Pool = jsonResponse['resp']['individuals_counts']
                ['swimmingpool']
            .toString();

        print('messageBedrooms $Bedrooms');
      });

      print('API call successful: ${widget.projectID}');
    } else {
      print('Failed to load data');
    }
  }

  Future<void> _deletePropertyDetails() async {
    print('deletedddddd');
    final accessToken = await storage.read(key: 'access_token');

    final headers = {
      'Authorization': 'Token $accessToken',
    };
    final response = await http.get(
        Uri.parse(
            'https://b6d9-115-98-217-224.ngrok-free.app/api/delete_individual_data?project_id=${widget.projectID}'),
        headers: headers);
    // Add this to refresh the previous page data
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => NavBarState(
    //             title: 'Flutter home_vault Panel',
    //             nav_index: '3',
    //           )),
    // );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  Future<void> _downloadPropertyDetails() async {
    final accessToken = await storage.read(key: 'access_token');
    final headers = {
      'Authorization': 'Token $accessToken',
    };

    final url =
        'https://b6d9-115-98-217-224.ngrok-free.app/api/store_individual_data?project_id=${widget.projectID}&is_download=true';

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Use external application mode
      );
    } else {
      print('Could not launch $url');
    }

    // final response = await http.get(
    //     Uri.parse(
    //         'https://b6d9-115-98-217-224.ngrok-free.app/api/store_individual_data?project_id=ace82a9c-02e4-41c5-af7d-03f9dd7a5970&is_download=true'),
    //     headers: headers);

    // // if (response.statusCode == 200) {
    // //   final directory = await getApplicationDocumentsDirectory();
    // //   final file = File('${directory.path}/project_details.pdf');
    // //   await file.writeAsBytes(response.bodyBytes);
    // //   OpenFile.open(file.path);
    // //   print('PDF downloaded to: ${file.path}');
    // // } else {
    // //   print('Failed to download PDF');
    // // }
    // if (response.statusCode == 200) {
    //   final directory = await getApplicationDocumentsDirectory();
    //   final file = File('${directory.path}/project_details.pdf');
    //   await file.writeAsBytes(response.bodyBytes);
    //   print('PDF downloaded to: ${file.path}');
    //   _showDownloadModal(file.path);
    // } else {
    //   print('Failed to download PDF');
    // }
  }

  void _showDownloadModal(String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Downloaded'),
          content: Text(
              'The PDF has been downloaded successfully. Do you want to open or download it?'),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     OpenFile.open(filePath);
            //     Navigator.of(context).pop();
            //   },
            //   child: Text('Open'),
            // ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDownloadOptions(filePath);
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }

  void _showDownloadOptions(String filePath) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Save PDF to:'),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text('Documents Folder'),
                onTap: () async {
                  // Handle saving to a different location if needed
                  print('Saved to Documents Folder');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Download Folder'),
                onTap: () async {
                  // Move the file to the download folder
                  final downloadsDirectory = await getDownloadsDirectory();
                  final newFile = await File(filePath)
                      .copy('${downloadsDirectory!.path}/project_details.pdf');
                  print('Saved to Download Folder: ${newFile.path}');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  final Map<String, IconData> iconMapping = {
    'bedroom': Icons.bed,
    'bathroom': Icons.bathtub,
    'kitchen': Icons.kitchen,
    'hall': Icons.weekend,
    'garage': Icons.garage,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: secondaryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RoomDetailsEditForm(projectID: widget.projectID)
                      // PropertyDetailsEditForm(),
                      ),
                );
              },
              child: Icon(Icons.edit, color: Colors.orange.shade400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PropertyDetailsForm(projectID: widget.projectID),
                  ),
                );
              },
              child: Icon(Icons.add_box_outlined, color: Colors.blue.shade400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () {
                _deletePropertyDetails();
              },
              child: Icon(Icons.delete, color: Colors.red.shade400),
            ),
          ),
          Padding(
            padding:
                //
                const EdgeInsets.only(right: 16.0), // Add padding if needed
            child: GestureDetector(
                onTap: () {
                  _downloadPropertyDetails();
                },
                child: Icon(Icons.download, color: Colors.green)),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=800',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(projectLocation),
                    ],
                  ),
                  SizedBox(height: 16),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 80,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      viewportFraction: 0.4,
                    ),
                    items: [
//                       Bedrooms
// Bathrooms
// Kitchens
// Halls
// Dining_Room
// Garages
// Swimming_Pool
                      PropertyFeature(
                          icon: Icons.bed, label: '${Bedrooms} Bedrooms'),
                      PropertyFeature(
                          icon: Icons.bathtub, label: '${Bathrooms} Bathrooms'),
                      PropertyFeature(
                          icon: Icons.kitchen, label: '${Kitchens} Kitchens'),
                      PropertyFeature(
                          icon: Icons.weekend, label: '${Halls} Halls'),
                      PropertyFeature(
                          icon: Icons.dining,
                          label: '${Dining_Room} Dining Room'),
                      PropertyFeature(
                          icon: Icons.garage, label: '${Garages} Garages'),
                      PropertyFeature(
                          icon: Icons.pool,
                          label: '${Swimming_Pool} Swimming Pool'),
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: i,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    projectDescription,
                    // 'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 8),
                  AccordionWidget(data: data, project_id: widget.projectID),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PropertyFeature extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   PropertyFeature({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, size: 32, color: Colors.grey),
//         SizedBox(height: 4),
//         Text(label),
//       ],
//     );
//   }
// }

class PropertyFeature extends StatelessWidget {
  final IconData icon;
  final String label;

  PropertyFeature({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40.0),
        Text(label),
      ],
    );
  }
}

List<PropertyFeature> createPropertyFeatures(Map<String, int> features) {
  List<PropertyFeature> propertyFeatures = [];

  if (features.containsKey('bedroom')) {
    propertyFeatures.add(
      PropertyFeature(
          icon: Icons.bed, label: '${features['bedroom']} Bedrooms'),
    );
  }
  if (features.containsKey('bathroom')) {
    propertyFeatures.add(
      PropertyFeature(
          icon: Icons.bathtub, label: '${features['bathroom']} Bathrooms'),
    );
  }
  if (features.containsKey('kitchen')) {
    propertyFeatures.add(
      PropertyFeature(
          icon: Icons.kitchen, label: '${features['kitchen']} Kitchens'),
    );
  }
  if (features.containsKey('hall')) {
    propertyFeatures.add(
      PropertyFeature(icon: Icons.weekend, label: '${features['hall']} Halls'),
    );
  }
  if (features.containsKey('garage')) {
    propertyFeatures.add(
      PropertyFeature(
          icon: Icons.garage, label: '${features['garage']} Garages'),
    );
  }

  // Add other property features if necessary

  return propertyFeatures;
}

// class PropertyFeature extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   PropertyFeature({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 30),
//         SizedBox(height: 5),
//         Text(label),
//       ],
//     );
//   }
// }

