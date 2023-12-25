import 'package:flutter/material.dart';
//import 'package:get/get.dart';

//import 'category_controller.dart';

class CategoryView extends StatelessWidget {

  @override
  Widget build(context) {
    //final CategoryController c = Get.find();

    return Scaffold(
      body: 
      
        Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Category:*',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ), //Expanded
                ],
              ), //Row
            ), //Positioned
          ],
        ), //Stack
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.refresh), onPressed: () {}));
  }
}