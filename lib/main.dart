import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meu primeiro projeto",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  String _resultado = '';
  String _classeImc = '';

  void calcularImc() {
    final double peso = double.tryParse(_pesoController.text) ?? 0;
    final double altura = double.tryParse(_alturaController.text) ?? 0;

    if (peso > 30 && altura > 80 && peso < 200 && altura < 250) {
      // Calcula o IMC
      final double imc = peso / ((altura / 100) * (altura / 100));

      setState(() {
        _resultado = 'Seu IMC é ${imc.toStringAsFixed(2)}';
        _classeImc = classImc(imc);
      });
    } else {
      setState(() {
        _resultado = 'Por favor, insira valores válidos!';
        _classeImc = '';
      });
    }
  }

  String classImc(double imc) {
    if (imc < 18.5) {
      return 'Indivíduo com baixo peso';
    } else if (imc >= 18.5 && imc <= 24.99) {
      return 'Indivíduo com peso normal';
    } else if (imc >= 25 && imc <= 29.99) {
      return 'Indivíduo com sobrepeso';
    } else {
      return 'Indivíduo obeso';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora IMC',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Calcule seu IMC',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura em cm:',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 1, 102)),
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso em kilogramas:',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 2, 1, 102)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calcularImc,
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                child: Text(
                  'Calcular',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _resultado,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _classeImc,
                style: const TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
