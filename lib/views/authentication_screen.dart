import 'package:e_shop/utils/constants.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName='/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Name',
                      border: InputBorder.none,),
                          validator: _validateName,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                        validator: _validateEmail,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password', border: InputBorder.none),
                        obscureText: true,
                        validator: _validatePassword,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        print(email);
                        print(password);
                        print("Successfull login");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.6,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kBlueColor,
                        ),child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                          child: Center(child: Text(_isLogin ? 'Login' : 'Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
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
                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
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
