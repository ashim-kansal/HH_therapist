import 'dart:async';

import 'package:flutter_app/api/API_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/twilio/conference/conference_button_bar.dart';
import 'package:flutter_app/twilio/conference/conference_room.dart';
import 'package:flutter_app/twilio/conference/participant_widget.dart';
import 'package:flutter_app/twilio/debug.dart';
import 'package:flutter_app/twilio/widget/noise_box.dart';
import 'package:flutter_app/twilio/widget/platform_alert_dialog.dart';
import 'package:wakelock/wakelock.dart';

import 'draggable_publisher.dart';


class VideoCallPage extends StatefulWidget {
  static const String RouteName = '/VideoCallPage';

  String roomName='';
  String token='';
  String identity='';

  VideoCallPage({this.token, this.identity, this.roomName});

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<VideoCallPage> {
  // Timer timer;
  final StreamController<bool> _onButtonBarVisibleStreamController = StreamController<bool>.broadcast();
  final StreamController<double> _onButtonBarHeightStreamController = StreamController<double>.broadcast();
  ConferenceRoom _conferenceRoom;
  StreamSubscription _onConferenceRoomException;


  @override
  void initState() {
    super.initState();
    // widget.roomName = "abc";
    // widget.token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTS2Q2ODNhYzhkNDk1ZDY4MjZhYjZlYWEwMmM4ZTBiNDkyLTE2MDk3ODc5NDUiLCJpc3MiOiJTS2Q2ODNhYzhkNDk1ZDY4MjZhYjZlYWEwMmM4ZTBiNDkyIiwic3ViIjoiQUMxODA1YTNlYzQ0ZGNiZmQyZGEyYjRhYzkzMWEzNjdiMyIsImV4cCI6MTYwOTc5MTU0NSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoidXNlciIsInZpZGVvIjp7InJvb20iOiJhYmMifX19.dOBZ9j6Kffw4G7e46kuanhg0jtCJOciokcIOnXIQY2o";
    // widget.identity = "user";
    _lockInPortrait();
    getTwilioToken(widget.roomName, widget.identity, "", "").then((value) => {
      if(value.responseCode == '200'){
        _connectToRoom(widget.roomName, value.jwt, widget.identity),
        _wakeLock(true)
      }
    });

    // timer = Timer(const Duration(seconds: 30), () {
    //     _onHangup();
    // });
  }

  void _connectToRoom(roomName, _token, identity) async {
    try {
      final conferenceRoom = ConferenceRoom(
        name: roomName,
        token: _token,
        identity: identity,
      );
      await conferenceRoom.connect();
      setState(() {
        _conferenceRoom = conferenceRoom;
        _onConferenceRoomException = _conferenceRoom.onException.listen((err) async {
          await PlatformAlertDialog(
            title: err is PlatformException ? err.message : 'An error occured',
            content: err is PlatformException ? err.details : err.toString(),
            defaultActionText: 'OK',
          ).show(context);
        });
        _conferenceRoom.onParticipantDisconnected.listen((err) {
          print('participant disconnected');
          _onHangup();
        });
        _conferenceRoom.onParticipantConnected.listen((err) {
          print('participant connected');
          // setState(() {
          //   timer !=null ? timer.cancel() : null;
          // });
        });
        _conferenceRoom.addListener(_conferenceRoomUpdated);
      });
    } catch (err) {
      Debug.log(err);
      await PlatformAlertDialog(
        title: err is PlatformException ? err.message : 'An error occured',
        content: err is PlatformException ? err.details : err.toString(),
        defaultActionText: 'OK',
      ).show(context);

      Navigator.of(context).pop();
    }
  }

  Future<void> _lockInPortrait() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _freePortraitLock();
    _wakeLock(false);
    _disposeStreamsAndSubscriptions();
    if (_conferenceRoom != null) _conferenceRoom.removeListener(_conferenceRoomUpdated);
    super.dispose();
  }

