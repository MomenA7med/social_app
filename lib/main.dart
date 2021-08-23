import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/login/login_screen.dart';
import 'package:social_app/shared/m_storage.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'layout/social_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  mStorage.initialize().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken()
    .then((value) => print('fireMessage : ' + value)).
    onError((error, stackTrace) => print('fireError : ' + error.toString()));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
           create: (context) => AppCubit()..getUserData()..getAllPosts()..getAllUserData(),
        ),
      ],
      child: MaterialApp(
        title: 'Social App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            titleSpacing: 20.0,
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            subtitle1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.3,
            ),
          ),
        ),
        home: mStorage.getToken('token') == null ? LoginScreen() : SocialLayout(),
      ),
    );
  }
}