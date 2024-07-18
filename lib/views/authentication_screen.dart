import 'package:e_shop/utils/constants.dart';
import 'package:e_shop/views/products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'widgets/form_field_container.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void clearControllers() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          "e-Shop",
          style: TextStyle(color: kBlueColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  if (!_isLogin) ...[
                    FormFieldContainer(
                        controller: _nameController,
                        labelText: 'Name',
                        isObscure: false,
                        validator: _validateName),
                    SizedBox(height: 20),
                  ],
                  FormFieldContainer(
                      controller: _emailController,
                      labelText: 'Email',
                      isObscure: false,
                      validator: _validateEmail),
                  SizedBox(
                    height: 20,
                  ),
                  FormFieldContainer(
                      controller: _passwordController,
                      labelText: 'Password',
                      isObscure: true,
                      validator: _validatePassword),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        User? user;
                        if (_isLogin) {
                          try {
                            user =
                                await _authController.signIn(email, password);
                          } catch (e) {
                            clearControllers();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Inavlid credentials'),
                            ));
                          }
                        } else {
                          String name = _nameController.text.trim();
                          user = await _authController.signUp(
                              email, password, name);
                        }
                        if (user != null) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductsScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Authentication failed')),
                          );
                        }
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kBlueColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Center(
                              child: Text(
                            _isLogin ? 'Login' : 'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_isLogin
                          ? 'New here ? '
                          : 'Already have an account ? '),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                            clearControllers();
                          });
                        },
                        child: Text(_isLogin ? 'Sign up' : 'Log in'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
