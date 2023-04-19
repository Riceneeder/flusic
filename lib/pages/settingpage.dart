import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:get/get.dart';

import '../controllers/config_controller.dart';
import '../controllers/mpd_controller.dart';

//设置界面
class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final settingController = Get.put(ConfigController());
  final mpdController = Get.put(MpdController());

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        children: [
          AdwPreferencesGroup(
            title: '音乐库',
            description: '本地音乐库地址',
            children: [
              Obx(() => AdwActionRow(
                    start: const Icon(Icons.folder),
                    title: settingController.localMusicFoldersPath.value,
                  )),
              AdwActionRow(
                title: '更改',
                end: const Icon(Icons.chevron_right),
                onActivated: () =>
                    settingController.changeAndSaveLocalMusicFoldersPath(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AdwPreferencesGroup(
            title: 'MPD',
            description: 'MPD后端地址',
            borderRadius: 7,
            children: [
              Obx(() => AdwTextField(
                    initialValue: mpdController.mpdHostPort.value,
                    //TODO 更改mpd后端地址
                    onSubmitted: settingController.changeAndSaveMpdPath,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          AdwPreferencesGroup(
            title: '互联网账户',
            description: '登陆互联网账户，获取云端数据',
            children: [
              AdwActionRow(
                title: '登陆网易云音乐账户',
                end: const Icon(Icons.chevron_right),
                //TODO
                onActivated: () => debugPrint('登陆网易云音乐账户'),
                enabled: false,
              ),
              const AdwActionRow(
                title: '登陆apple music',
                end: Icon(Icons.chevron_right),
                enabled: false,
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
