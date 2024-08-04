String _getIcon(String fileType, String file_url) {
  switch (fileType.toLowerCase()) {
    case 'jpg':
    case 'jpeg':
    case 'png':
      return "https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app$file_url";
    // "assets/icons/media_file.svg";
    case 'pdf':
      return "assets/icons/pdf_file.svg";
    case 'doc':
    case 'docx':
      return "assets/icons/doc_file.svg";
    default:
      return "assets/icons/unknown_file.svg"; // Default icon for unknown file types
  }
}

class Files {
  final String fileType;
  final String fileName;
  final String fileImage;
  final String fileUrl;
  final bool isFolder;

  Files({
    required this.fileType,
    required this.fileName,
    required this.fileImage,
    required this.fileUrl,
    required this.isFolder,
  });
  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      fileType: json['file_type'],
      fileName: json['filename'],
      fileImage: _getIcon(
        json['file_type'],
        json['file_url'],
      ),
      fileUrl:
          "https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app${json['file_url']}",
      //
      //  String formattedUrl = "https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app${fileInfo.file_url}";
      isFolder: false,
    );
  }
}

// class DateWiseFiles {
//   final String date;
//   final List<Files> filesData;

//   DateWiseFiles({required this.date, required this.filesData});

//   static List<DateWiseFiles> fromJsonList(List<dynamic> jsonList) {
//     Map<String, List<Files>> dateFilesMap = {};

//     for (var item in jsonList) {
//       Files file = Files.fromJson(item);
//       String date = item['created_at'].split(' ')[0];

//       if (dateFilesMap.containsKey(date)) {
//         dateFilesMap[date]!.add(file);
//       } else {
//         dateFilesMap[date] = [file];
//       }
//     }

//     List<DateWiseFiles> dateWiseFilesList = [];
//     dateFilesMap.forEach((date, files) {
//       dateWiseFilesList.add(DateWiseFiles(date: date, filesData: files));
//     });

//     return dateWiseFilesList;
//   }
// }

class DateWiseFiles {
  final String date;
  final List<Files> filesData;

  DateWiseFiles({
    required this.date,
    required this.filesData,
  });

  // Static method to create a list of DateWiseFiles from a list of Maps
  static List<DateWiseFiles> fromJsonList(List<dynamic> jsonList) {
    Map<String, List<Files>> dateFilesMap = {};

    for (var item in jsonList) {
      Files file = Files.fromJson(item);
      String date = item['created_at'].split(' ')[0];

      if (dateFilesMap.containsKey(date)) {
        dateFilesMap[date]!.add(file);
      } else {
        dateFilesMap[date] = [file];
      }
    }

    List<DateWiseFiles> dateWiseFilesList = [];
    dateFilesMap.forEach((date, files) {
      dateWiseFilesList.add(DateWiseFiles(date: date, filesData: files));
    });

    return dateWiseFilesList;
  }
}
