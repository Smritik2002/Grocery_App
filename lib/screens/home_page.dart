import 'package:ecommerceapp/screens/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 57, right: 57, top: 160),
            child: Image.asset(
              "assets/images/Grocery.png",
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(36.0),
            child: Text(
              'We deliver groceries at your doorstep',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Fresh items everyday',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 67,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
