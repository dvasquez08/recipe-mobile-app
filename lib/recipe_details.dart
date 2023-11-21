import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';

class RecipeDetails extends StatefulWidget {
  final String recipeName;

  const RecipeDetails({super.key, required this.recipeName});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String apiKey = "3c8a4c31879e41d18d7c211b35fddc69";
    String recipeName = widget.recipeName;
    String apiUrl =
        "https://api.spoonacular.com/recipes/search?query=$recipeName&apiKey=$apiKey";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      print("API Response: ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data["results"] != null && data["results"] is List) {
          recipes = List<Map<String, dynamic>>.from(data["results"]);
        } else {
          print("No recipes found for $recipeName");
        }
      } else {
        print(
            'Failed to fetch recipe details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching recipe details: $error');
    }

    if (mounted) {
      setState(() {});
    }
  }

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
            image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    var recipe = recipes[index];
                    return Column(
                      children: [
                        SansText("Recipe Name", 24.0),
                        SansText(recipe['title'], 18.0),
                        SansText("Minutes to Cook", 24.0),
                        SansText("${recipe['readyInMinutes']}", 18.0),
                        SansText("Servings", 24.0),
                        SansText("${recipe['servings']}", 18.0),
                        SansText("Recipe", 24.0),
                        SansText("${recipe['sourceUrl']}", 18.0),
                        SansText("Image", 24.0),
                        Image.network("${recipe['image']}"),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
