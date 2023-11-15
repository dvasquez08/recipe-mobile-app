import 'package:flutter/material.dart';

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
    var heightDevice = MediaQuery
        .of(context)
        .size
        .height;
    var widthDevice = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_recipes[index]),
          );
        },
      ),
    );
  }
}


// Container(
//     width: widthDevice / 1.3,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: _recipes.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(_recipes[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     )
// );
