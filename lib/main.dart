import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/providers/product_provider.dart';
import 'package:first_proj/providers/selectedindexprovider.dart';
import 'package:first_proj/screens/home.dart';
import 'package:first_proj/screens/login.dart';
import 'package:first_proj/screens/profile.dart';
import 'package:first_proj/screens/search.dart';
import 'package:first_proj/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedIndexProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SofiaPro',
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.secondary,
          primary: AppColors.primary,
        ),
      ),
      home: Login(),
    );
  }
}

// Main app screen with bottom navigation
class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFFFFFFF),
      extendBodyBehindAppBar: true,
      body: SafeArea(bottom: false, child: HomeScreen()),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
        return Profile(username: "Alena Sabyam");
      default:
        return Home(username: "Alena Sabyam");
    }
  }
}
