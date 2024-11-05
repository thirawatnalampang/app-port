import 'package:flutter/material.dart';
import 'CategoryDetailScreen.dart'; 
import 'top_anime_screen.dart'; 

class CategoryScreen extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryScreen({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Action',
      'Comedy',
      'Drama',
      'Fantasy',
      'Horror',
      'Romance',
      'Sci-Fi',
      'Mystery',
      'Slice of Life',
      'Thriller'
    ];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16), 
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TopAnimeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, 
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), 
              ),
              elevation: 8, 
            ),
            child: const Text(
              'ดูอนิเมะยอดนิยม Top 10',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
        ),

      
        SizedBox(
          height: 60, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailScreen(category: categories[index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), 
                  decoration: BoxDecoration(
                    gradient: const LinearGradient( 
                      colors: [
                        Colors.redAccent,
                        Colors.deepOrange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16, 
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow( 
                            offset: const Offset(2, 2),
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
