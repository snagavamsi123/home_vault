// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';

// class SlashedLinesPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey.withOpacity(0.5)
//       ..strokeWidth = 1.0;

//     final double step = 10;
//     for (double x = -size.height; x < size.width; x += step) {
//       canvas.drawLine(
//         Offset(x, 0),
//         Offset(x + size.height, size.height),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class _TextFormFieldClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..addRRect(RRect.fromRectAndRadius(
//         Rect.fromLTWH(0, 5, size.width, size.height),
//         Radius.circular(10),
//       ));
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// Future<void> _pickFiles() async {
//   try {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'pdf', 'doc'], // Specify allowed file types
//     );
//     if (result != null) {
//       // Process picked files
//     }
//   } catch (e) {
//     print('Error picking files: $e');
//   }
// }

// Future<void> _pickImageFromCamera() async {
//   // Implement logic to capture image from camera
// }

// Future<void> _showOptions(BuildContext context) async {
//   return await showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         child: Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('Upload from File Manager'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickFiles();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text('Upload from Camera'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImageFromCamera();
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// class RoomForm extends StatefulWidget {
//   final String roomType;
//   final int index;
//   final GlobalKey<_RoomFormState> formKey;

//   RoomForm({
//     required this.roomType,
//     required this.index,
//     required this.formKey,
//   }) : super(key: formKey);

//   @override
//   _RoomFormState createState() => _RoomFormState();
// }

// class _RoomFormState extends State<RoomForm> {
//   final TextEditingController _sizeController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _fixturesController = TextEditingController();
//   String _isRenovated = 'No';
//   List<String> _files = [];

//   @override
//   void dispose() {
//     _sizeController.dispose();
//     _descriptionController.dispose();
//     _fixturesController.dispose();
//     super.dispose();
//   }

//   Map<String, dynamic> getData() {
//     final dataaa = {
//       "type": widget.roomType.toLowerCase(),
//       "number": widget.index,
//       "size": _sizeController.text,
//       "is_renovated": _isRenovated == 'Yes',
//       "description": _descriptionController.text,
//       "files": _files
//     };

//     print('message----->>>><<<<---- $dataaa');
//     return dataaa;
//   }

