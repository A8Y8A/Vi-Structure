import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/services/gitit.dart';
import 'package:project2/presentation/controller/authcubit/auth_cubit.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_cubit.dart';
import 'package:project2/presentation/controller/notecubit/note_cubit.dart';
import 'package:project2/presentation/controller/uploadvideocubit/upload_video_cubit.dart';
import 'package:project2/presentation/screens/WelcomePage/WelcomePage.dart';
import 'dart:ui_web' as ui_web;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  // ui_web.bootstrapEngine();
  // setUrlStrategy(PathUrlStrategy());
  // ui_web.setPluginHandler(pluginHandler as PlatformMessageCallback);
  // ui_web.debugEmulateFlutterTesterEnvironment = true;
  // WidgetsFlutterBinding.ensureInitialized();

  ServicesLocator().init();
  runApp(MyApp());
}

void pluginHandler() {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(getit(), getit())),
          BlocProvider(
            create: (context) => UploadCubit(getit()),
          ),
          BlocProvider(
            create: (context) => FileCubit(getit(), getit(), getit()),
          ),
          BlocProvider(
            create: (context) => NoteCubit(getit(), getit(), getit()),
          ),
        ],
        child: MaterialApp(
          title: 'Vi Structure',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WelcomePage(),
        ));
  }
}
