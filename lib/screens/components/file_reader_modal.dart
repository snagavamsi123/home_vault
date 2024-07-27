import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Define a new function to show the file preview dialog
void showFilePreviewDialog(
    BuildContext context, String? title, String? fileUrl) {
  String formattedUrl = fileUrl ?? ''; // Ensure fileUrl is not null
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  double imageWidth = screenWidth * 0.80;
  double imageHeight = screenHeight * 0.60;

  print('fileUrlfileUrlfileUrl87654 $fileUrl');
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? 'Unknown'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (fileUrl != null &&
                (fileUrl.endsWith('.jpg') ||
                    fileUrl.endsWith('.jpeg') ||
                    fileUrl.endsWith('.png')))
              // Image.network(formattedUrl),
              SizedBox(
                height: imageHeight, // Set the desired height
                width: imageWidth, // Set the desired width
                child: Image.network(
                  formattedUrl,
                  fit: BoxFit.cover, // Optionally, you can set the fit property
                ),
              ),
            if (fileUrl != null && fileUrl.endsWith('.pdf'))
              Container(
                width: double.maxFinite,
                height: 400,
                child: SfPdfViewer.network(formattedUrl),
              ),
            if (fileUrl != null &&
                !(fileUrl.endsWith('.jpg') ||
                    fileUrl.endsWith('.jpeg') ||
                    fileUrl.endsWith('.png') ||
                    fileUrl.endsWith('.pdf')))
              Text("Preview not available for this file type."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}
