import 'package:flutter/material.dart';
import 'package:news_app/screens/search_screen.dart';
import './screens/home_screen.dart';
import './screens/news_detail.dart';
import 'package:provider/provider.dart';
import './models/news_model.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          accentColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme
          )
        ),
        home: AnimatedSplashScreen(
            splash: Text(
              'News App',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            nextScreen: HomePage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white),
        routes: {
          NewsDetail.routeName: (context) => NewsDetail(),
          //SearchScreen.routeName: (context) => SearchScreen()
          },
      ),
    );
  }
}
