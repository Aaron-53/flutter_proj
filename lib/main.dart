import 'package:first_proj/provider/selectedindexprovider.dart';
import 'package:first_proj/screens/home.dart';
import 'package:first_proj/screens/profile.dart';
import 'package:first_proj/screens/search.dart';
import 'package:first_proj/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectedIndexProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SofiaPro'),
      home: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFFFFFFFF),
        extendBodyBehindAppBar: true,
        body: SafeArea(bottom: false, child: HomeScreen()),
        bottomNavigationBar: CustomBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () {},
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
            0.5,
          ),
          backgroundColor: Color(0xFF042628),
          child: IconButton(
            icon: Image.asset(
              "assets/icons/Hover_button.png",
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<SelectedIndexProvider>().selectedIndex;

    // Use selectedIndex to determine which screen to show
    switch (selectedIndex) {
      case 0:
        return Home(username: "Alena Sabyam");
       case 1:
         return Search();
      // case 2:
      //   return NotificationScreen();
       case 3:
         return Profile();
      default:
        return Home(username: "John Doe");
    }
  }
}
