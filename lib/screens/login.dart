import 'package:first_proj/main.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      

      extendBodyBehindAppBar: true,

      // App bar with Later button on top right
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Later button positioned at top right
          TextButton(
            onPressed: () => {Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainAppScreen()),
                  )},
            child: const Text(
              "Later",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      
      body: Container(
        // Add padding around all content
        padding: const EdgeInsets.all(20.0),

        //Background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets\\img\\Login_BG.png"),
            fit: BoxFit.cover, // This makes the image cover the entire container
          ),
        ),

        width: double.infinity,
        
        // Main content column
        child: Column(
          children: [
            // Spacer to push content down           
            const Spacer(flex: 2),


            // Motivational text
            const Text(
              "Help your path to health goals with happiness",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Space between buttons
            
            // Login button with rounded borders and background
            FilledButton(
              onPressed: () => print("Login pressed"),
              style: FilledButton.styleFrom(
                minimumSize: const Size(350, 50), // Button size
                backgroundColor: Color(0xFF042628), // Button background color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded borders
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Create new account button
            TextButton(
              onPressed: () => print("Create account pressed"),
              child: const Text(
                "Create New Account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Bottom spacer
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