//   Future<void> _pickImageFromCamera() async {
//     // final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
//     // if (pickedFile != null) {
//     //   setState(() {
//     //     _files.add(pickedFile.path);
//     //   });
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('${widget.roomType} ${widget.index}',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _sizeController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Size of ${widget.roomType}-${widget.index}',
//                 labelStyle: TextStyle(fontSize: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ListTile(
//                 title: Text(
//                   'Is Renovated (${widget.roomType}-${widget.index})',
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 subtitle: Row(children: [
//                   Radio(
//                     value: 'Yes',
//                     groupValue: _isRenovated,
//                     onChanged: (value) {
//                       setState(() {
//                         _isRenovated = value.toString();
//                       });
//                     },
//                   ),
//                   Text('Yes'),
//                   Radio(
//                     value: 'No',
//                     groupValue: _isRenovated,
//                     onChanged: (value) {
//                       setState(() {
//                         _isRenovated = value.toString();
//                       });
//                     },
//                   ),
//                   Text('No'),
//                 ])),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                   labelText:
//                       'Add Description for ${widget.roomType}-${widget.index}',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   labelStyle: TextStyle(fontSize: 12)),
//               maxLines: 4,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter description';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ClipPath(
//               clipper: _TextFormFieldClipper(),
//               child: CustomPaint(
//                 painter: SlashedLinesPainter(),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                   child: TextFormField(
//                     controller: _fixturesController,
//                     maxLines: 4,
//                     onTap: () {
//                       _showOptions(context);
//                     },
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: 'Description of Fixtures and Articles Added',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       labelStyle: TextStyle(fontSize: 12),
//                       filled: true,
//                       fillColor: Colors.transparent,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoomDetailsPage extends StatefulWidget {
//   final int initialFloors;
//   final int initialBedrooms;
//   final int initialBathrooms;
//   final int initialKitchens;
//   final int initialHalls;
//   final int initialGarages;

//   RoomDetailsPage({
//     required this.initialFloors,
//     required this.initialBedrooms,
//     required this.initialBathrooms,
//     required this.initialKitchens,
//     required this.initialHalls,
//     required this.initialGarages,
//   });

//   @override
//   _RoomDetailsPageState createState() => _RoomDetailsPageState();
// }

// class _RoomDetailsPageState extends State<RoomDetailsPage> {
//   List<RoomForm> _forms = [];
//   List<GlobalKey<_RoomFormState>> _formKeys = [];
//   final List<Map<String, dynamic>> _defaultData = [];
//   int _floorCount = 0;
//   int _bedroomCount = 0;
//   int _bathroomCount = 0;
//   int _kitchenCount = 0;
//   int _hallCount = 0;
//   int _garageCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     initializeForms();
//   }

//   void initializeForms() {
//     for (int i = 0; i < widget.initialFloors; i++) {
//       _addRoomForm('Floor');
//     }
//     for (int i = 0; i < widget.initialBedrooms; i++) {
//       _addRoomForm('Bedroom');
//     }
//     for (int i = 0; i < widget.initialBathrooms; i++) {
//       _addRoomForm('Bathroom');
//     }
//     for (int i = 0; i < widget.initialKitchens; i++) {
//       _addRoomForm('Kitchen');
//     }
//     for (int i = 0; i < widget.initialHalls; i++) {
//       _addRoomForm('Hall');
//     }
//     for (int i = 0; i < widget.initialGarages; i++) {
//       _addRoomForm('Garage');
//     }
//   }

//   void _addRoomForm(String roomType) {
//     Map<String, dynamic> defaultData = {
//       "type": roomType.toLowerCase(),
//       "number": 0,
//       "size": null,
//       "is_renovated": false,
//       "description": '',
//       "files": []
//     };
//     setState(() {
//       final formKey = GlobalKey<_RoomFormState>();
//       print('message%%%%%%%%%%%% $formKey');
//       _formKeys.add(formKey);
//       switch (roomType) {
//         case 'Floor':
//           _floorCount++;
//           defaultData["number"] = _floorCount;

//           _forms.add(RoomForm(
//               roomType: roomType, index: _floorCount, formKey: formKey));
//           break;
//         case 'Bedroom':
//           _bedroomCount++;
//           defaultData["number"] = _bedroomCount;
//           _forms.add(RoomForm(
//               roomType: roomType, index: _bedroomCount, formKey: formKey));
//           break;
//         case 'Bathroom':
//           _bathroomCount++;
//           defaultData["number"] = _bathroomCount;

//           _forms.add(RoomForm(
//               roomType: roomType, index: _bathroomCount, formKey: formKey));
//           break;
//         case 'Kitchen':
//           _kitchenCount++;
//           defaultData["number"] = _kitchenCount;
//           _forms.add(RoomForm(
//               roomType: roomType, index: _kitchenCount, formKey: formKey));
//           break;
//         case 'Hall':
//           _hallCount++;
//           defaultData["number"] = _hallCount;

//           _forms.add(RoomForm(
//               roomType: roomType, index: _hallCount, formKey: formKey));
//           break;
//         case 'Garage':
//           _garageCount++;
//           defaultData["number"] = _garageCount;
//           _forms.add(RoomForm(
//               roomType: roomType, index: _garageCount, formKey: formKey));
//           break;
//       }
//       _defaultData.add(defaultData);
//     });
//   }

//   void _submitData() {
//     List<Map<String, dynamic>> data = [];
//     for (int i = 0; i < _formKeys.length; i++) {
//       final formKey = _formKeys[i];
//       final formState = formKey.currentState;

//       if (formState != null) {
//         final formData = formState.getData();
//         if (formData != null) {
//           _defaultData[i] = formData;
//         }
//       }
//       data.add(_defaultData[i]);
//     }
//     print(
//         'datadatdatdatdatda $data'); // This is where you would send data to your API
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room Details'),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: _addRoomForm,
//             itemBuilder: (BuildContext context) {
//               return {
//                 'Floor',
//                 'Bedroom',
//                 'Bathroom',
//                 'Kitchen',
//                 'Hall',
//                 'Garage'
//               }.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text('Add $choice'),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: _forms,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _submitData,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class SlashedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.0;

    final double step = 10;
    for (double x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _TextFormFieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 5, size.width, size.height),
        Radius.circular(10),
      ));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

Future<void> _pickFiles() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'], // Specify allowed file types
    );
    if (result != null) {
      // Process picked files
    }
  } catch (e) {
    print('Error picking files: $e');
  }
}

Future<void> _pickImageFromCamera() async {
  // Implement logic to capture image from camera
}

