import 'dart:async';

import 'package:get/get.dart';
import 'package:dart_mpd/dart_mpd.dart';

class MpdController extends GetxController {
  late Timer _timer;

  Rx<bool> isConnected = Rx<bool>(false);
  Rx<bool> connectError = Rx<bool>(false);
  Rx<bool> isPlayIng = Rx<bool>(false);
  Rx<bool> isStop = Rx<bool>(true);
  RxString mpdHostPort = RxString('initialing......');

  late MpdClient _mpdClient;
  Rx<MpdStatus> mpdStatus = const MpdStatus().obs;

  @override
  void onInit() {
    super.onInit();
    _mpdClient = MpdClient(
      connectionDetails: MpdConnectionDetails.resolve(),
      onError: (p0, p1) {
        connectError.value = !connectError.value;
        mpdHostPort.value =
            'connect failed, check your mpd or put right host dan port';
        const GetSnackBar(
          title: 'Error',
          message: 'connect failed, check your mpd or put right host dan port',
        ).show();
      },
    );
    isConnected.value = _mpdClient.connection.isConnected;
    mpdHostPort.value =
        '${MpdConnectionDetails.resolve().host}:${MpdConnectionDetails.resolve().port}';
    _getMpdStatusNow();
  }

  @override
  void onReady() {
    super.onReady();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _getMpdStatusNow();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void playThisSong(int songId) => _mpdClient
      .playid(songId)
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void pause() => _mpdClient.connection
      .send('pause')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void play() => _mpdClient.connection
      .send('play')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void addLoacalSongToList(String uri) => _mpdClient.connection
      .send('addid "$uri"')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  //TODO 添加网络歌曲，添加时需要手动打tag,所以参数除了uri外还需要name和artist
  void addRemoteSongToList(String uri) => _mpdClient.connection
      .send('addid "$uri"')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void next() => _mpdClient
      .next()
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());
  void previous() => _mpdClient
      .previous()
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());
  void stop() => _mpdClient
      .stop()
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void _getMpdStatusNow() {
    _mpdClient.status().then((value) => mpdStatus = value.obs);
    isPlayIng.value = mpdStatus.value.state == MpdState.play;
    isStop.value = mpdStatus.value.state == MpdState.stop;
  }
}
