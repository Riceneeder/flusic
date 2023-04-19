import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mpd_controller.dart';

class GlobalPlayer extends StatelessWidget {
  GlobalPlayer({Key? key}) : super(key: key);

  final globalPlayerController = Get.put(MpdController());

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      renderBorder: false,
      isSelected: const [false, false, false, false],
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      children: [
        Obx(() => IconButton(
              onPressed: !globalPlayerController.isStop.value
                  ? globalPlayerController.previous
                  : null,
              icon: const Icon(
                Icons.skip_previous,
              ),
              tooltip: '上一首',
            )),
        IconButton(
          onPressed: globalPlayerController.stop,
          icon: const Icon(
            Icons.stop,
          ),
          tooltip: '停止播放',
        ),
        Obx(() {
          if (globalPlayerController.isPlayIng.value) {
            return IconButton(
              onPressed: globalPlayerController.pause,
              icon: const Icon(
                Icons.pause,
              ),
              tooltip: '暂停',
            );
          } else {
            return IconButton(
              onPressed: globalPlayerController.play,
              icon: const Icon(
                Icons.play_arrow,
              ),
              tooltip: '播放',
            );
          }
        }),
        Obx(() => IconButton(
              onPressed: !globalPlayerController.isStop.value
                  ? globalPlayerController.next
                  : null,
              icon: const Icon(
                Icons.skip_next,
              ),
              tooltip: '下一首',
            ))
      ],
    );
  }
}
