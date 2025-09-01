
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // void main() {
// //   runApp(const WorldScreen());
// // }

// class WorldScreen extends StatelessWidget {
//   const WorldScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Noticias',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const NewsScreen(),
//     );
//   }
// }

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   final String apiKey = "66fbbc4d6e6044ecbd78ee7849ace4a7";
//   List articles = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<void> fetchNews() async {
//     final url =
//         "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         articles = data["articles"];
//       });
//     } else {
//       throw Exception("Error al cargar noticias: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Noticias")),
//       body: articles.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: articles.length,
//               itemBuilder: (context, index) {
//                 final article = articles[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     leading: article["urlToImage"] != null
//                         ? Image.network(
//                             article["urlToImage"],
//                             width: 80,
//                             fit: BoxFit.cover,
//                           )
//                         : const Icon(Icons.image_not_supported),
//                     title: Text(article["title"] ?? "Sin título"),
//                     subtitle: Text(article["description"] ?? "Sin descripción"),
//                     onTap: () {
//                       // Aquí podrías abrir la noticia en un WebView
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de noticia
class News {
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;

  News({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'Sin título',
      description: json['description'] ?? 'Sin descripción',
      urlToImage: json['urlToImage'] ??
          'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}

// Pantalla principal
// void main() {
//   runApp(const WorldScreen());
// }

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias Agenda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=66fbbc4d6e6044ecbd78ee7849ace4a7';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List articles = data['articles'];
        setState(() {
          _newsList = articles.map((json) => News.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception("Error al cargar noticias");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Formato de fecha corto
  String formatDate(String date) {
    if (date.isEmpty) return "";
    DateTime dt = DateTime.parse(date);
    return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📰 Noticias"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _newsList.length,
              itemBuilder: (context, index) {
                final news = _newsList[index];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Image.network(
                          news.urlToImage,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              news.description,
                              style: const TextStyle(fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(news.publishedAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.bookmark_border),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Guardado en agenda: ${news.title}"),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
