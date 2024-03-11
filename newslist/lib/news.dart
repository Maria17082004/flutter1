import 'package:dio/dio.dart';

class News {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;
  final String? author;
  final String content;

  News({required this.title, required this.description, required this.url, required this.imageUrl, required this.author, required this.content});
}

class NewsApi {
  final Dio _dio = Dio();

  Future<List<News>> fetchNews() async {
    final response = await _dio.get('https://newsapi.org/v2/everything?q=Apple&from=2024-03-05&sortBy=popularity&apiKey=0e216042627b4fd4a938f4f316abe8a9');

    List<News> newsList = [];

    if (response.statusCode == 200) {
      for (var article in response.data['articles']) {
        String? imageUrl = article['urlToImage'];
        String? author = article['author'];// Make imageUrl nullable
        newsList.add(News(title: article['title'], description: article['description'], url: article['url'], imageUrl: imageUrl, author: author, content: article['content']));
      }
    } else {
      throw Exception('Failed to load news');
    }

    return newsList;
  }
}