import 'package:flutter/material.dart';
import 'package:proyek_lsp/homeMenu.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/homeMenu': (context) => const homeMenu(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) {
    // Authenticate the user and determine the user's access level
    // Replace this with your own authentication logic
    final String username = usernameController.text;
    final String password = passwordController.text;

    // Here, you can replace the condition with your own logic to determine user access level
    if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacementNamed(context, '/homeMenu');
    } else {
      Navigator.pushReplacementNamed(context, '/userHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerSize =
        MediaQuery.of(context).size.width * 0.4; // Adjust the size as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Centered Logo Image
            SizedBox(
              height: 100,
            ),

            Container(
              width: containerSize,
              height: containerSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/logo.png'), // Replace with your logo image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Centered Text for the Title
            const Center(
              child: Text(
                'LSP Project',
                style: TextStyle(
                  fontSize: 24.0, // Adjust the font size as needed
                  fontWeight:
                      FontWeight.bold, // Adjust the font weight as needed
                ),
              ),
            ),

            const SizedBox(height: 16.0),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
