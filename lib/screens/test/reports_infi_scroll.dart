import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_vault/responsive.dart';
import 'package:home_vault/data/files_data.dart';
import 'package:home_vault/screens/components/smallGrid.dart';
import '../../../constants.dart';
import 'package:home_vault/screens/components/Files.dart';
import 'package:http/http.dart' as http;

class AllFilesCardGridView extends StatelessWidget {
  const AllFilesCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.newFiles,
    required this.scrollController,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final dynamic scrollController;
  final List<Files> newFiles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: newFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        return SmallGridWIdgetPage(file: newFiles[index]);
      },
    );
  }
}

class ReportsContent extends StatefulWidget {
  @override
  _ReportsContentState createState() => _ReportsContentState();
}

class _ReportsContentState extends State<ReportsContent> {
  List<DateWiseFiles> dateWiseFiles = [];
  ScrollController _scrollController = ScrollController();
  int _pageNumber = 0;
  bool _isLoading = false;
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7 &&
        !_isLoading) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://b6d9-115-98-217-224.ngrok-free.app/api/fetch_recent_data?page=$_pageNumber&size=$_pageSize'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final newFiles = DateWiseFiles.fromJsonList(jsonList);
        setState(() {
          _pageNumber++;
          dateWiseFiles.addAll(newFiles);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (_isLoading && dateWiseFiles.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError && dateWiseFiles.isEmpty) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    for (var dateWiseFile in dateWiseFiles)
                      Column(
                        children: [
                          Chip(
                            backgroundColor: Colors.black38,
                            label: Text(dateWiseFile.date),
                          ),
                          Container(
                            child: Responsive(
                              mobile: AllFilesCardGridView(
                                  crossAxisCount: _size.width < 650 ? 2 : 4,
                                  childAspectRatio: _size.width < 650 ? 1 : 1,
                                  newFiles: dateWiseFile.filesData,
                                  scrollController: _scrollController),
                              tablet: AllFilesCardGridView(
                                  newFiles: dateWiseFile.filesData,
                                  scrollController: _scrollController),
                              desktop: AllFilesCardGridView(
                                  childAspectRatio:
                                      _size.width < 1400 ? 1.1 : 1.4,
                                  newFiles: dateWiseFile.filesData,
                                  scrollController: _scrollController),
                            ),
                          ),
                        ],
                      ),
                    if (_isLoading) Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
