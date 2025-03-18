import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Pages/ArticleDetailsPage.dart';
import '../main.dart';

class RecommendationCard extends StatelessWidget {
  final dynamic newsItem;

  const RecommendationCard({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(newsItem: newsItem),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: getImageWidget(newsItem['image'], width: 80, height: 80),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem['category'] ?? 'Sports',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    newsItem['title'] ?? 'What Training Do Volleyball Players Need?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          (newsItem['author'] ?? 'A').substring(0, 1).toUpperCase(),
                          style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        newsItem['author'] ?? 'Aayush',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '•',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(newsItem['published_at']),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Feb 27, 2023';

    try {
      final DateTime date = DateTime.parse(dateString);
      final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return 'Feb 27, 2023';
    }
  }
}


