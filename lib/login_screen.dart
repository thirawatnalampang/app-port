import 'package:flutter/material.dart';
import 'search_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = ''; 
  String _password = ''; 

  // ฟังก์ชันสำหรับเข้าสู่ระบบ
  void _login() {
    print('Login button pressed'); 
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); 
      print('Username: $_username, Password: $_password'); 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เข้าสู่ระบบ'),
        backgroundColor: const Color.fromARGB(255, 255, 165, 0),
         ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(
              height: 300, 
              child: Image.asset('images/aaa.gif'), 
            ),
            const SizedBox(height: 20), 
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)), 
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent), 
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), 
                    ),
                    style: const TextStyle(color: Colors.black), 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาใส่ชื่อผู้ใช้';
                      }
                      return null;
                    },
                    onSaved: (value) => _username = value!, 
                  ),
                  const SizedBox(height: 16), 
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)), 
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent), 
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), 
                    ),
                    style: const TextStyle(color: Colors.black), 
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาใส่รหัสผ่าน';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!, 
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 51, 54, 59), 
                      foregroundColor: Colors.white, 
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), 
                      ),
                    ),
                    child: const Text('เข้าสู่ระบบ'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
