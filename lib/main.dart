import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Search',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 105, 0), 
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255), 
        textTheme: const TextTheme(
          displayMedium: TextStyle(color: Colors.white), 
          displaySmall: TextStyle(color: Colors.white), 
          titleMedium: TextStyle(color: Colors.white, fontSize: 20), 
        ),
      ),
      home: WelcomeScreen(), 
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 165, 0), 
              Color.fromARGB(255, 255, 105, 0), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120, 
                child: Image.asset(
                  'assets/images/logo.jpg', 
                  fit: BoxFit.contain, 
                ),
              ),
              const SizedBox(height: 30), 
              const Text(
                'ยินดีต้อนรับสู่แอพอนิเมะ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromARGB(255, 38, 39, 43), 
                  foregroundColor: Colors.white, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), 
                  ),
                ),
                child: const Text('เข้าสู่ระบบ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
