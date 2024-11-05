import 'package:flutter/material.dart';
import '../anime_service.dart';
import 'package:html/parser.dart' as html;

class AnimeDetailScreen extends StatefulWidget {
  final dynamic anime;

  const AnimeDetailScreen({required this.anime});

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  List<dynamic> characters = [];
  dynamic animeDetails;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      animeDetails = await AnimeService.fetchAnimeDetails(widget.anime['id']);
      final characterData = await AnimeService.fetchAnimeCharacters(widget.anime['id']);
      setState(() {
        characters = characterData;
      });
    } catch (error) {
      print("Error fetching details: $error");
    }
  }

  String cleanHtml(String htmlString) {
    final document = html.parse(htmlString);
    return document.body?.text ?? 'ไม่มีคำบรรยาย';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.anime['title']['romaji'] ?? 'ชื่อไม่ระบุ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แสดงรูปภาพอนิเมะ
              widget.anime['coverImage'] != null && widget.anime['coverImage']['large'] != null
                  ? Column(
                      children: [
                        Image.network(
                          widget.anime['coverImage']['large'] ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Text('ไม่สามารถโหลดรูปภาพอนิเมะได้'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : Container(),
              const Text('คำบรรยาย:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(cleanHtml(widget.anime['description'] ?? 'ไม่มีคำบรรยาย')),
              const SizedBox(height: 16),
              const Text('ตัวละคร:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              characters.isEmpty
                  ? const Text('ไม่มีตัวละครที่มีให้')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        final character = characters[index]['node'];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(character['name']['full'] ?? 'ชื่อไม่ระบุ'),
                            leading: character['image'] != null
                                ? ClipOval(
                                    child: Image.network(character['image']['medium'] ?? '',
                                        errorBuilder: (context, error, stackTrace) => const Text('ไม่สามารถโหลดรูปภาพตัวละครได้')),
                                  )
                                : Container(),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 16),
              const Text('Relations:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              animeDetails != null && animeDetails['relations'] != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: animeDetails['relations']['edges'].length,
                      itemBuilder: (context, index) {
                        final relation = animeDetails['relations']['edges'][index]['node'];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(relation['title']['romaji'] ?? 'ชื่อไม่ระบุ'),
                            leading: relation['coverImage'] != null
                                ? ClipOval(
                                    child: Image.network(relation['coverImage']['medium'] ?? '',
                                        errorBuilder: (context, error, stackTrace) => const Text('ไม่สามารถโหลดรูปภาพอนิเมะได้')),
                                  )
                                : Container(),
                          ),
                        );
                      },
                    )
                  : const Text('ไม่มี Relations'),
              const SizedBox(height: 16),
             const Text('สามารถดูการ์ตูนได้ที่: ', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const SelectableText(
                'https://www.anime-sugoi.com/',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}