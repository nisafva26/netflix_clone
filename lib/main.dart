// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:netflix_app/controller/movie_description_controller.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/controller/view_more_controller.dart';
import 'package:netflix_app/view/home/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

import 'view/home/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    
     MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => MovieListController()),
         ChangeNotifierProvider(create: (context) => MovieDescriptionCOntroller()),
          ChangeNotifierProvider(create: (context) => ViewMoreController())
      ],
    child: GetMaterialApp( 
      debugShowCheckedModeBanner: false,
     home: const MyApp(),
      theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.blue,
            appBarTheme:  const AppBarTheme(backgroundColor: Colors.transparent),
             textTheme:  const TextTheme(
                bodyText1: const TextStyle(color: Colors.white),
                bodyText2: const TextStyle(color: Colors.white),
              )
          ),
      ),
  )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieListController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
           textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            )
        ),
        home: const NetflixBottomNav(),
      ),
    );
  }
}


