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

  // Método recursivo para encontrar el máximo común divisor usando el algoritmo de Euclides con división y módulo
  int mcd(int a, int b) {
    // Si el resto es cero, el divisor es el máximo común divisor
    if (a % b == 0) {
      return b;
    }
    // Si el resto es distinto de cero, se llama al método con el divisor y el resto como nuevos parámetros
    else {
      return mcd(b, a % b);
    }
  }

  // Método para mostrar los pasos de la operación en una tabla
  void mostrarPasos() {
    // Crear una lista con los encabezados de la tabla
    List<String> encabezados = ['Paso', 'Operación', 'Ecuación'];
    // Crear una lista vacía para almacenar las filas de la tabla
    List<List<String>> filas = [];
    // Variables auxiliares para almacenar los números y el resultado parcial
    int a = numero1;
    int b = numero2;
    int r = mcd(a, b);
    // Variable para contar los pasos
    int paso = 1;
    // Mientras el resto sea distinto de cero, ir dividiendo el mayor entre el menor y añadiendo una fila a la lista
    while (a % b != 0) {
      // Añadir una fila con el paso, la operación y la ecuación
      filas.add([
        paso.toString(),
        '$a / $b',
        '$a = ${a ~/ b} * $b + ${a % b}'
      ]);
      // Actualizar los valores de a y b con el divisor y el resto
      int temp = a;
      a = b;
      b = temp % b;
      // Incrementar el contador de pasos
      paso++;
    }
    // Añadir una fila final con el resultado
    filas.add([
      paso.toString(),
      '$a / $b',
      '$a = ${a ~/ b} * $b + ${a % b} -> MCD = $b'
    ]);
    // Mostrar la tabla en un cuadro de diálogo
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pasos'),
            content: SingleChildScrollView(
              child: SingleChildScrollView( // Usar SingleChildScrollView para hacer scroll horizontal
                scrollDirection: Axis.horizontal, // Establecer la dirección del scroll a horizontal
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FixedColumnWidth(50),
                    1: FixedColumnWidth(100),
                    2: FixedColumnWidth(200)
                  },
                  children: [
                    // Crear una fila con los encabezados de la tabla
                    TableRow(
                        children: encabezados
                            .map((e) => Center(child: Text(e)))
                            .toList()),
                    // Crear las filas con los datos de la lista
                    ...filas.map((fila) => TableRow(
                        children: fila.map((e) => Center(child: Text(e))).toList()))
                  ],
                ),
              ),
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
        });
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