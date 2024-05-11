import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryViewModel extends ChangeNotifier {
  final List<dynamic> _images = [];
  List<dynamic> get images => _images;

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool loading = false;
  String? _searchQuery;
  String? get searchQuery => _searchQuery;
  set searchQuery(String? value) {
    _searchQuery = value;
    loadImages();
    notifyListeners();
  }

  GalleryViewModel() {
    loadImages();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadImages();
    }
  }

  Future<void> loadImages() async {
    if (loading) return;
    loading = true;
    notifyListeners();
    const String apiKey = "43824144-7331750bccbd4a4cc144c8a5b";
    final String query = searchQuery ?? "";
    final String url =
        "https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _images.addAll(json.decode(response.body)['hits']);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      throw Exception('Failed to load images');
    }
  }
}
