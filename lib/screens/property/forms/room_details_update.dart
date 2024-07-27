import 'package:flutter/material.dart';
import 'package:home_vault/screens/user/signin_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_vault/screens/main/landing_page.dart';
import 'dart:io';
import 'package:home_vault/screens/property/propertyPage2.dart';
// /Users/nagavamsi/Documents/doc_manager/

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

class PropertyDetailsEditForm extends StatefulWidget {
  final String roomType;
  final int index;
  final Map<String, dynamic> initialData;
  final ValueChanged<Map<String, dynamic>> onChanged;

  PropertyDetailsEditForm({
    required this.roomType,
    required this.index,
    required this.initialData,
    required this.onChanged,
  });

  @override
  _PropertyDetailsEditFormState createState() =>
      _PropertyDetailsEditFormState();
}

class _PropertyDetailsEditFormState extends State<PropertyDetailsEditForm> {
  late TextEditingController _sizeController;
  late TextEditingController _descriptionController;
  late TextEditingController _fixturesController;
  late String _isRenovated;
  late List<String> _files;
  List<dynamic> _invoiceFiles = [];

  @override
  void initState() {
    super.initState();
    _sizeController = TextEditingController(text: widget.initialData['size']);
    _descriptionController =
        TextEditingController(text: widget.initialData['description']);
    _fixturesController = TextEditingController();
    _isRenovated = widget.initialData['is_renovated'] ? 'Yes' : 'No';
    _files = List<String>.from(widget.initialData['files']);
    _invoiceFiles = List<dynamic>.from(widget.initialData['files'] ?? []);
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _descriptionController.dispose();
    _fixturesController.dispose();
    super.dispose();
  }

  void _updateParent() {
    widget.onChanged({
      'id': widget.initialData['id'],
      'type': widget.roomType.toLowerCase(),
      'number': widget.index,
      'size': _sizeController.text,
      'is_renovated': _isRenovated == 'Yes',
      'description': _descriptionController.text,
      'files': _files,
      'invoiceFiles': _invoiceFiles,
    });
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );
      if (result != null) {
        setState(() {
          _invoiceFiles.addAll(result.files);
          _files.addAll(result.files.map((file) => file.name));
          _updateParent();
        });
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
              // ListTile(
              //   leading: Icon(Icons.camera_alt),
              //   title: Text('Upload from Camera'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     _pickImageFromCamera();
              //   },
              // ),
            ],
          ),
        );
      },
    );
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
              onChanged: (value) => _updateParent(),
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
                        _updateParent();
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
                        _updateParent();
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
              onChanged: (value) => _updateParent(),
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
                      labelText: _invoiceFiles.isNotEmpty
                          ? '${_invoiceFiles.length} files selected'
                          : 'Upload the files',
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

// initialBathrooms: 3,
// initialBedrooms: 1,
// initialFloors: 1,
// initialGarages: 1,
// initialHalls: 1,
// initialKitchens: 1,
// initialData: [
//   {
//     "id": 106,
//     "type": "floor",
//     "size": "12",
//     "is_renovated": false,
//     "description": "rdftygjhkjk",
//     "files": [
//       "/files/db55a387-cb43-4f6f-8ab7-a8dc721db842/IMG_20240528_205535.jpg"
//     ]
//   },
//   {
//     "id": 107,
//     "type": "bedroom",
//     "size": "23",
//     "is_renovated": false,
//     "description": "23",
//     "files": []
//   },
//   {
//     "id": 108,
//     "type": "bathroom",
//     "size": "23",
//     "is_renovated": false,
//     "description": "22",
//     "files": []
//   },
//   {
//     "id": 109,
//     "type": "kitchen",
//     "size": "223",
//     "is_renovated": false,
//     "description": "223",
//     "files": []
//   },
//   {
//     "id": 110,
//     "type": "hall",
//     "size": "2234",
//     "is_renovated": false,
//     "description": "2234",
//     "files": []
//   },
//   {
//     "id": 111,
//     "type": "garage",
//     "size": "22345",
//     "is_renovated": false,
//     "description": "22345",
//     "files": []
//   }
// ],

