import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';
import 'package:flutter_html/flutter_html.dart';

class RecipeDetails extends StatefulWidget {
  final String recipeName;

  const RecipeDetails({super.key, required this.recipeName});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  List<Map<String, dynamic>> recipes = [];
  bool detailsAvailable = true;

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
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data["results"] != null && data["results"] is List) {
          recipes = List<Map<String, dynamic>>.from(data["results"]);
        } else {
          print("No recipes found for $recipeName");
          detailsAvailable = false;
          // Show a message on the screen indicating that the recipe is not available
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Recipe Not Available"),
                content: const Text(
                    "Sorry, details for this recipe are not available."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pop(); // Close the RecipeDetails page
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
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
    String ingredientsApiUrl =
        "https://api.spoonacular.com/recipes/$recipeId/ingredientWidget.json?apiKey=$apiKey";
    String instructionsApiUrl =
        "https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey";

    try {
      // This part pulls the ingredients for the recipe title
      var ingredientsResponse = await http.get(Uri.parse(ingredientsApiUrl));
      if (ingredientsResponse.statusCode == 200) {
        Map<String, dynamic> ingredientsData =
            json.decode(ingredientsResponse.body);

        // How to handle the ingredients
        List<dynamic>? ingredientsList = ingredientsData["ingredients"];
        String ingredients = ingredientsList != null
            ? ingredientsList
                .map<String>((ingredient) => ingredient["name"].toString())
                .join(", ")
            : "No ingredients available";

        // This part pulls the cooking instructions of the selection
        var instructionsResponse =
            await http.get(Uri.parse(instructionsApiUrl));
        if (instructionsResponse.statusCode == 200) {
          Map<String, dynamic> instructionsData =
              json.decode(instructionsResponse.body);
          String instructions =
              instructionsData["instructions"] ?? "No instructions available";

          // The part for the dialog box that displays the ingredients and cooking instructions
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const TextBlack("Full Recipe:", 24.0),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextBlack("Ingredients:", 20.0),
                        const SizedBox(height: 20.0),
                        TextBlack(ingredients, 18.0),
                        const SizedBox(height: 20.0),
                        const TextBlack("Instructions:", 20.0),
                        const SizedBox(height: 20.0),
                        Html(data: instructions),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        } else {
          print(
              "Unable to get instructions. Status code: ${instructionsResponse.statusCode}");
        }
      } else {
        print(
            "Unable to get ingredients. Status code: ${ingredientsResponse.statusCode}");
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
          leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white),
          title: const SansText('Recipe Finder', 40.0),
          backgroundColor: const Color(0XFF003049),
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
                        const SansText("Recipe Name:", 24.0),
                        SansText(recipe['title'], 18.0),
                        const SansText("Time to Prepare:", 24.0),
                        SansText("${recipe['readyInMinutes']} Minutes", 18.0),
                        const SansText("Servings:", 24.0),
                        SansText("${recipe['servings']}", 18.0),
                        const SansText("Image", 24.0),
                        Image.network(
                          "https://spoonacular.com/recipeImages/${recipe['image']}",
                          width: widthDevice / 1.3,
                          height: heightDevice / 3,
                        ),
                        const SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            if (detailsAvailable) {
                              fetchRecipeDetails(recipe["id"]);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const SansText(
                                        "Recipe not available", 20.0),
                                    content: const SansText(
                                        "Sorry, details for this recipe are not available",
                                        20.0),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const SansText("OK", 20.0),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF003049)),
                          child: const SansText("Full Recipe", 15.0),
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}
