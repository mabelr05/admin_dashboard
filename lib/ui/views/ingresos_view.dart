import 'package:flutter/material.dart';

class IngresosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Pagos',
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
            ElevatedButton(
              onPressed: () {
                _registerPayment();
              },
              child: Text(
                'Registrar Pago',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Pagos Registrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _payments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(_payments[index].name),
                      Text(_payments[index].ciclo),
                      Text('\$${_payments[index].amount.toStringAsFixed(2)}'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerPayment() {
    final String carrera = _nameCarreraController.text;
    final String ciclo = _nameCicloController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (carrera.isNotEmpty && amount > 0) {
      setState(() {
        _payments.add(Payment(name: carrera, amount: amount, ciclo: ciclo));
        _nameCarreraController.clear();
        _nameCicloController.clear();
        _amountController.clear();
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

  Payment({required this.name, required this.amount, required this.ciclo});
}
