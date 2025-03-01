import 'package:ecommerceapp/service/api_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  List<String> selectedInterests = [];
  bool isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        var response = await ApiService().registerUser(
          usernameController.text,
          emailController.text,
          passwordController.text,
          int.parse(ageController.text), // Convert age to int
          selectedInterests.join(", "), // Join selected interests with a comma
        );

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration successful!"),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ));
      }
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.pink.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    labelText: "Username",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? "Enter a username"
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? "Enter an email"
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                  validator: (value) => value!.length < 6
                                      ? "Password must be at least 6 characters"
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<int>(
                                  decoration: const InputDecoration(
                                    labelText: "Age",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: List.generate(
                                    100,
                                        (index) => DropdownMenuItem<int>(
                                      value: index + 18,
                                      child: Text((index + 18).toString()),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      ageController.text = value.toString();
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? "Select your age"
                                      : null,
                                ),
                                const SizedBox(height: 12),
                                Text("Select Interests", style: TextStyle(fontSize: 16)),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    ChoiceChip(
                                      label: Text("Fruits"),
                                      selected: selectedInterests.contains("Fruits"),
                                      onSelected: (selected) {
                                        setState(() {
                                          if (selected) {
                                            selectedInterests.add("Fruits");
                                          } else {
                                            selectedInterests.remove("Fruits");
                                          }
                                        });
                                      },
                                    ),
                                    ChoiceChip(
                                      label: Text("Vegetables"),
                                      selected: selectedInterests.contains("Vegetables"),
                                      onSelected: (selected) {
                                        setState(() {
                                          if (selected) {
                                            selectedInterests.add("Vegetables");
                                          } else {
                                            selectedInterests.remove("Vegetables");
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _register,
                                  child: const Text("Register"),
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                                    padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(vertical: 14.0)),
                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
