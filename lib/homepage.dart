import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController _ingredients = TextEditingController();
  List<String> _recipes = [''];

  Future<void> _getRecipes() async {
    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/findByIngredients' +
        '?apiKey=3c8a4c31879e41d18d7c211b35fddc69' +
        '&ingredients=${_ingredients.text}'),
    );

    if (response.statusCode == 200) {
      final List<String> recipes = json.decode(response.body)
          .map<String>((recipe) => recipe['title'].toString())
          .toList();
    }

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   setState(() {
    //     _recipes = List<String>.from(data['recipes']);
    //   });
    // } else {
    //   throw Exception('No recipes found');
    // }
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: SansText('Recipe Finder', 40.0),
          backgroundColor: Color(0XFF003049),
          centerTitle: true,

        ),
        body: ListView(
          children: [


            Container(
              alignment: Alignment.center,
              child: const Column(
                children: [
                  SizedBox(height: 25.0),
                  SansText(
                      'Welcome! This app will help you find recipes based on what'
                          'ingredients you have.Let"\"s get started!',
                      20.0),
                  SizedBox(height: 30.0),
                  SansText(
                      'Step 1: Check the fridge and see what you have.', 20.0),
                  SansText(
                      'Step 2: Type the items that you have in the text box below',
                      20.0),
                  SansText('Step 3: Tap on the "Get Recipe" button', 20.0),
                  SizedBox(height: 30.0),
                  SansText(
                      'You will see a list of dishes that you can make with your ingredients. The recipe titles are'
                          'links which you can tap. When you tap on a recipe title, it will take you to a Google search for that recipe.'
                          'I hope you find this helpful and that it brings out the inner-chef in you. Happy cooking!',
                      20.0),
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  TextField(
                    controller: _ingredients,
                    decoration: InputDecoration(labelText: 'Enter ingredients'),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(
                    height: 50.0,
                    width: 200.0,
                    child: MaterialButton(
                      child: SansText('Get Recipes!', 25.0),
                      splashColor: Colors.grey,
                      color: Color(0XFF003049),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                      onPressed: _getRecipes,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_recipes[index]),
                        );
                      },
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
