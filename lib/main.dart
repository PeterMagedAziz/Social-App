import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/social_layout.dart';
import 'package:share/modules/login/social_login_screen.dart';
import 'package:share/shared/bloc_observer.dart';
import 'package:share/shared/network/local/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      Bloc.observer = MyBlocObserver();
      var uId = CacheHelper.getData(key: 'uId');
      Widget widget;
      if (uId != null) {
        widget = const SocialLayout();
      } else {
        widget = const SocialLoginScreen();
      }

      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({
    Key? key,
    this.startWidget,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: startWidget
    );
  }
}
