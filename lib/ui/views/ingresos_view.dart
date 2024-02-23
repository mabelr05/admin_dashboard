import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Importar el paquete image_picker

class IngresosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Pagos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _nameCarreraController = TextEditingController();
  final TextEditingController _nameCicloController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  List<Payment> _payments = [];
  XFile? _image; // Variable para almacenar la imagen seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Pagos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameCarreraController,
              decoration: InputDecoration(labelText: 'Carrera'),
            ),
            TextField(
              controller: _nameCicloController,
              decoration: InputDecoration(labelText: 'Ciclo'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cantidad'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                ElevatedButton(
                  onPressed: _registerPayment,
                  child: Text('Registrar Pago'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Pagos Registrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.indigo[100]!),
              columns: [
                DataColumn(label: Text('Carrera')),
                DataColumn(label: Text('Ciclo')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Usuario')),
                DataColumn(
                    label:
                        Text('Imagen')), // Agregar una columna para la imagen
              ],
              rows: _payments.map((payment) {
                return DataRow(
                  color: MaterialStateColor.resolveWith((states) =>
                      _payments.indexOf(payment) % 2 == 0
                          ? Colors.grey[200]!
                          : Colors.white),
                  cells: [
                    DataCell(Text(payment.name)),
                    DataCell(Text(payment.ciclo)),
                    DataCell(Text('\$${payment.amount.toStringAsFixed(2)}')),
                    DataCell(Text(payment.date)),
                    DataCell(Text(payment.user)),
                    DataCell(payment.image != null
                        ? Image.file(File(payment.image!.path))
                        : Text('No Image')), // Mostrar la imagen seleccionada
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  void _registerPayment() {
    final String carrera = _nameCarreraController.text;
    final String ciclo = _nameCicloController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final String date =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final String user = 'Usuario';

    if (carrera.isNotEmpty && amount > 0) {
      setState(() {
        _payments.add(Payment(
            name: carrera,
            amount: amount,
            ciclo: ciclo,
            date: date,
            user: user,
            image: _image));
        _nameCarreraController.clear();
        _nameCicloController.clear();
        _amountController.clear();
        _image =
            null; // Limpiar la imagen seleccionada después de registrar el pago
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Por favor, ingrese un nombre y una cantidad válida.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class Payment {
  final String name;
  final double amount;
  final String ciclo;
  final String date;
  final String user;
  final XFile? image; // Añadir una variable para la imagen

  Payment(
      {required this.name,
      required this.amount,
      required this.ciclo,
      required this.date,
      required this.user,
      required this.image});
}
