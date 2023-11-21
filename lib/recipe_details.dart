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

  Future<void> fetchRecipeDetails(int recipeId) async {
    String apiKey = "3c8a4c31879e41d18d7c211b35fddc69";
    String ingredientsApiUrl = "https://api.spoonacular.com/recipes/$recipeId/ingredientWidget.json?apiKey=$apiKey";
    String instructionsApiUrl = "https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey";

    try {
      // Fetch ingredients
      var ingredientsResponse = await http.get(Uri.parse(ingredientsApiUrl));
      if (ingredientsResponse.statusCode == 200) {
        Map<String, dynamic> ingredientsData = json.decode(ingredientsResponse.body);

        // Handle the case where ingredients may be null or not a List
        List<dynamic>? ingredientsList = ingredientsData["ingredients"];
        String ingredients = ingredientsList != null && ingredientsList is List
            ? ingredientsList.map<String>((ingredient) => ingredient["name"].toString()).join(", ")
            : "No ingredients available";

        // Fetch instructions
        var instructionsResponse = await http.get(Uri.parse(instructionsApiUrl));
        if (instructionsResponse.statusCode == 200) {
          Map<String, dynamic> instructionsData = json.decode(instructionsResponse.body);
          String instructions = instructionsData["instructions"] ?? "No instructions available";

          // Show the dialog with both ingredients and instructions
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: SansText("Recipe Details", 24.0),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBlack("Ingredients", 20.0),
                      SizedBox(height: 20.0),
                      TextBlack(ingredients, 18.0),
                      TextBlack("Instructions", 20.0),
                      SizedBox(height: 20.0),
                      TextBlack(instructions, 18.0),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
        } else {
          print("Unable to get instructions. Status code: ${instructionsResponse.statusCode}");
        }
      } else {
        print("Unable to get ingredients. Status code: ${ingredientsResponse.statusCode}");
      }
    } catch (error) {
      print("Error fetching recipe details: $error");
    }
  }

  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    var heightDevice = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                        // SansText("Recipe", 24.0),
                        // SansText("${recipe['sourceUrl']}", 18.0),
                        SansText("Image", 24.0),
                        Image.network(
                          "https://spoonacular.com/recipeImages/${recipe['image']}",
                          width: widthDevice / 1.3,
                          height: heightDevice / 3,
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            fetchRecipeDetails(recipe["id"]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF003049)
                          ),
                          child: SansText("Full Recipe", 15.0),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
