import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class BaseMusicListItem extends StatelessWidget {
  const BaseMusicListItem({
    Key? key,
    required this.title,
    required this.duration,
    required this.muiscUrl,
  }) : super(key: key);
  final String title;
  final String duration;
  final String muiscUrl;

  @override
  Widget build(BuildContext context) {
    return AdwActionRow(
      key: Key(title),
      title: title,
      end: AdwButton(
        backgroundColorBuilder: musicListItemButtonBackgroundColorBuilder,
        child: const Icon(Icons.play_arrow),
        onPressed: () => debugPrint('播放$title，音乐链接：$muiscUrl'),
      ),
    );
  }
}

Color? musicListItemButtonBackgroundColorBuilder(
  BuildContext context,
  Color? backgroundColor,
  AdwButtonStatus status, {
  bool opaque = false,
}) {
  if (status == AdwButtonStatus.enabledHovered) {
    return context.hoverColor;
  }
  return backgroundColor;
}
