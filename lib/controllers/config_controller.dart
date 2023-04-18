import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configs/global_configs.dart';

import '../models/BaseMusicInfo.dart';
import '../utils/filepicktools.dart';
import '../utils/getaudiostags.dart';

final _configFile = File('asset/config.json');
final localMusicFoldersPathInConfig =
    GlobalConfigs().get<String>('localMusicFoldersPath') as String;

class ConfigController extends GetxController {
  RxList<BaseMusicInfo> musicInfoList =
      [BaseMusicInfo(name: 'loading......', url: 'url')].obs;
  RxString localMusicFoldersPath = localMusicFoldersPathInConfig.obs;
  RxString mpdPath = '获取默认地址中<MPD后端地址:port>'.obs;

  @override
  void onInit() {
    super.onInit();
    getAduiosinfo(FilePickTools()
            .getTargetFoldersPathFileList(localMusicFoldersPathInConfig))
        .then((value) => musicInfoList.value = value);
  }

  ///刷新本地音乐库界面
  ///在更新音乐路径或者添加新音乐后使用
  void refreshAllMusicPage() {
    getAduiosinfo(FilePickTools()
            .getTargetFoldersPathFileList(localMusicFoldersPath.value))
        .then((value) => musicInfoList.value = value);
  }

  void _saveAllConfigToFile(String newConfig) {
    _configFile.writeAsStringSync(newConfig);
  }

  //========setting page start
  //(about local music folder path)
  void changeAndSaveLocalMusicFoldersPath() {
    FilePickTools().getTargetLocalFoldersPath.then((value) {
      if (!value.canceled) {
        localMusicFoldersPath.value = value.path;
        // 储存到本地配置文件中
        localMusicFoldersPathToConfigFile = value.path;
      }
    });
  }

  set localMusicFoldersPathToConfigFile(String localMusicFoldersPath) {
    GlobalConfigs().set('localMusicFoldersPath', localMusicFoldersPath);
    _saveAllConfigToFile(jsonEncode(GlobalConfigs().configs));
    this.localMusicFoldersPath.value = localMusicFoldersPath;
    refreshAllMusicPage();
  }

  //(about mpd path)
  void changeAndSaveMpdPath(String newMpdPath) {
    debugPrint('changeAndSaveMpdPath($newMpdPath)');
    mpdPath.value = newMpdPath;
  }
  //=========setting page end
}
