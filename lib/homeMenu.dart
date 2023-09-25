import 'package:flutter/material.dart';

class homeMenu extends StatelessWidget {
  const homeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage LSP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Rangkuman Bulan Ini'),
            const Text('Pengeluaran: Rp. 500.000'),
            const Text('Pemasukan: Rp. 1.500.000'),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/button_image_1.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Text('Tambah Pemasukan')
                    ],
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/button_image_2.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Text('Tambah Pengeluaran')
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/button_image_3.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const Text("Detail Cash Flow")
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pengaturan');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/button_image_4.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const Text('Pengaturan')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
