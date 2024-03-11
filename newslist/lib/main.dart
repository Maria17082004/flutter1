import 'package:flutter/material.dart';
import 'news.dart';
import 'newsDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: NewsPage(toggleTheme),
    );
  }
}

class NewsPage extends StatefulWidget {
  final Function toggleTheme;

  const NewsPage(this.toggleTheme, {super.key});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  List<News> _newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    NewsApi newsApi = NewsApi();
    List<News> newsList = await newsApi.fetchNews();

    setState(() {
      _newsList = newsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости Apple'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailPage(news: _newsList[index]),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _newsList[index].imageUrl != null
                            ? Image.network(_newsList[index].imageUrl!)
                            : const Icon(Icons.image_not_supported),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(_newsList[index].title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          _newsList[index].description,
                        ),
                      ),
                      Text(_newsList[index].url,
                          style: const TextStyle(color: Color(0xFF5E8CEA))),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFDADADA),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
