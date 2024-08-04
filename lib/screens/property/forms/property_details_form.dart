import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_vault/screens/property/forms/room_details_form.dart';
import 'package:home_vault/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';

class PropertyDetailsForm extends StatefulWidget {
  final String projectID;
  PropertyDetailsForm({
    required this.projectID,
  });
  @override
  _PropertyDetailsFormState createState() => _PropertyDetailsFormState();
}

class _PropertyDetailsFormState extends State<PropertyDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _kitchensController = TextEditingController();
  final TextEditingController _hallsController = TextEditingController();
  final TextEditingController _garagesController = TextEditingController();
  final _selectedTypeOptionsController = TextEditingController();
  final List<String> TypeOptions = [
    "Floors",
    "Bedrooms",
    "Kitchens",
    "Halls",
    "Garages",
    "Bathrooms",
    // "Swimming pools"
  ];
  final List<String> selectedOptions = [];
  String? _selectedItemNewww;

  void _removeSelectedDetails(typee) {
    setState(() {
      if (typee == "Floors") {
        _floorsController.text = "0";
      } else if (typee == "Bedrooms") {
        _bedroomsController.text = "0";
      } else if (typee == "Kitchens") {
        _kitchensController.text = "0";
      } else if (typee == "Halls") {
        _hallsController.text = "0";
      } else if (typee == "Garages") {
        _garagesController.text = "0";
      } else if (typee == "Bathrooms") {
        _bathroomsController.text = "0";
//
// _kitchensController
// _hallsController
      } else if (typee == "Swimming pools") {
        _bedroomsController.text = "0";
      }
      selectedOptions.remove(typee);
      TypeOptions.add(typee);
      _selectedTypeOptionsController.text = '';
      _selectedItemNewww = null;
    });
  }

  void _selectOptionDetails() {
    final dataaa = _selectedTypeOptionsController.text;
    print('messagedataaa $dataaa');
    setState(() {
      // selectedItem='';
      selectedOptions.add(dataaa);
      TypeOptions.remove(dataaa);
      _selectedTypeOptionsController.text = '';
      _selectedItemNewww = null;
    });
  }

  String sanitizeInput(input) {
    try {
      input = int.tryParse(input.trim());
      if (input == null) {
        print('Error parsing integer');
        return "0";
      } else {
        print('Parsed number: $input');
        return input.toString();
      }
    } catch (e) {
      return "0";
    }
  }

  void _navigateToRoomDetails() {
    if (_formKey.currentState!.validate()) {
      final initialFloors = int.parse(sanitizeInput(_floorsController.text));
      final initialBedrooms =
          int.parse(sanitizeInput(_bedroomsController.text));
      final initialBathrooms =
          int.parse(sanitizeInput(_bathroomsController.text));
      final initialKitchens =
          int.parse(sanitizeInput(_kitchensController.text));
      final initialHalls = int.parse(sanitizeInput(_hallsController.text));
      final initialGarages = int.parse(sanitizeInput(_garagesController.text));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RoomDetailsPage(
              initialFloors: initialFloors,
              initialBedrooms: initialBedrooms,
              initialBathrooms: initialBathrooms,
              initialKitchens: initialKitchens,
              initialHalls: initialHalls,
              initialGarages: initialGarages,
              projectID: widget.projectID),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Details Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSearchBox: false,
                        ),
                        items: TypeOptions,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: 'Enter Type',
                            labelStyle: TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onChanged: (String? selectedItem) {
                          setState(() {
                            _selectedItemNewww =
                                selectedItem; // Update the selected item
                            _selectedTypeOptionsController.text =
                                selectedItem ?? "";
                          });
                        },
                        selectedItem: _selectedItemNewww,
                      ),
                    ),
                    SizedBox(width: 1),
                    ElevatedButton(
                      onPressed: () {
                        _selectOptionDetails();
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
                if (selectedOptions.contains('Floors')) SizedBox(height: 20),
                // if (selectedOptions.contains('Floors'))
                //   TextFormField(
                //     controller: _floorsController,
                //     decoration: InputDecoration(
                //       labelText: 'Number of Floors',
                //       labelStyle: TextStyle(fontSize: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a number';
                //       }
                //       return null;
                //     },
                //   ),
                if (selectedOptions.contains('Floors'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _floorsController,
                              decoration: InputDecoration(
                                labelText: 'Number of Floors',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Perform any action needed when delete is pressed, e.g., clear the field
                              _bathroomsController.clear();
                              _removeSelectedDetails("Floors");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                if (selectedOptions.contains('Bedrooms')) SizedBox(height: 20),
                if (selectedOptions.contains('Bedrooms'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _bedroomsController,
                              decoration: InputDecoration(
                                labelText: 'Number of Bedrooms',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _removeSelectedDetails("Bedrooms");
                              _bedroomsController.clear();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                // TextFormField(
                //   controller: _bedroomsController,
                //   // decoration: InputDecoration(labelText: 'Number of Bedrooms'),
                //   decoration: InputDecoration(
                //     labelText: 'Number of Bedrooms',
                //     labelStyle: TextStyle(fontSize: 12),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   keyboardType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a number';
                //     }
                //     return null;
                //   },
                // ),
                if (selectedOptions.contains('Bathrooms')) SizedBox(height: 20),
                // if (selectedOptions.contains('Bathrooms'))
                //   TextFormField(
                //     controller: _bathroomsController,
                //     // decoration: InputDecoration(labelText: 'Number of Bathrooms'),
                //     decoration: InputDecoration(
                //       labelText: 'Number of Bathrooms',
                //       labelStyle: TextStyle(fontSize: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a number';
                //       }
                //       return null;
                //     },
                //   ),
                if (selectedOptions.contains('Bathrooms'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _bathroomsController,
                              decoration: InputDecoration(
                                labelText: 'Number of Bathrooms',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Perform any action needed when delete is pressed, e.g., clear the field
                              _bathroomsController.clear();
                              _removeSelectedDetails("Bathrooms");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                if (selectedOptions.contains('Kitchens')) SizedBox(height: 20),
                // if (selectedOptions.contains('Kitchens'))
                //   TextFormField(
                //     controller: _kitchensController,
                //     // decoration: InputDecoration(labelText: 'Number of Kitchens'),
                //     decoration: InputDecoration(
                //       labelText: 'Number of Kitchens',
                //       labelStyle: TextStyle(fontSize: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a number';
                //       }
                //       return null;
                //     },
                //   ),
                if (selectedOptions.contains('Kitchens'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _kitchensController,
                              decoration: InputDecoration(
                                labelText: 'Number of Kitchens',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Clear the kitchens input field and remove the option from selectedOptions
                              _kitchensController.clear();
                              _removeSelectedDetails("Kitchens");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                if (selectedOptions.contains('Halls')) SizedBox(height: 20),
                // if (selectedOptions.contains('Halls'))
                //   TextFormField(
                //     controller: _hallsController,
                //     // decoration: InputDecoration(labelText: 'Number of Halls'),
                //     decoration: InputDecoration(
                //       labelText: 'Number of Halls',
                //       labelStyle: TextStyle(fontSize: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a number';
                //       }
                //       return null;
                //     },
                //   ),
                if (selectedOptions.contains('Halls'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _hallsController,
                              decoration: InputDecoration(
                                labelText: 'Number of Halls',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Clear the halls input field and remove the option from selectedOptions
                              _hallsController.clear();
                              _removeSelectedDetails("Halls");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                if (selectedOptions.contains('Garages')) SizedBox(height: 20),
                // if (selectedOptions.contains('Garages'))
                //   TextFormField(
                //     controller: _garagesController,
                //     // decoration: InputDecoration(labelText: 'Number of Garages'),
                //     decoration: InputDecoration(
                //       labelText: 'Number of Garages',
                //       labelStyle: TextStyle(fontSize: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a number';
                //       }
                //       return null;
                //     },
                //   ),
                if (selectedOptions.contains('Garages'))
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _garagesController,
                              decoration: InputDecoration(
                                labelText: 'Number of Garages',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Clear the garages input field and remove the option from selectedOptions
                              _garagesController.clear();
                              _removeSelectedDetails("Garages");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (selectedOptions.length > 0)
                  ElevatedButton(
                    onPressed: _navigateToRoomDetails,
                    child: Text('Next'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
