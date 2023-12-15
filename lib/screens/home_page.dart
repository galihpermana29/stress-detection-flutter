import 'package:aplikasi_stress_detection/constants/data_schema.dart';
import 'package:aplikasi_stress_detection/constants/recorder.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart';
import 'package:aplikasi_stress_detection/state/record_cubit.dart';
import 'package:aplikasi_stress_detection/widget/audio_visualizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';

class RecordScreen extends StatefulWidget {
  final User? user;

  RecordScreen({super.key, this.user});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    final User? _user = widget.user;
    return Scaffold(body: BlocBuilder<RecordCubit, RecordState>(
      builder: (context, state) {
        if (state is RecordStopped || state is RecordInitial) {
          return SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ButtonRecord(),
            ],
          ));
        } else if (state is RecordOn) {
          return SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Spacer(),
              Row(
                children: [
                  // Icon(Icons.prgore),
                  const Spacer(),
                  StreamBuilder<double>(
                      initialData: RecorderConstants.decibleLimit,
                      stream: context.read<RecordCubit>().aplitudeStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return AudioVisualizer(amplitude: snapshot.data);
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Visualizer failed to load',
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show(status: "Analyzing..");
                  DataSound? _result =
                      await context.read<RecordCubit>().stopRecording(_user);
                  String label = _result!.label;
                  if (!context.mounted) return;

                  showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 350,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 40,
                                    color: Color.fromARGB(255, 173, 20, 87),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: const Text(
                                            'Hasil Analisa Suara',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            label,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ]),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                                width: 300, // <-- match_parent
                                child: ElevatedButton(
                                  child: const Text('TUTUP'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  EasyLoading.dismiss();
                },
                child: const SizedBox(
                  child: const Icon(
                    Icons.stop,
                    size: 50,
                  ),
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ));
        } else {
          return Center(
              child: Text(
            'An Error occured',
          ));
        }
      },
    ));
  }

  Text myNotes() {
    return Text(
      'MY NOTES',
      style: TextStyle(fontSize: 20, letterSpacing: 5, shadows: [
        Shadow(
            offset: Offset(3, 3),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2)),
      ]),
    );
  }

  Widget ButtonRecord() {
    return SafeArea(
        child: Center(
      child: Stack(children: <Widget>[
        Container(
          width: 900,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: IconButton(
                  icon: Icon(size: 40, Icons.mic_rounded),
                  color: Colors.pink[800],
                  onPressed: () {
                    context.read<RecordCubit>().startRecording();
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
    );
  }
}
