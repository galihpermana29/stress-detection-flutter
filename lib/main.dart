import 'package:aplikasi_stress_detection/loginpage.dart';
import 'package:aplikasi_stress_detection/state/record_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RecordCubit>(
            create: (context) => RecordCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.pink[800])),
          home: LoginForm(),
          builder: EasyLoading.init(),
        ));
  }
}
