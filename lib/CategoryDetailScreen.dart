import 'package:flutter/material.dart';
import '../anime_service.dart'; 
import 'anime_detail_screen.dart'; 

class CategoryDetailScreen extends StatelessWidget {
  final String category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('หมวดหมู่: $category')),
      body: FutureBuilder<List<dynamic>>(
        future: AnimeService.searchAnimeByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ไม่มีอนิเมะในหมวดหมู่นี้'));
          }

          final animeList = snapshot.data!;

          return ListView.builder(
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              final anime = animeList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(anime['title']['romaji'] ?? 'ไม่มีชื่อ'),
                  leading: Image.network(
                    anime['coverImage']['medium'] ?? '',
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                  onTap: () {
                    // Navigate to AnimeDetailScreen
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
        },
      ),
    );
  }
}
