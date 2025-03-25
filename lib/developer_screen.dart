import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เกี่ยวกับนักพัฒนา'),
        backgroundColor: Colors.orange[800], 
      ),
      body: Container(
        color: Colors.orange[800], 
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80, 
                backgroundImage: AssetImage('images/profile.jpg'), 
                backgroundColor: Colors.white, 
              ),
              const SizedBox(height: 20),
              const Text(
                'นักพัฒนา: นายรณกร วัดสว่าง เเละ นายถิรวัฒน์ ณ ลำปาง',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.white), 
                  SizedBox(width: 5), 
                  Text(
                    'ติดต่อ:ronnakron.w@ku.th เเละ thirawat.na@ku.th',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'รหัสนิสิต: 6521602080 เเละ 6521600460 เ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), 
                  ),
                ),
                child: const Text('กลับ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
