import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';

class RecipeSelection extends StatefulWidget {
  const RecipeSelection({Key? key}) : super(key: key);

  @override
  State<RecipeSelection> createState() => _RecipeSelectionState();
}

class _RecipeSelectionState extends State<RecipeSelection> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: SansText('Recipe Finder', 40.0),
          backgroundColor: Color(0XFF003049),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
          ),
          child: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}
