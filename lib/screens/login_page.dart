import 'package:ecommerceapp/components/image_png.dart';
import 'package:ecommerceapp/components/my_button.dart';
import 'package:ecommerceapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 88,
              ),
              const Icon(
                Icons.lock,
                size: 135,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                    color: Color.fromARGB(255, 73, 70, 70), fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Enter your Username',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your Password',
                obscureText: true,  
              ),
              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 73, 70, 70), fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MyButton(
                onTap: loginUserIn,
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImagePng(imagepath: 'assets/images/apple.png'),
                  SizedBox(
                    width: 18,
                  ),
                  ImagePng(imagepath: 'assets/images/google.png'),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Register now',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
