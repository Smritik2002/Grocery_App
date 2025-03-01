import 'package:ecommerceapp/components/image_png.dart';
import 'package:ecommerceapp/components/my_textfield.dart';
import 'package:ecommerceapp/screens/details_page.dart';
import 'package:ecommerceapp/screens/register.dart';
import 'package:ecommerceapp/service/api_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService authService = ApiService();

  void loginUserIn() async {
    String email = emailcontroller.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar("Please fill in both fields", Colors.red);
      return;
    }

    final result = await authService.login(email, password);

    if (result['success']) {
     
      showSnackbar(result['message'], Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DetailsPage(
          userId: result['data']['user_id']
        )), // Navigate to the HomePage
      );
    } else {
      showSnackbar(result['message'], Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 88),
                const Icon(Icons.lock, size: 135),
                const SizedBox(height: 12),
                const Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(color: Color.fromARGB(255, 73, 70, 70), fontSize: 18),
                ),
                const SizedBox(height: 18),
                MyTextField(
                  controller: emailcontroller,
                  hintText: 'Enter your username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color.fromARGB(255, 73, 70, 70), fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loginUserIn, // Trigger login on button press
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ImagePng(imagepath: 'assets/images/apple.png'),
                //     SizedBox(width: 18),
                //     ImagePng(imagepath: 'assets/images/google.png'),
                //   ],
                // ),
                const SizedBox(height: 32),
                Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text('Not a member?'),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0, // Removes the popup effect
        backgroundColor: Colors.transparent, // Optional: Makes it blend with the background
        shadowColor: Colors.transparent, // Ensures no shadow
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: const Text(
        'Register now',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  ],
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
