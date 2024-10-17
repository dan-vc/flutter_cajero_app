import 'package:flutter/material.dart';
//Holaa
// Función principal que inicia la aplicación.
void main() {
  runApp(const MyApp()); // Ejecuta la aplicación MyApp.
}

// Widget sin estado que representa la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cajero Automático Flutter', // Título de la aplicación.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Definición del esquema de colores.
        useMaterial3: true, // Habilita el uso de Material Design 3.
      ),
      home: const LoginScreen(), // Pantalla principal de la aplicación (login).
      debugShowCheckedModeBanner: false, // Oculta el banner de debug.
    );
  }
}

/* Widget con estado para la pantalla de login */
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState(); // Crea el estado de LoginScreen.
}

/* Estado de la pantalla de login */
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuario = TextEditingController(); // Controlador para el campo de usuario.
  final TextEditingController contrasena = TextEditingController(); // Controlador para el campo de contraseña.
  bool _obscureText = true; // Variable para controlar la visibilidad de la contraseña.

  // Método para manejar el proceso de login.
  void logearse() {
    String username = usuario.text.trim(); // Obtiene y limpia el texto del campo de usuario.
    String password = contrasena.text.trim(); // Obtiene y limpia el texto del campo de contraseña.

    // Si el usuario o la contraseña están vacíos, muestra un mensaje.
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa ambos campos.')),
      );
    } 
    // Si las credenciales no coinciden con las esperadas, muestra un error.
    else if (username != 'senati' || password != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nombre de usuario o contraseña incorrectos.')),
      );
    } 
    // Si las credenciales son correctas, navega a la pantalla del cajero.
    else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CajeroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Color de fondo de la pantalla.
      appBar: AppBar(
        title: const Text('Login'), // Título de la AppBar.
        backgroundColor: Colors.blue[900], // Color de fondo de la AppBar.
        foregroundColor: Colors.white, // Color del texto de la AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0), // Añade espacio alrededor del contenido.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente el contenido.
          children: <Widget>[
            const Text(
              'Iniciar Sesión', // Texto de encabezado de la pantalla.
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo del texto.
            ),
            const SizedBox(height: 40), // Espacio entre el texto y el campo de usuario.
            TextField(
              controller: usuario, // Conecta el campo de texto con el controlador.
              decoration: InputDecoration(
                labelText: 'Nombre de usuario', // Etiqueta del campo de texto.
                border: const UnderlineInputBorder(), // Estilo del borde.
                filled: true,
                fillColor: Colors.white, // Color de fondo del campo.
                labelStyle: const TextStyle(color: Colors.blueGrey), // Estilo de la etiqueta.
                hintStyle: TextStyle(color: Colors.blueGrey[300]), // Estilo del texto sugerido.
              ),
            ),
            const SizedBox(height: 16), // Espacio entre el campo de usuario y contraseña.
            TextField(
              controller: contrasena, // Conecta el campo de texto con el controlador.
              decoration: InputDecoration(
                labelText: 'Contraseña', // Etiqueta del campo de contraseña.
                border: const UnderlineInputBorder(),
                filled: true,
                fillColor: Colors.white, // Color de fondo.
                labelStyle: const TextStyle(color: Colors.blueGrey), // Estilo de la etiqueta.
                hintStyle: TextStyle(color: Colors.blueGrey[300]), // Estilo del texto sugerido.
              ),
              obscureText: _obscureText, // Oculta el texto (para la contraseña).
            ),
            const SizedBox(height: 20), // Espacio antes del botón de login.
            ElevatedButton(
              onPressed: logearse, // Acción al presionar el botón.
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Tamaño del botón.
                backgroundColor: Colors.blue[900], // Color de fondo del botón.
                foregroundColor: Colors.white, // Color del texto del botón.
                textStyle: const TextStyle(fontSize: 18), // Estilo del texto del botón.
              ),
              child: const Text('Iniciar Sesión'), // Texto dentro del botón.
            ),
          ],
        ),
      ),
    );
  }
}

