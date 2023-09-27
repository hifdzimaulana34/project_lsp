import 'package:flutter/material.dart';
import 'database/databaseHelper.dart';

class homeMenu extends StatelessWidget {
  const homeMenu({super.key});

  double _calculateTotalAmount(
      List<Map<String, dynamic>> incomeData, String kategori) {
    double totalAmount = 0;
    for (final item in incomeData) {
      final itemKategori = item['kategori'];
      final nominal = item['nominal'];
      if (itemKategori == kategori && nominal is double) {
        totalAmount += nominal;
      }
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    double _calculateTotalAmount(
        List<Map<String, dynamic>> incomeData, String kategori) {
      double totalAmount = 0;
      for (final item in incomeData) {
        final itemKategori = item['kategori'];
        final nominal = item['nominal'];
        if (itemKategori == kategori && nominal is double) {
          totalAmount += nominal;
        }
      }
      return totalAmount.toInt().toDouble();
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.getIncomeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Tidak ada data pemasukan.');
        }

        final incomeData = snapshot.data!;
        final pengeluaranTotal =
            _calculateTotalAmount(incomeData, 'pengeluaran');
        final pemasukanTotal = _calculateTotalAmount(incomeData, 'pemasukan');

        return Scaffold(
          appBar: AppBar(
            title: Text('Homepage LSP'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Rangkuman Bulan Ini"),
                const SizedBox(height: 8.0),
                Text(
                  "Pengeluaran: Rp.${pengeluaranTotal.toInt()}",
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Pemasukan: Rp.${pemasukanTotal.toInt()}",
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/pemasukan');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/button_image_1.png'),
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/pengeluaran');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/button_image_2.png'),
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/cashflow');
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
      },
    );
  }
}
