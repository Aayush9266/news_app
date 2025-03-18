import 'package:flutter/material.dart';
import 'package:news_app/services/api_services.dart';
import '../components/card.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<dynamic> _newsList = [];
  List<dynamic> _filteredNewsList = [];
  bool _isLoading = true;
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Politic', 'Sport', 'Education', 'Game'];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNews();
    _searchController.addListener(_filterNews);
  }

  Future<void> fetchNews() async {
    setState(() {
      _isLoading = true;
    });

    _newsList = await NewsService().fetchNews();
    _filteredNewsList = List.from(_newsList);

    setState(() {
      _isLoading = false;
    });
  }

  void _filterNews() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNewsList = _newsList.where((newsItem) {
        final title = newsItem['title']?.toString().toLowerCase() ?? '';
        return title.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = index;
                    });
                    fetchNews();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _selectedCategory == index ? Colors.blue : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: _selectedCategory == index ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _filteredNewsList.length,
              itemBuilder: (context, index) {
                final newsItem = _filteredNewsList[index];
                return RecommendationCard(newsItem: newsItem);
              },
            ),
          ),
        ],
      ),
    );
  }
}