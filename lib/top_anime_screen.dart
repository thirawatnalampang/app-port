import 'package:flutter/material.dart';
import 'anime_service.dart';
import 'anime_detail_screen.dart';

class TopAnimeScreen extends StatefulWidget {
  const TopAnimeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopAnimeScreenState createState() => _TopAnimeScreenState();
}

class _TopAnimeScreenState extends State<TopAnimeScreen> {
  List<dynamic> topAnimeList = []; 
  bool isLoading = true; 
  String? errorMessage; 

  @override
  void initState() {
    super.initState();
    fetchTopAnime(); 
  }

  // ดึงข้อมูลอนิเมะยอดนิยม
  Future<void> fetchTopAnime() async {
    try {
      final results = await AnimeService.fetchTopAnime(); 
      setState(() {
        topAnimeList = results; 
        isLoading = false; 
      });
    } catch (e) {
      print('Error fetching top anime: $e');
      setState(() {
        isLoading = false; 
        errorMessage = 'ไม่สามารถดึงข้อมูลอนิเมะยอดนิยมได้'; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('อนิเมะยอดนิยม'), 
        backgroundColor: Colors.orange[800], 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[800]!, const Color.fromARGB(255, 255, 123, 0)], 
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color:  Colors.orange[800])) 
            : errorMessage != null
                ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red))) 
                : buildAnimeList(), 
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างรายการอนิเมะ
  Widget buildAnimeList() {
    return ListView.builder(
      itemCount: topAnimeList.length,
      itemBuilder: (context, index) {
        final anime = topAnimeList[index];
        return Card(
          color: Colors.white, 
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
            side: BorderSide(color: Colors.orange[800]!, width: 2), 
          ),
          child: ListTile(
            title: Text(
              '${index + 1}. ${anime['title']['romaji'] ?? 'ไม่มีชื่อ'}', 
              style: TextStyle(
                color: Colors.orange[800], 
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8), 
              child: Image.network(
                anime['coverImage']['medium'] ?? '',
                width: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailScreen(anime: anime),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