class RoomDetailsEditForm extends StatefulWidget {
  // final int initialFloors;
  // final int initialBedrooms;
  // final int initialBathrooms;
  // final int initialKitchens;
  // final int initialHalls;
  // final int initialGarages;
  final String projectID;
  // final List<Map<String, dynamic>> initialData; // Add this line

  RoomDetailsEditForm({
    // required this.initialFloors,
    // required this.initialBedrooms,
    // required this.initialBathrooms,
    // required this.initialKitchens,
    // required this.initialHalls,
    // required this.initialGarages,
    required this.projectID,
    // required this.initialData, // Add this line
  });

  @override
  _RoomDetailsEditFormState createState() => _RoomDetailsEditFormState();
}

class _RoomDetailsEditFormState extends State<RoomDetailsEditForm> {
  final storage = FlutterSecureStorage();

  List<Map<String, dynamic>> _formData = [];
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

  _fetchPropertyDetails() async {
    print('deletedddddd');
    final accessToken = await storage.read(key: 'access_token');
    final headers = {"Authorization": "Token $accessToken"};
    final response = await http.get(
        Uri.parse(
            'https://b6d9-115-98-217-224.ngrok-free.app/api/edit_individual_data?record_id=${widget.projectID}'),
        headers: headers);

    if (response.statusCode == 200) {
      final data__qww = jsonDecode(response.body);
      print('messagedata__qww $data__qww');
      return data__qww;
    } else {
      print('Failed to download PDF');
    }
  }

  Future<void> initializeForms() async {
    print('message Starteddddd');
    final actual_data = await _fetchPropertyDetails();
    print('message endeddd');
    final initialData = actual_data['form_data'];
    print('initialDatainitialDatainitialData $initialData');
    final initialFloors = actual_data['floor'];
    final initialBedrooms = actual_data['bedroom'];
    final initialBathrooms = actual_data['bathroom'];
    final initialKitchens = actual_data['kitchen'];
    final initialHalls = actual_data['hall'];
    final initialGarages = actual_data['garage'];
    if (initialData.isNotEmpty) {
      setState(() {
        // _formData = List<Map<String, dynamic>>.from(initialData);
        _formData = List<Map<String, dynamic>>.from(initialData);
      });

      for (var form in initialData) {
        switch (form['type']) {
          case 'floor':
            _floorCount++;
            break;
          case 'bedroom':
            _bedroomCount++;
            break;
          case 'bathroom':
            _bathroomCount++;
            break;
          case 'kitchen':
            _kitchenCount++;
            break;
          case 'hall':
            _hallCount++;
            break;
          case 'garage':
            _garageCount++;
            break;
        }
      }
    } else {
      setState(() {
        _floorCount = initialFloors;
        _bedroomCount = initialBedrooms;
        _bathroomCount = initialBathrooms;
        _kitchenCount = initialKitchens;
        _hallCount = initialHalls;
        _garageCount = initialGarages;

        _formData = [
          for (int i = 1; i <= _floorCount; i++)
            createPropertyDetailsEditFormData('Floor', i),
          for (int i = 1; i <= _bedroomCount; i++)
            createPropertyDetailsEditFormData('Bedroom', i),
          for (int i = 1; i <= _bathroomCount; i++)
            createPropertyDetailsEditFormData('Bathroom', i),
          for (int i = 1; i <= _kitchenCount; i++)
            createPropertyDetailsEditFormData('Kitchen', i),
          for (int i = 1; i <= _hallCount; i++)
            createPropertyDetailsEditFormData('Hall', i),
          for (int i = 1; i <= _garageCount; i++)
            createPropertyDetailsEditFormData('Garage', i),
        ];
        print('message_formData_formData $_formData');
      });
    }
  }

  Map<String, dynamic> createPropertyDetailsEditFormData(
      String roomType, int index) {
    print('messageindexindexindex->>>> $index');
    return {
      "id": "",
      'type': roomType.toLowerCase(),
      'number': index,
      'size': '',
      'is_renovated': false,
      'description': '',
      'files': [],
      'invoiceFiles': [],
    };
  }

  void updateFormData(int index, Map<String, dynamic> data) {
    setState(() {
      print('indexindexindex $index');
      _formData[index] = data;
      print('datadatadata $_formData');
    });
  }

