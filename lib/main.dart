import 'package:e_shop/controllers/products_controller.dart';
import 'package:e_shop/services/api_service.dart';
import 'package:e_shop/views/authentication_screen.dart';
import 'package:e_shop/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> ProductsController()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsScreen(),
      routes: {
        AuthScreen.routeName:(context)=>AuthScreen(),
      },
    );
  }
}
