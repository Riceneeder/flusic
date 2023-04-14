import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

//设置界面
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        children: [
          AdwPreferencesGroup(
            title: '音乐库',
            description: '本地音乐库地址',
            children: [
              const AdwActionRow(
                start: Icon(Icons.folder),
                title: '/path/to/music/folder',
              ),
              AdwActionRow(
                title: '更改',
                end: const Icon(Icons.chevron_right),
                onActivated: () => debugPrint('选择本地音乐路径'),
              ),
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
                onActivated: () => debugPrint('登陆网易云音乐账户'),
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
