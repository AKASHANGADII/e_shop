import 'package:e_shop/utils/constants.dart';
import 'package:e_shop/views/authentication_screen.dart';
import 'package:e_shop/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    User? user = await _authController.getCurrentUser();
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductsScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("e-Shop",style: TextStyle(fontSize: 40,color: kBlueColor,fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
