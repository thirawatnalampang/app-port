import 'package:http/http.dart' as http;
import 'dart:convert';

class AnimeService {
  static Future<List<dynamic>> searchAnime(String query) async {
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'query': '''
          query (\$query: String) {
            Page(page: 1, perPage: 10) {
              media(search: \$query, type: ANIME) {
                id
                title {
                  romaji
                }
                description
                coverImage {
                  medium
                  large
                }
              }
            }
          }
        ''',
        'variables': {'query': query},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['Page']['media'] ?? [];
    } else {
      throw Exception('Failed to search anime');
    }
  }

  static Future<List<dynamic>> searchAnimeByCategory(String category) async {
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'query': '''
          query (\$category: String) {
            Page(page: 1, perPage: 10) {
              media(genre_in: [\$category], type: ANIME) {
                id
                title {
                  romaji
                }
                description
                coverImage {
                  medium
                  large
                }
              }
            }
          }
        ''',
        'variables': {'category': category},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['Page']['media'] ?? [];
    } else {
      throw Exception('Failed to fetch anime by category');
    }
  }

  static Future<List<dynamic>> fetchAnimeCharacters(int animeId) async {
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'query': '''
          query (\$id: Int) {
            Media(id: \$id) {
              characters {
                edges {
                  node {
                    name {
                      full
                    }
                    image {
                      medium
                    }
                  }
                }
              }
            }
          }
        ''',
        'variables': {'id': animeId},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['Media']['characters']['edges'] ?? [];
    } else {
      throw Exception('Failed to fetch anime characters');
    }
  }

  static Future<dynamic> fetchAnimeDetails(int animeId) async {
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'query': '''
          query (\$id: Int) {
            Media(id: \$id) {
              relations {
                edges {
                  node {
                    title {
                      romaji
                    }
                    coverImage {
                      medium
                    }
                  }
                }
              }
              trailer {
                site
              }
            }
          }
        ''',
        'variables': {'id': animeId},
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['Media'] ?? null;
    } else {
      throw Exception('Failed to fetch anime details');
    }
  }

  static Future<List<dynamic>> fetchTopAnime() async {
    final response = await http.post(
      Uri.parse('https://graphql.anilist.co'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'query': '''
          query {
            Page(page: 1, perPage: 10) {
              media(sort: [SCORE_DESC], type: ANIME) {
                id
                title {
                  romaji
                }
                description
                coverImage {
                  medium
                  large
                }
              }
            }
          }
        ''',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['Page']['media'] ?? [];
    } else {
      throw Exception('Failed to fetch top anime');
    }
  }
}
