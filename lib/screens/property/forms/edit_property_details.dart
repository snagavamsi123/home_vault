import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoomListPage(),
    );
  }
}

class RoomListPage extends StatefulWidget {
  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
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

  void _showEditRoomDialog(Map<String, dynamic> room) {
    TextEditingController sizeController = TextEditingController(text: room['size']);
    TextEditingController descriptionController = TextEditingController(text: room['description']);
    bool isRenovated = room['isRenovated'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${room['roomType']}-${room['number']}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: room['roomType'],
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
                SwitchListTile(
                  value: isRenovated,
                  onChanged: (value) {
                    setState(() {
                      isRenovated = value;
                    });
                  },
                  title: Text('Is Renovated'),
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
              onPressed: () {
                setState(() {
                  room['size'] = sizeController.text;
                  room['isRenovated'] = isRenovated;
                  room['description'] = descriptionController.text;
                });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
      ),
      body: ListView.builder(
        itemCount: _forms.length,
        itemBuilder: (context, index) {
          final room = _forms[index];
          return ListTile(
            title: Text('${room['roomType']}-${room['number']}'),
            trailing: GestureDetector(
              onTap: () => _showEditRoomDialog(room),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Icon(Icons.edit),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRoomForm('Bedroom'), // Change to add different room types
        child: Icon(Icons.add),
      ),
    );
  }
}
