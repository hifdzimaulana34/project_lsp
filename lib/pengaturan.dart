import 'package:flutter/material.dart';
import 'package:proyek_lsp/database/databaseHelper.dart';

class PengaturanPage extends StatelessWidget {
  final TextEditingController previousPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void checkAndUpdatePassword(BuildContext context) async {
    final String previousPassword = previousPasswordController.text;
    final String newPassword = newPasswordController.text;

    final user = await DatabaseHelper.instance.getUser(username: 'user');

    if (user != null && user['password'] == previousPassword) {
      final int rowsUpdated =
          await DatabaseHelper.instance.updatePassword('user', newPassword);

      if (rowsUpdated > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password berhasil diperbarui')),
        );
      } else {
        // Password update failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pembaruan password gagal')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password lama salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            const Text(
              'Ganti Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: previousPasswordController,
              decoration: const InputDecoration(
                labelText: 'Password Saat Ini',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password Baru',
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => checkAndUpdatePassword(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text('Simpan'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text('Log Out'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/homeMenu');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text('Kembali'),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                            'assets/hifdzi.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About this app..',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text('Aplikasi ini dibuat oleh:'),
                              Text(
                                'M. Hifdzi Maulana',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('NIM: 2141764142'),
                              Text('Tanggal: 25 September 2023'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
