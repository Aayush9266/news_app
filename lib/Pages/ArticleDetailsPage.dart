import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class ArticleDetailPage extends StatelessWidget {
  final dynamic newsItem;

  const ArticleDetailPage({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                getImageWidget(newsItem['image'], width: double.infinity, height: 250),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      newsItem['category'] ?? 'Sports',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem['title'] ?? 'Alexander wears modified helmet in road races',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Trending',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '•',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_getTimeAgo(newsItem['published_at'])} ago',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                        child: Text(
                          (newsItem['source'] ?? 'CNN').substring(0, 1).toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                newsItem['source'] ?? 'CNN Indonesia',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, color: Colors.blue, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    newsItem['description'] ?? 'As a tech department, we\'re usually pretty good at spotting tech that\'s out of the ordinary. Often in cycling we\'re used to seeing new aero innovation, and while there are certainly aero tricks used in road stages, they are harder to spot.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    newsItem['content'] ?? 'A case in point, throughout the Volta ao Algarve, Alexander Kristoff has been wearing an old discontinued time trial helmet, complete with visor removed, in the road stages without any apparent aerodynamic testing. He even wore it in the brutally steep uphill finish on Alto da Fóia.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(String? dateString) {
    if (dateString == null) return '6 hours';

    try {
      final DateTime now = DateTime.now();
      final DateTime date = DateTime.parse(dateString);
      final Duration difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} days';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '6 hours';
    }
  }
}