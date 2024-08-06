import 'package:flutter/material.dart';

class FavouriteViews extends StatelessWidget {
  const FavouriteViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites view"),
      ),
      body: const Text("Favourites"),
    );
  }
}