  Future<void> saveFormData() async {
    // Save logic here
    // final url = Uri.parse("https://b6d9-115-98-217-224.ngrok-free.app/api/edit_individual_data");
    // 'http://10.0.2.2:8000/property_module/project/${widget.projectID}/rooms/');
    // final token = await storage.read(key: 'jwt_token');
    // final headers = {
    //   // 'Authorization': 'Token $token',
    //   'Content-Type': 'application/json'
    // };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://b6d9-115-98-217-224.ngrok-free.app/api/edit_individual_data'),
    );
    final accessToken = await storage.read(key: 'access_token');

    request.headers['Authorization'] = 'Token $accessToken';
    request.fields['project_id'] = widget.projectID;
    request.fields['form_data'] = jsonEncode(_formData.map((form) {
      final Map<String, dynamic> newForm = Map.from(form);
      newForm.remove('invoiceFiles');
      return newForm;
    }).toList());

    // for (var form in _formData) {
    //   for (var item in form['invoiceFiles']) {
    //     // request.files.add(await http.MultipartFile.fromPath(
    //     //   'files',
    //     //   file.path,
    //     //   filename: file.name,
    //     // ));
    //     if (item is PlatformFile) {
    //       // Handle file
    //       request.files.add(await http.MultipartFile.fromPath(
    //         'files',
    //         item.path,
    //         filename: item.name,
    //       ));
    //     } else if (item is String) {
    //       // Handle URL (optional, download the file and then add it to the request)
    //       // Example of downloading a file from a URL
    //       final response = await http.get(Uri.parse(item));
    //       if (response.statusCode == 200) {
    //         final fileName = item.split('/').last;
    //         final tempFile = File('https://b6d9-115-98-217-224.ngrok-free.app/$fileName');
    //         await tempFile.writeAsBytes(response.bodyBytes);

    //         request.files.add(await http.MultipartFile.fromPath(
    //           'files',
    //           tempFile.path,
    //           filename: fileName,
    //         ));
    //       } else {
    //         // Handle error case
    //         print('Failed to download file from URL: $item');
    //       }
    //     }
    //   }
    // }

    Map<String, List<String>> all_existsing_files = {};

    for (var form in _formData) {
      all_existsing_files[form['id'].toString()] = [];
      if (form['invoiceFiles'] == null) {
        all_existsing_files[form['id'].toString()]?.add("Nothing");
        continue;
      }
      for (var item in form['invoiceFiles']) {
        if (item is PlatformFile) {
          final filePath = item.path;
          if (filePath != null) {
            request.files.add(await http.MultipartFile.fromPath(
              'files',
              filePath,
              filename: item.name,
            ));
          } else {
            print('File path is null for ${item.name}');
          }
        } else if (item is String) {
          all_existsing_files[form['id'].toString()]?.add(item);
        } else {
          // Handle error case
          print('Failed to download file from URL: $item');
        }
      }
    }
    String allExistingFilesJson = jsonEncode(all_existsing_files);
    // request.fields['all_existing_files'] = allExistingFilesJson;
    request.fields['all_existing_files'] = allExistingFilesJson;
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room details saved successfully')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PropertyDetailsPage(projectID: widget.projectID),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save room details')));
    }
  }

  void _addRoomForm(String roomType) {
    int roomCount = 0;
    switch (roomType) {
      case 'Floor':
        _floorCount++;
        roomCount = _floorCount;
        break;
      case 'Bedroom':
        _bedroomCount++;
        roomCount = _bedroomCount;
        break;
      case 'Bathroom':
        _bathroomCount++;
        roomCount = _bathroomCount;
        break;
      case 'Kitchen':
        _kitchenCount++;
        roomCount = _kitchenCount;
        break;
      case 'Hall':
        _hallCount++;
        roomCount = _hallCount;
        break;
      case 'Garage':
        _garageCount++;
        roomCount = _garageCount;
        break;
    }

    setState(() {
      _formData.add({
        "type": roomType.toLowerCase(),
        "number": roomCount,
        "size": '',
        "is_renovated": false,
        "description": '',
        "files": [],
        "invoiceFiles": [] // Add the files field here
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Property Details'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (int i = 0; i < _formData.length; i++)
                PropertyDetailsEditForm(
                  roomType: _formData[i]['type'],
                  index: i,
                  initialData: _formData[i],
                  onChanged: (data) => updateFormData(i, data),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveFormData,
                child: Text('Update Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
