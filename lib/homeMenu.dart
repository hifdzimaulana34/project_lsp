import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'database/databaseHelper.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  late List<Map<String, dynamic>> incomeData;

  @override
  void initState() {
    super.initState();
    loadIncomeData();
  }

  Future<void> loadIncomeData() async {
    final data = await DatabaseHelper.instance.getIncomeData();
    setState(() {
      incomeData = data;
    });
  }

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

  List<FlSpot> _getLineSpots(
      List<Map<String, dynamic>> incomeData, String kategori) {
    List<FlSpot> spots = [];
    int day = 1;

    for (final item in incomeData) {
      final itemKategori = item['kategori'];
      final nominal = item['nominal'];

      if (itemKategori == kategori && nominal is double) {
        spots.add(FlSpot(day.toDouble(), nominal));
        day++;
      }
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.getIncomeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No income data available.');
        }

        Color c1 = const Color(0xFFB71C1C);
        Color c2 = const Color(0xFF4CAF50);
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
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _getLineSpots(incomeData, 'pengeluaran'),
                          isCurved: false,
                          color: c1,
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: _getLineSpots(incomeData, 'pemasukan'),
                          isCurved: false,
                          color: c2,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
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
