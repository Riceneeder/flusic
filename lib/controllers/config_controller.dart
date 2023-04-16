import 'dart:convert';
import 'dart:io';
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
      [BaseMusicInfo(name: 'loading......', url: 'url', dur: 'dur')].obs;
  RxString localMusicFoldersPath = localMusicFoldersPathInConfig.obs;

  @override
  void onInit() async {
    super.onInit();
    await getAduiosinfo(FilePickTools()
            .getTargetFoldersPathFileList(localMusicFoldersPathInConfig))
        .then((value) => musicInfoList.value = value);
  }

  void _refreshAllMusicPage() {
    getAduiosinfo(FilePickTools()
            .getTargetFoldersPathFileList(localMusicFoldersPath.value))
        .then((value) => musicInfoList.value = value);
  }

  void _saveAllConfigToFile(String newConfig) {
    _configFile.writeAsStringSync(newConfig);
  }

  //========setting page start
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
    _refreshAllMusicPage();
  }
  //=========end
}
