import 'package:flutter/material.dart';
import 'package:it_solution_task/viewmodel/GalleryViewModel.dart';
import 'package:provider/provider.dart';
import 'package:it_solution_task/screens/gallery_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GalleryViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: GalleryScreen(),
      ),
    );
  }
}
