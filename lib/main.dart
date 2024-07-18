import 'package:e_shop/controllers/products_controller.dart';
import 'package:e_shop/services/api_service.dart';
import 'package:e_shop/views/authentication_screen.dart';
import 'package:e_shop/views/products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
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
      home: AuthScreen(),
      routes: {
        '/auth':(context)=>AuthScreen(),
        '/products-screen':(context)=>ProductsScreen()
      },
    );
  }
}
