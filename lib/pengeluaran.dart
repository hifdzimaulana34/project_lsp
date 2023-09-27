import 'package:flutter/material.dart';

import 'database/databaseHelper.dart';

class TambahPengeluaranPage extends StatefulWidget {
  @override
  _TambahPengeluaranPageState createState() => _TambahPengeluaranPageState();
}

class _TambahPengeluaranPageState extends State<TambahPengeluaranPage> {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        tanggalController.text = picked.toString();
      });
    }
  }

  void _resetFields() {
    tanggalController.clear();
    nominalController.clear();
    keteranganController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tambah Pengeluaran',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            const Text(
              'Tanggal:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: TextFormField(
                controller: tanggalController,
                enabled: false,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: nominalController,
              decoration: const InputDecoration(
                labelText: 'Nominal',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: keteranganController,
              decoration: const InputDecoration(
                labelText: 'Keterangan',
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text('Reset'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final tanggal = tanggalController.text;
                    final nominal =
                        double.tryParse(nominalController.text) ?? 0.0;
                    final keterangan = keteranganController.text;

                    if (tanggal.isNotEmpty && nominal > 0) {
                      final kategori = 'pengeluaran';

                      await DatabaseHelper.instance.insertExpense(
                          tanggal, nominal, keterangan, kategori);

                      _resetFields();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Data Input Pengeluaran Berhasil!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Tolong isi semua field yang ada')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text('Simpan'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text('<< Kembali'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
