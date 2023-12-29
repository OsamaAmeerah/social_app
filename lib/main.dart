import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/social_layout.dart';
import 'package:socialapp2/shared/bloc_observer/bloc_observer.dart';
import 'package:socialapp2/shared/cubit/appcubit.dart';
import 'package:socialapp2/shared/cubit/appstates.dart';
import 'package:socialapp2/shared/network/local/cahce_helper.dart';
import 'package:socialapp2/styles/theme/themes.dart';
import 'components/deafult_components.dart';
import 'modules/login_screen/login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print('on Background message');
  showToast(text:'on Background message',
      state: ToastStates.SUCCESS);

  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token.toString());
// foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });
  // on click fcm
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on Message Opened App');
    showToast(text:'on Message Opened App', state: ToastStates.SUCCESS);

    print(event.data.toString());
  });
// background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
   uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  // ignore: unnecessary_null_comparison
  if(uId != null)
    {
      widget = SocialLayout();
    }
  else{
    widget = LoginScreen();
  }

  runApp( MyApp(
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            home : startWidget,
          );
        },
      ),
    );
  }
}
