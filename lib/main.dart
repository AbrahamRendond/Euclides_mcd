import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euclides MCD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  // Variables para almacenar los números y el resultado
  int numero1 = 0;
  int numero2 = 0;
  int resultado = 0;

  // Controladores para los campos de texto
  TextEditingController numero1Controller = TextEditingController();
  TextEditingController numero2Controller = TextEditingController();
  TextEditingController resultadoController = TextEditingController();

  // Método para calcular el resultado
  void calcular() {
    setState(() {
      // Convertir los valores de los campos de texto a números enteros
      numero1 = int.parse(numero1Controller.text);
      numero2 = int.parse(numero2Controller.text);

      // Llamar al método recursivo para encontrar el máximo común divisor
      resultado = mcd(numero1, numero2);
      resultadoController.text = resultado.toString();
    });
  }

  // Método recursivo para encontrar el máximo común divisor usando el algoritmo de Euclides
  int mcd(int a, int b) {
    // Si los números son iguales, ese es el máximo común divisor
    if (a == b) {
      return a;
    }

    // Si el primero es mayor que el segundo, restar el segundo al primero y volver a llamar al método
    if (a > b) {
      return mcd(a - b, b);
    }

    // Si el segundo es mayor que el primero, restar el primero al segundo y volver a llamar al método
    if (b > a) {
      return mcd(a, b - a);
    }

    // Este caso no debería ocurrir, pero se devuelve 0 por si acaso
    return 0;
  }

  // Método para mostrar los pasos de la operación
  void mostrarPasos() {
    // Crear una cadena con los pasos
    String pasos = 'Para encontrar el máximo común divisor de $numero1 y $numero2 usando el algoritmo de Euclides, se deben seguir los siguientes pasos:\n\n';

    // Variables auxiliares para almacenar los números y el resultado parcial
    int a = numero1;
    int b = numero2;
    int r = mcd(a, b);

    // Mientras los números no sean iguales, ir restando el menor al mayor y añadiendo un paso a la cadena
    while (a != b) {
      if (a > b) {
        pasos += '$a - $b = ${a - b}\n';
        a -= b;
      } else {
        pasos += '$b - $a = ${b - a}\n';
        b -= a;
      }
    }

    // Añadir el resultado final a la cadena de pasos
    pasos += '\nEl máximo común divisor es: $r';

    // Mostrar la cadena de pasos en un cuadro de diálogo
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pasos'),
          content: SingleChildScrollView(
            child: Text(pasos),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Euclides MCD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para el primer número
            TextField(
              controller: numero1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Campo de texto para el segundo número
            TextField(
              controller: numero2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número 2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Campo de texto para el resultado
            TextField(
              controller: resultadoController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Resultado',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Botón para calcular el resultado
            ElevatedButton(
              onPressed: calcular,
              child: Text('Calcular'),
            ),
            SizedBox(height: 16.0),
            // Botón para mostrar los pasos
            ElevatedButton(
              onPressed: mostrarPasos,
              child: Text('Pasos'),
            ),
          ],
        ),
      ),
    );
  }
}