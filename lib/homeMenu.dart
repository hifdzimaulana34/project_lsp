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
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                const Text('Rangkuman Bulan Ini'),
                const Text('Pengeluaran: Rp. 500.000'),
                const Text('Pemasukan: Rp. 1.500.000'),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your function for the first button here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/button_image_1.png'),
                                fit: BoxFit.fill, // Fill the button completely
                              ),
                            ),
                          ),
                        ),
                        const Text('Tambah Pemasukan')
                      ],
                    ),
                    SizedBox(width: 16.0), // Add spacing between buttons
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your function for the second button here
                          },
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
              ],
            ),
            SizedBox(height: 16.0), // Add spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your function for the third button here
                      },
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
                SizedBox(width: 16.0), // Add spacing between buttons
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your function for the fourth button here
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