/* Pantalla de Cajero Automático */
class CajeroScreen extends StatefulWidget {
  const CajeroScreen({super.key, this.movimientos, this.saldo});
  final List? movimientos; // Lista de movimientos (transacciones).
  final int? saldo; // Saldo actual.

  @override
  State<CajeroScreen> createState() => _CajeroScreenState();
}

/* Estado de la pantalla del Cajero */
class _CajeroScreenState extends State<CajeroScreen> {
  List movimientos = [500, -200]; // Lista inicial de movimientos.
  int saldo = 1000; // Saldo inicial.

  @override
  Widget build(BuildContext context) {
    // Actualiza los movimientos y saldo si se pasa algún valor.
    if (widget.movimientos != null) {
      movimientos = widget.movimientos!;
    }
    if (widget.saldo != null) {
      saldo = widget.saldo!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cajero Automático'), // Título de la AppBar.
        backgroundColor: Colors.green[400], // Color de fondo de la AppBar.
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // Espacio alrededor del contenido.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centra el contenido.
            children: [
              // Muestra el saldo actual.
              Text(
                'S/.$saldo',
                style: const TextStyle(
                  fontSize: 48, // Tamaño del texto.
                  fontWeight: FontWeight.bold, // Estilo del texto.
                  color: Colors.greenAccent, // Color del texto.
                ),
              ),
              const SizedBox(height: 32), // Espacio antes de la lista de movimientos.
              // Lista de movimientos (depósitos y retiros).
              Expanded(
                child: ListView.builder(
                  itemCount: movimientos.length, // Cantidad de movimientos.
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8), // Espacio entre las tarjetas.
                      elevation: 4, // Sombra de la tarjeta.
                      color: Colors.white, // Color de fondo de la tarjeta.
                      child: ListTile(
                        title: Text(
                          movimientos[index] < 0 ? 'Retiro' : 'Depósito', // Muestra si es retiro o depósito.
                          style: const TextStyle(
                            fontSize: 24, // Tamaño del texto.
                            fontWeight: FontWeight.w600, // Peso del texto.
                          ),
                        ),
                        trailing: Text(
                          '${movimientos[index] < 0 ? movimientos[index] : '+${movimientos[index]}'}', // Muestra la cantidad.
                          style: TextStyle(
                            color: movimientos[index] < 0 ? Colors.red : Colors.green[700], // Color según tipo de movimiento.
                            fontSize: 24, // Tamaño del texto.
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32), // Espacio antes de los botones de acción.
              // Botones para realizar depósitos o retiros.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espacio entre los botones.
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de depósito.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DepositoScreen(
                            movimientos: movimientos,
                            saldo: saldo,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Tamaño del botón.
                      backgroundColor: Colors.green[500], // Color del botón.
                      foregroundColor: Colors.white, // Color del texto del botón.
                    ),
                    child: const Text(
                      'Depósito', // Texto del botón.
                      style: TextStyle(fontSize: 20), // Tamaño del texto.
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de retiro.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RetiroScreen(
                            movimientos: movimientos,
                            saldo: saldo,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Tamaño del botón.
                      backgroundColor: Colors.red[500], // Color del botón.
                      foregroundColor: Colors.white, // Color del texto del botón.
                    ),
                    child: const Text(
                      'Retiro', // Texto del botón.
                      style: TextStyle(fontSize: 20), // Tamaño del texto.
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* Pantalla de Depósito */
class DepositoScreen extends StatefulWidget {
  const DepositoScreen({super.key, required this.movimientos, required this.saldo});
  final List movimientos; // Lista de movimientos que se actualizará.
  final int saldo; // Saldo actual que se actualizará.

  @override
  State<DepositoScreen> createState() => _DepositoScreenState();
}

/* Estado de la pantalla de Depósito */
class _DepositoScreenState extends State<DepositoScreen> {
  final TextEditingController montoDepositoController = TextEditingController(); // Controlador del campo de texto para el depósito.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depósito'), // Título de la AppBar.
        backgroundColor: Colors.green[400], // Color de fondo de la AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido al inicio.
          children: [
            const Text(
              'Ingrese el monto a depositar:', // Texto de instrucción.
              style: TextStyle(fontSize: 18), // Tamaño del texto.
            ),
            const SizedBox(height: 10), // Espacio antes del campo de texto.
            TextField(
              controller: montoDepositoController, // Conecta el campo de texto con el controlador.
              keyboardType: TextInputType.number, // Define el teclado como numérico.
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // Borde del campo de texto.
                hintText: 'Monto en soles', // Texto sugerido dentro del campo de texto.
              ),
            ),
            const SizedBox(height: 20), // Espacio antes del botón de depósito.
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Convierte el texto ingresado en un número y lo suma al saldo.
                  int montoDeposito = int.parse(montoDepositoController.text);
                  widget.movimientos.add(montoDeposito); // Añade el movimiento de depósito.
                  int nuevoSaldo = widget.saldo + montoDeposito; // Actualiza el saldo.

                  // Navega de vuelta a la pantalla del cajero con el nuevo saldo y movimientos.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CajeroScreen(
                        movimientos: widget.movimientos,
                        saldo: nuevoSaldo,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Tamaño del botón.
                  backgroundColor: Colors.green[500], // Color del botón.
                  foregroundColor: Colors.white, // Color del texto del botón.
                ),
                child: const Text(
                  'Depositar', // Texto del botón.
                  style: TextStyle(fontSize: 20), // Tamaño del texto.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Pantalla de Retiro */
class RetiroScreen extends StatefulWidget {
  const RetiroScreen({super.key, required this.movimientos, required this.saldo});
  final List movimientos; // Lista de movimientos que se actualizará.
  final int saldo; // Saldo actual que se actualizará.

  @override
  State<RetiroScreen> createState() => _RetiroScreenState();
}

/* Estado de la pantalla de Retiro */
class _RetiroScreenState extends State<RetiroScreen> {
  final TextEditingController montoRetiroController = TextEditingController(); // Controlador del campo de texto para el retiro.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiro'), // Título de la AppBar.
        backgroundColor: Colors.green[400], // Color de fondo de la AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido al inicio.
          children: [
            const Text(
              'Ingrese el monto a retirar:', // Texto de instrucción.
              style: TextStyle(fontSize: 18), // Tamaño del texto.
            ),
            const SizedBox(height: 10), // Espacio antes del campo de texto.
            TextField(
              controller: montoRetiroController, // Conecta el campo de texto con el controlador.
              keyboardType: TextInputType.number, // Define el teclado como numérico.
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // Borde del campo de texto.
                hintText: 'Monto en soles', // Texto sugerido dentro del campo de texto.
              ),
            ),
            const SizedBox(height: 20), // Espacio antes del botón de retiro.
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Convierte el texto ingresado en un número y lo resta del saldo.
                  int montoRetiro = int.parse(montoRetiroController.text);

                  // Verifica si el saldo es suficiente para realizar el retiro.
                  if (montoRetiro <= widget.saldo) {
                    widget.movimientos.add(-montoRetiro); // Añade el movimiento de retiro.
                    int nuevoSaldo = widget.saldo - montoRetiro; // Actualiza el saldo.

                    // Navega de vuelta a la pantalla del cajero con el nuevo saldo y movimientos.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CajeroScreen(
                          movimientos: widget.movimientos,
                          saldo: nuevoSaldo,
                        ),
                      ),
                    );
                  } else {
                    // Si el saldo no es suficiente, muestra un mensaje de error.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saldo insuficiente para realizar el retiro.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Tamaño del botón.
                  backgroundColor: Colors.red[500], // Color del botón.
                  foregroundColor: Colors.white, // Color del texto del botón.
                ),
                child: const Text(
                  'Retirar', // Texto del botón.
                  style: TextStyle(fontSize: 20), // Tamaño del texto.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

