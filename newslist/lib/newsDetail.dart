import 'package:flutter/material.dart';
import 'news.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(news.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: news.imageUrl != null
                      ? Image.network(news.imageUrl!)
                      : const Icon(Icons.image_not_supported),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    news.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      news.description,
                      style: const TextStyle(fontSize: 16),
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      news.content,
                      style: const TextStyle(fontSize: 16),
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(news.author != null ? 'By: ${news.author!}' : "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Text(
                  news.url,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF5E8CEA)),
                ),
              ],
            ),
          ),
        ));
  }
}
