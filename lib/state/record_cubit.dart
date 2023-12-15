import 'dart:io';

import 'package:aplikasi_stress_detection/constants/data_schema.dart';
import 'package:aplikasi_stress_detection/constants/file_schema.dart';
import 'package:aplikasi_stress_detection/constants/recorder.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart';
import 'package:aplikasi_stress_detection/service/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import '../../../../constants/paths.dart';
import 'package:record/record.dart';
part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial());

  Record _audioRecorder = Record();

  void startRecording() async {
    Map<Permission, PermissionStatus> permissions =
        await [Permission.microphone, Permission.storage].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;
    bool result = await Record().hasPermission();

    if (result) {
      Directory appFolder = Directory(Paths.recording);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
      }

      final filepath = Paths.recording +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          RecorderConstants.fileExtention;

      await _audioRecorder.start(
        path: filepath,
        encoder: AudioEncoder.wav,
        bitRate: 512000, // by default
        samplingRate: 44100, // by default
      );

      emit(RecordOn());
    } else {
      print('Permissions not granted');
    }
  }

  Future<DataSound?> stopRecording(User? user) async {
    String? path = await _audioRecorder.stop();
    final file = File('$path');
    emit(RecordStopped());

    SoundResponse? soundUrl = await ApiService().uploadFile(file);
    DataSound? createdData =
        await ApiService().createData(user?.id, soundUrl?.data, "izza");
    return createdData;
  }

  Future<Amplitude> getAmplitude() async {
    final amplitude = await _audioRecorder.getAmplitude();
    return amplitude;
  }

  Stream<double> aplitudeStream() async* {
    while (true) {
      await Future.delayed(Duration(
          milliseconds: RecorderConstants.amplitudeCaptureRateInMilliSeconds));
      final ap = await _audioRecorder.getAmplitude();
      yield ap.current;
    }
  }
}
