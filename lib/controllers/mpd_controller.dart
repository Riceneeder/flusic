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
  RxList<MpdSong> currentPlayList = <MpdSong>[].obs;
  Rx<MpdSong> currentSong = const MpdSong(file: '').obs;
  Rx<int> currentSongIndex = 0.obs;
  Rx<double> currentSongDuration = 0.0.obs;
  Rx<double> currentSongCurrentTime = 0.0.obs;

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
      onConnect: () => isConnected.value = true,
      onDone: () => isConnected.value = false,
    );
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
  void addLoacalSongToList(String uri) => _mpdClient
      .addid('"$uri"')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());
  //TODO 添加网络歌曲，添加时需要手动打tag,所以参数除了uri外还需要name和artist
  void addRemoteSongToList(String uri) => _mpdClient
      .addid('"$uri"')
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());
  void deleteFromList(int songId) => _mpdClient
      .deleteid(songId)
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
  void stop() => _mpdClient.stop().then((value) {
        _getMpdStatusNow();
        currentSongCurrentTime.value = 0.0;
        currentSongDuration.value = 0.0;
      }).onError((error, stackTrace) {
        GetSnackBar(
          title: 'Error',
          message: error.toString(),
        ).show();
      });
  void seek(String position) => _mpdClient
      .seekcur(position)
      .then((value) => _getMpdStatusNow())
      .onError((error, stackTrace) => GetSnackBar(
            title: 'Error',
            message: error.toString(),
          ).show());

  void _getMpdStatusNow() {
    _mpdClient.status().then((value) {
      mpdStatus = value.obs;
      isPlayIng.value = mpdStatus.value.state == MpdState.play;
      isStop.value = mpdStatus.value.state == MpdState.stop;
      if (mpdStatus.value.duration is double) {
        currentSongDuration.value = mpdStatus.value.duration as double;
      }
      if (mpdStatus.value.elapsed is double) {
        currentSongCurrentTime.value = mpdStatus.value.elapsed as double;
      }
      if (mpdStatus.value.songid is int) {
        currentSongIndex.value = mpdStatus.value.songid as int;
      }
    });
    _mpdClient.currentsong().then((value) => currentSong.value = value);
    _mpdClient.playlistinfo().then((value) => currentPlayList.value = value);
  }
}
