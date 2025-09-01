
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Modelo de noticia
// class News {
//   final String title;
//   final String description;
//   final String urlToImage;
//   final String publishedAt;

//   News({
//     required this.title,
//     required this.description,
//     required this.urlToImage,
//     required this.publishedAt,
//   });

//   factory News.fromJson(Map<String, dynamic> json) {
//     return News(
//       title: json['title'] ?? 'Sin título',
//       description: json['description'] ?? 'Sin descripción',
//       urlToImage: json['urlToImage'] ??
//           'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
//       publishedAt: json['publishedAt'] ?? '',
//     );
//   }
// }

// // Pantalla principal
// // void main() {
// //   runApp(const WorldScreen());
// // }

// class WorldScreen extends StatelessWidget {
//   const WorldScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Noticias Agenda',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const NewsScreen(),
//     );
//   }
// }

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   _NewsScreenState createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<News> _newsList = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<void> fetchNews() async {
//     final url =
//         'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=66fbbc4d6e6044ecbd78ee7849ace4a7';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List articles = data['articles'];
//         setState(() {
//           _newsList = articles.map((json) => News.fromJson(json)).toList();
//           _isLoading = false;
//         });
//       } else {
//         throw Exception("Error al cargar noticias");
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // Formato de fecha corto
//   String formatDate(String date) {
//     if (date.isEmpty) return "";
//     DateTime dt = DateTime.parse(date);
//     return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("📰 Noticias"),
//         centerTitle: true,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: _newsList.length,
//               itemBuilder: (context, index) {
//                 final news = _newsList[index];
//                 return Card(
//                   elevation: 6,
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         child: Image.network(
//                           news.urlToImage,
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               news.title,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               news.description,
//                               style: const TextStyle(fontSize: 14),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   formatDate(news.publishedAt),
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: const Color.fromARGB(255, 163, 75, 75),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.bookmark_border),
//                                   onPressed: () {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(
//                                             "Guardado en agenda: ${news.title}"),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:share_plus/share_plus.dart';


// class WorldScreen extends StatelessWidget {
//   const WorldScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Noticias del Mundo"),
//         backgroundColor: Colors.blue,
//       ),
//       body: NewsPage(), // aquí llamamos a la página con la lista de noticias
//     );
//   }
// }

// // class WorldScreen extends StatelessWidget {
// //   const WorldScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Noticias Agenda',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         useMaterial3: true,
// //       ),
// //       home: const NewsScreen(),
// //     );
// //   }
// // }

// class NewsPage extends StatefulWidget {
//   @override
//   _NewsPageState createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   List<dynamic> news = [];
//   List<dynamic> favorites = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<void> fetchNews() async {
//     final response = await http.get(Uri.parse(
//         'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=66fbbc4d6e6044ecbd78ee7849ace4a7'));

//     if (response.statusCode == 200) {
//       setState(() {
//         news = json.decode(response.body)['articles'];
//       });
//     }
//   }

//   void toggleFavorite(dynamic article) {
//     setState(() {
//       if (favorites.contains(article)) {
//         favorites.remove(article);
//       } else {
//         favorites.add(article);
//       }
//     });
//   }

//   void openDetail(dynamic article) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NewsDetailPage(
//           article: article,
//           onFavorite: () => toggleFavorite(article),
//           isFavorite: favorites.contains(article),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Noticias"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FavoritesPage(
//                     favorites: favorites,
//                     onRemove: toggleFavorite,
//                     onDetail: openDetail,
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: news.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: news.length,
//               itemBuilder: (context, index) {
//                 final article = news[index];
//                 return GestureDetector(
//                   onTap: () => openDetail(article),
//                   child: Card(
//                     margin: EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (article['urlToImage'] != null)
//                           ClipRRect(
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             child: Image.network(article['urlToImage']),
//                           ),
//                         Padding(
//                           padding: EdgeInsets.all(10),
//                           child: Text(
//                             article['title'] ?? '',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class FavoritesPage extends StatelessWidget {
//   final List<dynamic> favorites;
//   final Function(dynamic) onRemove;
//   final Function(dynamic) onDetail;

//   FavoritesPage({required this.favorites, required this.onRemove, required this.onDetail});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Favoritos")),
//       body: favorites.isEmpty
//           ? Center(child: Text("No hay favoritos aún."))
//           : ListView.builder(
//               itemCount: favorites.length,
//               itemBuilder: (context, index) {
//                 final article = favorites[index];
//                 return ListTile(
//                   leading: article['urlToImage'] != null
//                       ? Image.network(article['urlToImage'], width: 50, fit: BoxFit.cover)
//                       : null,
//                   title: Text(article['title'] ?? ''),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => onRemove(article),
//                   ),
//                   onTap: () => onDetail(article),
//                 );
//               },
//             ),
//     );
//   }
// }

// class NewsDetailPage extends StatelessWidget {
//   final dynamic article;
//   final VoidCallback onFavorite;
//   final bool isFavorite;

//   NewsDetailPage({required this.article, required this.onFavorite, required this.isFavorite});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(article['source']['name'] ?? "Detalle")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (article['urlToImage'] != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(article['urlToImage']),
//               ),
//             SizedBox(height: 16),
//             Text(
//               article['title'] ?? '',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             Text(article['content'] ?? "Sin contenido disponible"),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () => Share.share(article['url'] ?? ''),
//                   icon: Icon(Icons.share),
//                   label: Text("Compartir"),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: onFavorite,
//                   icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
//                   label: Text("Guardar"),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Función de comentar aún no implementada.")),
//                     );
//                   },
//                   icon: Icon(Icons.comment),
//                   label: Text("Comentar"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 🔹 QUITÉ el "const"
      appBar: AppBar(
        title: const Text("🌍 Noticias del Mundo"),
        backgroundColor: Colors.blue,
      ),
      body: const NewsPage(), // aquí sí puede ser const ✅
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> news = [];
  List<dynamic> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=66fbbc4d6e6044ecbd78ee7849ace4a7'));

    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body)['articles'];
      });
    }
  }

  void toggleFavorite(dynamic article) {
    setState(() {
      if (favorites.contains(article)) {
        favorites.remove(article);
      } else {
        favorites.add(article);
      }
    });
  }

  void openDetail(dynamic article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          article: article,
          onFavorite: () => toggleFavorite(article),
          isFavorite: favorites.contains(article),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return news.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: fetchNews,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: news.length,
              itemBuilder: (context, index) {
                final article = news[index];
                return GestureDetector(
                  onTap: () => openDetail(article),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article['urlToImage'] != null)
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              article['urlToImage'],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  height: 180,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article['title'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(article['description'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              favorites.contains(article)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () => toggleFavorite(article),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<dynamic> favorites;
  final Function(dynamic) onRemove;
  final Function(dynamic) onDetail;

  const FavoritesPage(
      {super.key,
      required this.favorites,
      required this.onRemove,
      required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("❤️ Favoritos")),
      body: favorites.isEmpty
          ? const Center(child: Text("No tienes favoritos aún"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final article = favorites[index];
                return GestureDetector(
                  onTap: () => onDetail(article),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        if (article['urlToImage'] != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16)),
                            child: Image.network(
                              article['urlToImage'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(article['title'] ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onRemove(article),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final dynamic article;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const NewsDetailPage(
      {super.key,
      required this.article,
      required this.onFavorite,
      required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['source']['name'] ?? "Detalle")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(article['urlToImage']),
              ),
            const SizedBox(height: 16),
            Text(article['title'] ?? '',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(article['content'] ?? "Sin contenido disponible",
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Share.share(article['url'] ?? ''),
                  icon: const Icon(Icons.share),
                  label: const Text("Compartir"),
                ),
                ElevatedButton.icon(
                  onPressed: onFavorite,
                  icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border),
                  label: const Text("Guardar"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Función de comentar aún no implementada.")),
                    );
                  },
                  icon: const Icon(Icons.comment),
                  label: const Text("Comentar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
