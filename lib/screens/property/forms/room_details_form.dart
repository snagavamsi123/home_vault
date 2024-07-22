import 'package:flutter/material.dart';
import 'package:home_vault/screens/user/signin_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_vault/screens/main/landing_page.dart';

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

class RoomForm extends StatefulWidget {
  final String roomType;
  final int index;
  final Map<String, dynamic> initialData;
  final ValueChanged<Map<String, dynamic>> onChanged;

  RoomForm({
    required this.roomType,
    required this.index,
    required this.initialData,
    required this.onChanged,
  });

  @override
  _RoomFormState createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  late TextEditingController _sizeController;
  late TextEditingController _descriptionController;
  late TextEditingController _fixturesController;
  late String _isRenovated;
  late List<String> _files;
  List<PlatformFile> _invoiceFiles = [];

  @override
  void initState() {
    super.initState();
    _sizeController = TextEditingController(text: widget.initialData['size']);
    _descriptionController =
        TextEditingController(text: widget.initialData['description']);
    _fixturesController = TextEditingController();
    _isRenovated = widget.initialData['is_renovated'] ? 'Yes' : 'No';
    _files = List<String>.from(widget.initialData['files']);
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
      'type': widget.roomType.toLowerCase(),
      'number': widget.index,
      'size': _sizeController.text,
      'is_renovated': _isRenovated == 'Yes',
      'description': _descriptionController.text,
      'files': _files,
      'invoiceFiles': _invoiceFiles, // Add the selected files here
    });
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
        setState(() {
          _invoiceFiles.addAll(result.files);
          _files.addAll(result.files.map((file) => file.name));
          _updateParent(); // Update parent with the new file data
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
                      // 'Description of Fixtures and Articles Added',
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
  final String projectID;

  RoomDetailsPage({
    required this.initialFloors,
    required this.initialBedrooms,
    required this.initialBathrooms,
    required this.initialKitchens,
    required this.initialHalls,
    required this.initialGarages,
    required this.projectID,
  });

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
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

  void _updateFormData(int index, Map<String, dynamic> newData) {
    setState(() {
      _formData[index] = newData;
    });
  }

  void _submitData() async {
    print('Submitted data: $_formData');
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:9001/api/store_individual_data'),
    );
    // request.headers['Authorization'] = 'Bearer $accssToken';
    final _initialData = {
      "totalFloors": widget.initialFloors,
      "totalBedrooms": widget.initialBedrooms,
      "totalBathrooms": widget.initialBathrooms,
      "totalKitchens": widget.initialKitchens,
      "totalHalls": widget.initialHalls,
      "totalGarages": widget.initialGarages
    };
    final accessToken = await storage.read(key: 'access_token');
    print('accessTokenaccessToken $accessToken');
    request.headers['Authorization'] = 'Bearer $accessToken';
    request.fields['initial_data'] = jsonEncode(_initialData);
    request.fields['project_id'] = widget.projectID;
    request.fields['form_data'] = jsonEncode(_formData.map((form) {
      final Map<String, dynamic> newForm = Map.from(form);
      newForm.remove('invoiceFiles');
      return newForm;
    }).toList());

    for (var form in _formData) {
      for (var file in form['invoiceFiles']) {
        request.files.add(await http.MultipartFile.fromPath(
          'files',
          file.path,
          filename: file.name,
        ));
      }
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Data submitted successfully');
        // Navigation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      } else {
        print('Failed to submit data');
      }
    } catch (error) {
      print('Error submitting data: $error');
    }
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
              child: ListView.builder(
                itemCount: _formData.length,
                itemBuilder: (context, index) {
                  final form = _formData[index];
                  return RoomForm(
                    roomType: form['type'],
                    index: form['number'],
                    initialData: form,
                    onChanged: (newData) => _updateFormData(index, newData),
                  );
                },
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
