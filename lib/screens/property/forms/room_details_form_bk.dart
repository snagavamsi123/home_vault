// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:home_vault/constants.dart';
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
//       // need to add dynamically based on  in which section user uploaded
//       // setState(() {
//       // _invoiceFiles.addAll(result.files);
//       // });
//     }
//   } catch (e) {
//     print('Error picking files: $e');
//   }
// }

// // void _saveRecord() {
// //   if (_formKey.currentState!.validate()) {
// //     // Save the record
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Record saved')),
// //     );
// //   }
// // }

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

// class RoomDetailsPage extends StatelessWidget {
// final int floors;
// final int bedrooms;
// final int bathrooms;
// final int kitchens;
// final int halls;
// final int garages;

// RoomDetailsPage({
//   required this.floors,
//   required this.bedrooms,
//   required this.bathrooms,
//   required this.kitchens,
//   required this.halls,
//   required this.garages,
// });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: _buildRoomForms(),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildRoomForms() {
//     List<Widget> forms = [];

//     for (int i = 0; i < floors; i++) {
//       forms.add(RoomForm(roomType: 'Floor', index: i + 1));
//     }
//     for (int i = 0; i < bedrooms; i++) {
//       forms.add(RoomForm(roomType: 'Bedroom', index: i + 1));
//     }
//     for (int i = 0; i < bathrooms; i++) {
//       forms.add(RoomForm(roomType: 'Bathroom', index: i + 1));
//     }
//     for (int i = 0; i < kitchens; i++) {
//       forms.add(RoomForm(roomType: 'Kitchen', index: i + 1));
//     }
//     for (int i = 0; i < halls; i++) {
//       forms.add(RoomForm(roomType: 'Hall', index: i + 1));
//     }
//     for (int i = 0; i < garages; i++) {
//       forms.add(RoomForm(roomType: 'Garage', index: i + 1));
//     }

//     return forms;
//   }
// }

// class RoomForm extends StatelessWidget {
//   final String roomType;
//   final int index;
//   String _isRenovated = 'No';

//   RoomForm({required this.roomType, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('$roomType $index',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Enter Size of $roomType-$index',
//                 labelStyle: TextStyle(fontSize: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ListTile(
//                 title: Text(
//                   'Is Renovated ($roomType-$index)',
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 subtitle: Row(children: [
//                   Radio(
//                     value: 'Yes',
//                     groupValue: _isRenovated,
//                     onChanged: (value) {},
//                   ),
//                   Text('Yes'),
//                   Radio(
//                     value: 'No',
//                     groupValue: _isRenovated,
//                     onChanged: (value) {},
//                   ),
//                   Text('No'),
//                 ])),
//             SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(
//                   labelText: 'Add Description for $roomType-$index',
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

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:home_vault/constants.dart';
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
//   int _floorCount = 0;
//   int _bedroomCount = 0;
//   int _bathroomCount = 0;
//   int _kitchenCount = 0;
//   int _hallCount = 0;
//   int _garageCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeForms();
//   }

//   void _initializeForms() {
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
//     setState(() {
//       switch (roomType) {
//         case 'Floor':
//           _floorCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _floorCount));
//           break;
//         case 'Bedroom':
//           _bedroomCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _bedroomCount));
//           break;
//         case 'Bathroom':
//           _bathroomCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _bathroomCount));
//           break;
//         case 'Kitchen':
//           _kitchenCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _kitchenCount));
//           break;
//         case 'Hall':
//           _hallCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _hallCount));
//           break;
//         case 'Garage':
//           _garageCount++;
//           _forms.add(RoomForm(roomType: roomType, index: _garageCount));
//           break;
//       }
//     });
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
//         child: ListView(
//           children: _forms,
//         ),
//       ),
//     );
//   }
// }

// class RoomForm extends StatefulWidget {
//   final String roomType;
//   final int index;

//   RoomForm({required this.roomType, required this.index});

//   @override
//   _RoomFormState createState() => _RoomFormState();
// }

// class _RoomFormState extends State<RoomForm> {
//   final TextEditingController _sizeController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _fixturesController = TextEditingController();
//   String _isRenovated = 'No';

//   @override
//   void dispose() {
//     _sizeController.dispose();
//     _descriptionController.dispose();
//     _fixturesController.dispose();
//     super.dispose();
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