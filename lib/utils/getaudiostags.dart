import 'dart:io';
import 'package:audiotags/audiotags.dart';

import '../models/BaseMusicInfo.dart';
export 'package:audiotags/audiotags.dart';

Future<List<BaseMusicInfo>> getAduiosinfo(List<String> allFilePathList) async {
  List<File> fileList = [];
  List<BaseMusicInfo> aduiosinfo = [];
  for (var path in allFilePathList) {
    File file = File(path);
    fileList.add(file);
  }
  for (var file in fileList) {
    Tag? tag = await AudioTags.read(file.path);
    aduiosinfo.add(BaseMusicInfo(
      name: '${tag?.title} - ${tag?.artist}',
      url: file.path,
    ));
  }
  return aduiosinfo;
}