Future<void> _showOptions(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Upload from File Manager'),
              onTap: () {
                Navigator.pop(context);
                _pickFiles();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Upload from Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
          ],
        ),
      );
    },
  );
}

class RoomForm extends StatefulWidget {
  final Key key;
  final String roomType;
  final int index;
  final GlobalKey<_RoomFormState> formKey;

  RoomForm({
    required this.key,
    required this.roomType,
    required this.index,
    required this.formKey,
  }) : super(key: formKey);

  @override
  _RoomFormState createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fixturesController = TextEditingController();
  String _isRenovated = 'No';
  List<String> _files = [];

  @override
  void dispose() {
    _sizeController.dispose();
    _descriptionController.dispose();
    _fixturesController.dispose();
    super.dispose();
  }

  Map<String, dynamic> getData() {
    final dataaa = {
      "type": widget.roomType.toLowerCase(),
      "number": widget.index,
      "size": _sizeController.text,
      "is_renovated": _isRenovated == 'Yes',
      "description": _descriptionController.text,
      "files": _files
    };

    print('message----->>>><<<<---- $dataaa');
    return dataaa;
  }

  Future<void> _pickImageFromCamera() async {
    // final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    // if (pickedFile != null) {
    //   setState(() {
    //     _files.add(pickedFile.path);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.roomType} ${widget.index}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextFormField(
              controller: _sizeController,
              decoration: InputDecoration(
                labelText: 'Enter Size of ${widget.roomType}-${widget.index}',
                labelStyle: TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
                title: Text(
                  'Is Renovated (${widget.roomType}-${widget.index})',
                  style: TextStyle(fontSize: 12),
                ),
                subtitle: Row(children: [
                  Radio(
                    value: 'Yes',
                    groupValue: _isRenovated,
                    onChanged: (value) {
                      setState(() {
                        _isRenovated = value.toString();
                      });
                    },
                  ),
                  Text('Yes'),
                  Radio(
                    value: 'No',
                    groupValue: _isRenovated,
                    onChanged: (value) {
                      setState(() {
                        _isRenovated = value.toString();
                      });
                    },
                  ),
                  Text('No'),
                ])),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText:
                      'Add Description for ${widget.roomType}-${widget.index}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(fontSize: 12)),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ClipPath(
              clipper: _TextFormFieldClipper(),
              child: CustomPaint(
                painter: SlashedLinesPainter(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: _fixturesController,
                    maxLines: 4,
                    onTap: () {
                      _showOptions(context);
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Description of Fixtures and Articles Added',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomDetailsPage extends StatefulWidget {
  final int initialFloors;
  final int initialBedrooms;
  final int initialBathrooms;
  final int initialKitchens;
  final int initialHalls;
  final int initialGarages;

  RoomDetailsPage({
    required this.initialFloors,
    required this.initialBedrooms,
    required this.initialBathrooms,
    required this.initialKitchens,
    required this.initialHalls,
    required this.initialGarages,
  });

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  List<RoomForm> _forms = [];
  List<GlobalKey<_RoomFormState>> _formKeys = [];
  final List<Map<String, dynamic>> _defaultData = [];
  int _floorCount = 0;
  int _bedroomCount = 0;
  int _bathroomCount = 0;
  int _kitchenCount = 0;
  int _hallCount = 0;
  int _garageCount = 0;

  @override
  void initState() {
    super.initState();
    initializeForms();
  }

  void initializeForms() {
    for (int i = 0; i < widget.initialFloors; i++) {
      _addRoomForm('Floor');
    }
    for (int i = 0; i < widget.initialBedrooms; i++) {
      _addRoomForm('Bedroom');
    }
    for (int i = 0; i < widget.initialBathrooms; i++) {
      _addRoomForm('Bathroom');
    }
    for (int i = 0; i < widget.initialKitchens; i++) {
      _addRoomForm('Kitchen');
    }
    for (int i = 0; i < widget.initialHalls; i++) {
      _addRoomForm('Hall');
    }
    for (int i = 0; i < widget.initialGarages; i++) {
      _addRoomForm('Garage');
    }
  }

  void _addRoomForm(String roomType) {
    Map<String, dynamic> defaultData = {
      "type": roomType.toLowerCase(),
      "number": 0,
      "size": null,
      "is_renovated": false,
      "description": '',
      "files": []
    };
    setState(() {
      final formKey = GlobalKey<_RoomFormState>();
      print('message%%%%%%%%%%%% $formKey');
      _formKeys.add(formKey);
      switch (roomType) {
        case 'Floor':
          _floorCount++;
          defaultData["number"] = _floorCount;

          _forms.add(RoomForm(
              key: ValueKey('Floor_$_floorCount'), // Add unique key
              roomType: roomType,
              index: _floorCount,
              formKey: formKey));
          break;
        case 'Bedroom':
          _bedroomCount++;
          defaultData["number"] = _bedroomCount;
          _forms.add(RoomForm(
              key: ValueKey('Bedroom_$_bedroomCount'), // Add unique key
              roomType: roomType,
              index: _bedroomCount,
              formKey: formKey));
          break;
        case 'Bathroom':
          _bathroomCount++;
          defaultData["number"] = _bathroomCount;

          _forms.add(RoomForm(
              key: ValueKey('Bathroom_$_bathroomCount'), // Add unique key
              roomType: roomType,
              index: _bathroomCount,
              formKey: formKey));
          break;
        case 'Kitchen':
          _kitchenCount++;
          defaultData["number"] = _kitchenCount;
          _forms.add(RoomForm(
              key: ValueKey('Kitchen_$_kitchenCount'), // Add unique key
              roomType: roomType,
              index: _kitchenCount,
              formKey: formKey));
          break;
        case 'Hall':
          _hallCount++;
          defaultData["number"] = _hallCount;

          _forms.add(RoomForm(
              key: ValueKey('Hall_$_hallCount'), // Add unique key
              roomType: roomType,
              index: _hallCount,
              formKey: formKey));
          break;
        case 'Garage':
          _garageCount++;
          defaultData["number"] = _garageCount;
          _forms.add(RoomForm(
              key: ValueKey('Garage_$_garageCount'), // Add unique key
              roomType: roomType,
              index: _garageCount,
              formKey: formKey));
          break;
      }
      _defaultData.add(defaultData);
    });
  }

  void _submitData() {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < _formKeys.length; i++) {
      final formKey = _formKeys[i];
      final formState = formKey.currentState;

      if (formState != null) {
        final formData = formState.getData();
        if (formData != null) {
          _defaultData[i] = formData;
        }
      }
      data.add(_defaultData[i]);
    }
    print(
        'datadatdatdatdatda $data'); // This is where you would send data to your API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _addRoomForm,
            itemBuilder: (BuildContext context) {
              return {
                'Floor',
                'Bedroom',
                'Bathroom',
                'Kitchen',
                'Hall',
                'Garage'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text('Add $choice'),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: _forms,
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}



 // Positioned(
                //   top: 30,
                //   left: 20,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white,
                //     child: Icon(Icons.favorite, color: Colors.red),
                //   ),
                // ),
                // Positioned(
                //   top: 30,
                //   right: 20,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white,
                //     child: Icon(Icons.download, color: Colors.green),
                //   ),

                // ),


                 // ListTile(
                  //   contentPadding: EdgeInsets.all(16),
                  //   leading: CircleAvatar(
                  //     backgroundImage:
                  //         NetworkImage('https://via.placeholder.com/150'),
                  //   ),
                  //   title: Text(
                  //     'Sangvaleap',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  //   subtitle: Text(
                  //     'Property Owner',
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  //   // trailing: Row(
                  //   //   mainAxisSize: MainAxisSize.min,
                  //   //   children: [
                  //   //     ElevatedButton(
                  //   //       onPressed: () {},
                  //   //       child: Text('Get Schedule'),
                  //   //     ),
                  //   //     SizedBox(width: 8),
                  //   //     ElevatedButton.icon(
                  //   //       onPressed: () {},
                  //   //       icon: Icon(Icons.call),
                  //   //       label: Text('Call'),
                  //   //       style: ElevatedButton.styleFrom(
                  //   //         padding: EdgeInsets.symmetric(
                  //   //             vertical: 15, horizontal: 30),
                  //   //         shape: RoundedRectangleBorder(
                  //   //           borderRadius: BorderRadius.circular(10),
                  //   //         ),
                  //   //       ),
                  //   //     ),
                  //   //   ],
                  //   // ),
                  // ),
                  // SizedBox(height: 16),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {},
                  //       child: Text('Get Schedule'),
                  //     ),
                  //     SizedBox(width: 8),
                  //     ElevatedButton(
                  //       onPressed: () {},
                  //       child: Text('Call'),
                  //     ),
                  //   ],
                  // ),