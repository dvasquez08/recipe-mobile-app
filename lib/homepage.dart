import 'package:flutter/material.dart';
import 'package:recipe_finder/components.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/recipes.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ingredients = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> _recipes = [''];

  Future<void> _getRecipes() async {
    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/findByIngredients' +
          '?apiKey=3c8a4c31879e41d18d7c211b35fddc69' +
          '&ingredients=${_ingredients.text}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _recipes =
          List<String>.from(data.map((Recipe) => Recipe['title'].toString()));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Recipes(recipes: _recipes)),
      );
    } else {
      throw Exception('No recipes found');
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(20.0)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: const Column(
                  children: [
                    SansText(
                        'Welcome! This app will help you find recipes based on what'
                        ' ingredients you have. Let\'s get started!',
                        20.0),
                    SizedBox(height: 30.0),
                    SansText('Step 1: Check the fridge and see what you have.',
                        20.0),
                    SansText(
                        'Step 2: Type the items that you have in the text box below',
                        20.0),
                    SansText('Step 3: Tap on the "Get Recipe" button', 20.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(20.0)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 8.0, top: 8.0),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: const Column(
                  children: [
                    SansText(
                        'You will see a list of dishes that you can make with your ingredients. The recipe titles are'
                        ' links which you can tap. When you tap on a recipe title, it will take you to a Google search for that recipe.'
                        'I hope you find this helpful and that it brings out the inner-chef in you. Happy cooking!',
                        20.0),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30.0),
                      TextForm(
                          text: 'Ingredients',
                          containerWidth: widthDevice / 1.3,
                          hintText: 'Enter ingredients here',
                          validator: (text) {
                            if (text.toString().isEmpty) {
                              return "Field is required";
                            }
                          },
                          controller: _ingredients),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
