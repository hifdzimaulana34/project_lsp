import 'package:flutter/material.dart';
import 'package:proyek_lsp/cashFlow.dart';
import 'package:proyek_lsp/homeMenu.dart';
import 'package:proyek_lsp/pemasukan.dart';
import 'package:proyek_lsp/pengaturan.dart';
import 'package:proyek_lsp/database/databaseHelper.dart';
import 'package:proyek_lsp/pengeluaran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.insertTestUser();

  // Debug print statement to verify that the database is initialized
  print('Database initialized');

  runApp(MyApp());
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
        '/login': (context) => LoginPage(),
        '/homeMenu': (context) => const HomeMenu(),
        '/pengaturan': (context) => PengaturanPage(),
        '/pemasukan': (context) => TambahPemasukanPage(),
        '/pengeluaran': (context) => TambahPengeluaranPage(),
        '/cashflow': (context) => CashFlowPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    final user = await DatabaseHelper.instance.getUser(username: username);

    if (user != null && user['password'] == password) {
      Navigator.pushReplacementNamed(context, '/homeMenu');
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.4;

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
            SizedBox(
              height: 100,
            ),
            Container(
              width: containerSize,
              height: containerSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Center(
              child: Text(
                'LSP Project',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
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
