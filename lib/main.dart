import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

// --- ВАЛІДАЦІЯ ---
bool validateEmail(String email) =>
    RegExp(r'\S+@\S+\.\S+').hasMatch(email);

bool validatePassword(String password) =>
    password.length >= 6;

// --- ЕКРАН ---
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

  void handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;

    if (!validateEmail(email)) {
      setState(() => message = 'Неправильний email');
    } else if (!validatePassword(password)) {
      setState(() => message = 'Пароль мінімум 6 символів');
    } else {
      setState(() => message = 'Успішний вхід!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // --- ІНДИВІДУАЛЬНЕ ЗАВДАННЯ ---
            TextField(
              decoration: InputDecoration(labelText: 'Введіть текст'),
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
            ),

            SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 30),

            // --- ЛОГІН ---
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),

            SizedBox(height: 10),

            Text(message),

          ],
        ),
      ),
    );
  }
}