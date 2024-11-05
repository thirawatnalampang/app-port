import 'package:flutter/material.dart';
import 'anime_service.dart';
import 'anime_detail_screen.dart';
import 'developer_screen.dart';
import 'top_anime_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> animeList = [];
  String? selectedCategory;
  String query = '';
  int currentIndex = 0;

  final List<String> categories = [
    'Action',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Romance',
    'Sports'
  ];

  final List<Color> categoryColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.green,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.pink,
    Colors.tealAccent,
  ];

  void searchAnime(String query) async {
    try {
      final results = await AnimeService.searchAnime(query);
      setState(() {
        animeList = results;
      });
    } catch (e) {
      print('Error searching anime: $e');
      setState(() {
        animeList = [];
      });
    }
  }

  void searchByCategory(String category) async {
    try {
      final results = await AnimeService.searchAnimeByCategory(category);
      setState(() {
        animeList = results;
        selectedCategory = category;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AnimeListScreen(category: category, animeList: animeList),
        ),
      );
    } catch (e) {
      print('Error searching by category: $e');
      setState(() {
        animeList = [];
      });
    }
  }

  void clearCategorySelection() {
    setState(() {
      selectedCategory = null;
      animeList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('อนิเมะ'),
        backgroundColor: const Color.fromARGB(255, 255, 119, 0), // สีของ AppBar
        actions: [
          if (selectedCategory != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: clearCategorySelection,
            ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          buildCategoryPage(),
          buildSearchPage(),
          const TopAnimeScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeveloperScreen(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 255, 149, 0),
        child: const Icon(Icons.person),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'หมวดหมู่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'ค้นหา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Top 10',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 153, 0),
        unselectedItemColor: const Color.fromARGB(255, 255, 128, 0), 
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
        onTap: (index) {
          setState(() {
            currentIndex = index;
            clearCategorySelection();
          });
        },
      ),
    );
  }

  Widget buildCategoryPage() {
    return Container(
      color: Colors.white, 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(categories.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: categoryColors[index],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    searchByCategory(categories[index]);
                  },
                  child: Text(
                    categories[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildSearchPage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.orange[800], 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'ค้นหาอนิเมะ',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), 
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              query = value;
              searchAnime(query);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: animeList.isEmpty
                ? Center(
                    child: Text(
                      query.isEmpty ? 'กรุณาใส่คำค้นหา' : 'ไม่พบอนิเมะที่ค้นหา',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: animeList.length,
                    itemBuilder: (context, index) {
                      final anime = animeList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            anime['title']['romaji'] ?? 'ไม่มีชื่อ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              anime['coverImage']['medium'] ?? '',
                              width: 50,
                              height: 75,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AnimeDetailScreen(anime: anime),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class AnimeListScreen extends StatelessWidget {
  final String category;
  final List<dynamic> animeList;

  const AnimeListScreen({super.key, required this.category, required this.animeList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('อนิเมะหมวดหมู่: $category'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        color: Colors.white, 
        child: animeList.isEmpty
            ? const Center(
                child: Text(
                  'ไม่มีอนิเมะในหมวดหมู่ที่เลือก',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        anime['title']['romaji'] ?? 'ไม่มีชื่อ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          anime['coverImage']['medium'] ?? '',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimeDetailScreen(anime: anime),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
