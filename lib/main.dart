import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/layout/social_layout.dart';
import 'package:share/modules/login/social_login_screen.dart';
import 'package:share/shared/bloc_observer.dart';
import 'package:share/shared/component/component.dart';
import 'package:share/shared/component/constants.dart';
import 'package:share/shared/network/local/cache_helper.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on Message Opened App');
  print(message.data.toString());
  showToast(text: 'on Message Opened App', state: ToastStates.SUCCESS);

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: 'recaptcha-v3-site-key',


        androidProvider: AndroidProvider.debug,
      );
      var token = await FirebaseMessaging.instance.getToken();

      print(token);

      FirebaseMessaging.onMessage.listen((event) {
        print(event.data.toString());
        showToast(text: 'on Message', state: ToastStates.SUCCESS);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.data.toString());
        showToast(text: 'on Message Opened App', state: ToastStates.SUCCESS);

      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      Bloc.observer = MyBlocObserver();
      uId = CacheHelper.getData(key: 'uId');
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
    return MultiBlocProvider(
        providers: [
          BlocProvider (create: (BuildContext context) =>
          SocialCubit()..getUserData()..getPosts())
        ],
        child: BlocConsumer<SocialCubit,SocialStates>(
            builder: (context,states) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: startWidget
              );
            },
            listener: (context,states) {})
    );

  }
}
