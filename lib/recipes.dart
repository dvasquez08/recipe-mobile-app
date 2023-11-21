import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';
import 'package:recipe_finder/recipe_details.dart';

class Recipes extends StatefulWidget {
  final List<String> recipes;

  Recipes({required this.recipes});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  late List<String> _recipes = [" "];

  @override
  void initState() {
    super.initState();
    _recipes = widget.recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: SansText('Recipe Finder', 40.0),
        backgroundColor: Color(0XFF003049),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
          child: ListView.builder(
            itemCount: _recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                // title: SansText(_recipes[index], 20.0),
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetails(recipeName: _recipes[index]),
                      ),
                    );
                  },
                  child: SansText(_recipes[index], 20.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
