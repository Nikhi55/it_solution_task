import 'package:flutter/material.dart';
import 'package:it_solution_task/screens/fullscreen.dart';
import 'package:it_solution_task/viewmodel/GalleryViewModel.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final GalleryViewModel viewModel = GalleryViewModel();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GalleryViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: provider.searchController,
          onChanged: (value) {
            provider.images.clear();
            setState(() {
              provider.searchQuery = value;
            });
            provider.loadImages(value);
          },
          decoration: InputDecoration(
            hintText: 'Search images...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                provider.searchQuery = '';
                provider.searchController.clear();
              },
            ),
          ),
        ),
      ),
      body: Consumer<GalleryViewModel>(
        builder: (context, model, _) => model.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                controller: model.scrollController,
                itemCount: model.images.length,
                itemBuilder: (context, index) {
                  final image = model.images[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imageUrl: image['webformatURL']),
                        ),
                      );
                    },
                    child: GridTile(
                      child: Image.network(image['webformatURL'],
                          fit: BoxFit.cover),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text('Likes: ${image['likes']}'),
                        subtitle: Text('Views: ${image['views']}'),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
