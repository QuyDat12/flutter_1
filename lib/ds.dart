import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const String _API_KEY = 'c231dfd22092482d8fe1e9c9f6bf51f9';
const String _BASE_URL = 'https://newsapi.org/v2/everything';

class Article {
  final String title;
  final String shortDescription;
  final String fullContent;
  final String thumbnailUrl;
  final String originalUrl;

  Article({
    required this.title,
    required this.shortDescription,
    required this.fullContent,
    required this.thumbnailUrl,
    required this.originalUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final String content =
        json['content'] ??
        'Nội dung chi tiết đang được cập nhật. Vui lòng xem bài viết gốc.';
    final String imageUrl =
        json['urlToImage'] ??
        'https://placehold.co/600x400/CCCCCC/000000?text=No+Image';

    return Article(
      title: json['title'] ?? 'Không tiêu đề',
      shortDescription: json['description'] ?? 'Không có mô tả ngắn.',
      fullContent: content,
      thumbnailUrl: imageUrl,
      originalUrl: json['url'] ?? '',
    );
  }
}

class NewsService {
  Future<List<Article>> fetchNewsArticles() async {
    final url =
        '$_BASE_URL?q=soccer&language=en&sortBy=publishedAt&apiKey=$_API_KEY';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List articlesJson = data['articles'];
          return articlesJson
              .where((item) => item['title'] != null && item['url'] != null)
              .map((json) => Article.fromJson(json))
              .toList();
        } else {
          throw Exception('Lỗi từ NewsAPI: ${data['message']}');
        }
      } else {
        throw Exception(
          'Lỗi tải dữ liệu. Mã trạng thái: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Lỗi khi fetch articles: $e');
      throw Exception('Không thể kết nối hoặc tải dữ liệu.');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: NewsListScreen()));
  }
}

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<Article>> _articlesFuture;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _articlesFuture = _newsService.fetchNewsArticles();
  }

  void _navigateToDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách bài viết',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Không thể tải tin tức. Vui lòng kiểm tra API Key và kết nối mạng.\nLỗi: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không tìm thấy bài viết nào.'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return _buildArticleCard(article);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildArticleCard(Article article) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToDetail(article),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  article.thumbnailUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      article.shortDescription,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);

    if (urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không tìm thấy đường dẫn gốc cho bài viết này.'),
        ),
      );
      return;
    }

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể mở đường dẫn: $urlString')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayContent = article.fullContent.length > 500
        ? article.fullContent.substring(0, 500) +
              '... (Đọc thêm tại bài viết gốc)'
        : article.fullContent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết Bài viết'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                article.thumbnailUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.shortDescription,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey,
              ),
            ),
            const Divider(height: 30, thickness: 1),
            Text(
              displayContent,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: article.originalUrl.isNotEmpty
                    ? () => _launchUrl(context, article.originalUrl)
                    : null,
                icon: const Icon(Icons.public),
                label: const Text(
                  'Đọc bài viết gốc',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