  Future<void> _freePortraitLock() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _disposeStreamsAndSubscriptions() async {
    if (_onButtonBarVisibleStreamController != null) await _onButtonBarVisibleStreamController.close();
    if (_onButtonBarHeightStreamController != null) await _onButtonBarHeightStreamController.close();
    if (_onConferenceRoomException != null) await _onConferenceRoomException.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _conferenceRoom == null ? showProgress() : buildLayout(),
      ),
    );
  }

  LayoutBuilder buildLayout() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            _buildParticipants(context, constraints.biggest, _conferenceRoom),
            ConferenceButtonBar(
              audioEnabled: _conferenceRoom.onAudioEnabled,
              videoEnabled: _conferenceRoom.onVideoEnabled,
              flashState: _conferenceRoom.flashStateStream,
              onAudioEnabled: _conferenceRoom.toggleAudioEnabled,
              onVideoEnabled: _conferenceRoom.toggleVideoEnabled,
              onHangup: _onHangup,
              onSwitchCamera: _conferenceRoom.switchCamera,
              toggleFlashlight: _conferenceRoom.toggleFlashlight,
              onHeight: _onHeightBar,
              onShow: _onShowBar,
              onHide: _onHideBar,
            ),
          ],
        );
      },
    );
  }

  Widget showProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text(
          'Connecting to the room...',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Future<void> _onHangup() async {
    Debug.log('onHangup');
    await _conferenceRoom.disconnect();
    Navigator.of(context).pop();
  }

  void _onPersonAdd() {
    Debug.log('onPersonAdd');
    try {
      _conferenceRoom.addDummy(
        child: Stack(
          children: <Widget>[
            const Placeholder(),
            Center(
              child: Text(
                (_conferenceRoom.participants.length + 1).toString(),
                style: const TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                  fontSize: 80,
                ),
              ),
            ),
          ],
        ),
      );
    } on PlatformException catch (err) {
      PlatformAlertDialog(
        title: err.message,
        content: err.details,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  void _onPersonRemove() {
    Debug.log('onPersonRemove');
    _conferenceRoom.removeDummy();
  }

  Widget _buildParticipants(BuildContext context, Size size, ConferenceRoom conferenceRoom) {
    final children = <Widget>[];
    final length = conferenceRoom.participants.length;

    if (length <= 2) {
      _buildOverlayLayout(context, size, children);
      return Stack(children: children);
    }

    void buildInCols(bool removeLocalBeforeChunking, bool moveLastOfEachRowToNextRow, int columns) {
      _buildLayoutInGrid(
        context,
        size,
        children,
        removeLocalBeforeChunking: removeLocalBeforeChunking,
        moveLastOfEachRowToNextRow: moveLastOfEachRowToNextRow,
        columns: columns,
      );
    }

    if (length <= 3) {
      buildInCols(true, false, 1);
    } else if (length == 5) {
      buildInCols(false, true, 2);
    } else if (length <= 6 || length == 8) {
      buildInCols(false, false, 2);
    } else if (length == 7 || length == 9) {
      buildInCols(true, false, 2);
    } else if (length == 10) {
      buildInCols(false, true, 3);
    } else if (length == 13 || length == 16) {
      buildInCols(true, false, 3);
    } else if (length <= 18) {
      buildInCols(false, false, 3);
    }

    return Column(
      children: children,
    );
  }

  void _buildOverlayLayout(BuildContext context, Size size, List<Widget> children) {
    final participants = _conferenceRoom.participants;
    if (participants.length == 1) {
      children.add(_buildNoiseBox());
    } else {
      print(participants.length);
      final localParticipant = participants.firstWhere((ParticipantWidget participant) => !participant.isRemote, orElse: () => null);
      if (localParticipant != null) {
        children.add(DraggablePublisher(
          key: Key('publisher'),
          child: localParticipant,
          availableScreenSize: size,
          onButtonBarVisible: _onButtonBarVisibleStreamController.stream,
          onButtonBarHeight: _onButtonBarHeightStreamController.stream,
        ));
      }

      final remoteParticipant = participants.firstWhere((ParticipantWidget participant) => participant.isRemote, orElse: () => null);
      if (remoteParticipant != null) {
        children.add(remoteParticipant);
      }
    }


  }

  void _buildLayoutInGrid(
      BuildContext context,
      Size size,
      List<Widget> children, {
        bool removeLocalBeforeChunking = false,
        bool moveLastOfEachRowToNextRow = false,
        int columns = 2,
      }) {
    final participants = _conferenceRoom.participants;
    ParticipantWidget localParticipant;
    if (removeLocalBeforeChunking) {
      localParticipant = participants.firstWhere((ParticipantWidget participant) => !participant.isRemote, orElse: () => null);
      if (localParticipant != null) {
        participants.remove(localParticipant);
      }
    }
    final chunkedParticipants = chunk(array: participants, size: columns);
    if (localParticipant != null) {
      chunkedParticipants.last.add(localParticipant);
      participants.add(localParticipant);
    }

    if (moveLastOfEachRowToNextRow) {
      for (var i = 0; i < chunkedParticipants.length - 1; i++) {
        var participant = chunkedParticipants[i].removeLast();
        chunkedParticipants[i + 1].insert(0, participant);
      }
    }

    for (final participantChunk in chunkedParticipants) {
      final rowChildren = <Widget>[];
      for (final participant in participantChunk) {
        rowChildren.add(
          Container(
            width: size.width / participantChunk.length,
            height: size.height / chunkedParticipants.length,
            child: participant,
          ),
        );
      }
      children.add(
        Container(
          height: size.height / chunkedParticipants.length,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowChildren,
          ),
        ),
      );
    }
  }

  NoiseBox _buildNoiseBox() {
    return NoiseBox(
      density: NoiseBoxDensity.xLow,
      backgroundColor: Colors.grey.shade900,
      child: Center(
        child: Container(
          color: Colors.black,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(
              'Calling the Participant...',
              key: Key('text-wait'),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  List<List<T>> chunk<T>({@required List<T> array, @required int size}) {
    final result = <List<T>>[];
    if (array.isEmpty || size <= 0) {
      return result;
    }
    var first = 0;
    var last = size;
    final totalLoop = array.length % size == 0 ? array.length ~/ size : array.length ~/ size + 1;
    for (var i = 0; i < totalLoop; i++) {
      if (last > array.length) {
        result.add(array.sublist(first, array.length));
      } else {
        result.add(array.sublist(first, last));
      }
      first = last;
      last = last + size;
    }
    return result;
  }

  void _onHeightBar(double height) {
    _onButtonBarHeightStreamController.add(height);
  }

  void _onShowBar() {
    setState(() {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    });
    _onButtonBarVisibleStreamController.add(true);
  }

  void _onHideBar() {
    setState(() {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    });
    _onButtonBarVisibleStreamController.add(false);
  }

  Future<void> _wakeLock(bool enable) async {
    try {
      return await (enable ? Wakelock.enable() : Wakelock.disable());
    } catch (err) {
      Debug.log('Unable to change the Wakelock and set it to $enable');
      Debug.log(err);
    }
  }

  void _conferenceRoomUpdated() {
    setState(() {});
  }
}
