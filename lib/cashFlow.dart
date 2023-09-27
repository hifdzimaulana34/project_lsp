import 'package:flutter/material.dart';
import 'package:proyek_lsp/database/databaseHelper.dart';

class CashFlowPage extends StatefulWidget {
  @override
  _CashFlowPageState createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  late List<Map<String, dynamic>> incomeData = [];

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

  Future<void> deleteIncome(int id) async {
    await DatabaseHelper.instance.deleteIncome(id);
    loadIncomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cash Flow',
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // ignore: unnecessary_null_comparison
        child: incomeData == null
            ? Center(child: CircularProgressIndicator())
            : incomeData.isEmpty
                ? Center(child: Text('No income data available.'))
                : ListView.builder(
                    itemCount: incomeData.length,
                    itemBuilder: (context, index) {
                      final item = incomeData[index];
                      final kategori = item['kategori'];
                      final nominal = item['nominal'];
                      final keterangan = item['keterangan'];
                      final tanggal = item['tanggal'];
                      final isPemasukan = kategori.toLowerCase() == 'pemasukan';

                      return Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                isPemasukan
                                    ? '[ + ] Rp.${nominal.toInt()}'
                                    : '[ - ] Rp.${nominal.toInt()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(keterangan),
                                  Text(tanggal),
                                ],
                              ),
                              trailing: Image.asset(
                                'assets/$kategori.png',
                                width: 48.0,
                                height: 48.0,
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Income'),
                                      content: const Text(
                                          'Apa anda ingin menghapus data tersebut?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteIncome(item['id']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      );
                    },
                  ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text('<< Kembali'),
        ),
      ),
    );
  }
}
