// import 'package:home_vault/constants.dart';
import 'package:home_vault/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Documents",
    numOfFiles: 1328,
    // svgSrc: "assets/icons/Documents.svg",
    svgSrc: "assets/icons/document_svg_file.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "PDF's",
    numOfFiles: 1328,
    // svgSrc: "assets/icons/google_drive.svg",
    svgSrc: "assets/icons/pdf_svg_file.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Images",
    numOfFiles: 1328,
    // svgSrc: "assets/icons/one_drive.svg",
    svgSrc: "assets/icons/images_svg_file.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Sheets",
    numOfFiles: 5328,
    // svgSrc: "assets/icons/drop_box.svg",
    svgSrc: "assets/icons/sheets_svg_file.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
