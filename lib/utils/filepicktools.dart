import 'dart:io';

import 'package:file_picker/file_picker.dart';

class TargetFoldersPathResult {
  String path;
  bool canceled;
  TargetFoldersPathResult(this.path, this.canceled);
}

class FilePickTools {
  // 获取指定文件夹路径(UI)
  Future<TargetFoldersPathResult> get getTargetLocalFoldersPath async {
    TargetFoldersPathResult filePickResult;
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      filePickResult = TargetFoldersPathResult('', true);
    } else {
      filePickResult = TargetFoldersPathResult(selectedDirectory, false);
    }
    return filePickResult;
  }

  // 获取指定文件夹路径中所有mp3文件的路径列表
  List<String> getTargetFoldersPathFileList(String folderPath) {
    Directory directory = Directory(folderPath);
    List<FileSystemEntity> allFileList = directory.listSync(recursive: true);
    List<String> allFilePathList = [];
    for (var file in allFileList) {
      if (file.statSync().type == FileSystemEntityType.file && file.path.endsWith('.mp3')) {
        allFilePathList.add(file.path);
      }
    }
    return allFilePathList;
  }
}
