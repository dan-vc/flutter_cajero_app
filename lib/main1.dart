import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cajero Automático Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/* Pantalla de Login */
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/* Pantalla de Login - State */
class _LoginScreenState extends State<LoginScreen> {
  /* Controladores del usuario y de la contraseña */
  final TextEditingController usuario = TextEditingController();
  final TextEditingController contrasena = TextEditingController();

  void logearse() {
    String username = usuario.text;
    String password = contrasena.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa ambos campos.')),
      );
    } else if (username != 'senati' || password != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Nombre de usuario o contraseña incorrectos.')),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CajeroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            TextField(
              controller: usuario,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            TextField(
              controller: contrasena,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: logearse,
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

/* Pantalla de Cajero */
class CajeroScreen extends StatefulWidget {
  /* Definición de parametros que recibe el Cajero */
  const CajeroScreen({super.key, this.movimientos, this.saldo});
  final List? movimientos;
  final int? saldo;

  @override
  State<CajeroScreen> createState() => _CajeroScreenState();
}

/* Pantalla de Cajero - State */
class _CajeroScreenState extends State<CajeroScreen> {
  /* Valores iniciales de movimientos y saldo */
  List movimientos = [500, -200];
  int saldo = 1000;

  @override
  Widget build(BuildContext context) {
    /* Si existe el parametro de movimientos */
    if (widget.movimientos != null) {
      /* El valor local se actualiza */
      movimientos = widget.movimientos!;
    }
    /* Si existe el parametro de saldo */
    if (widget.saldo != null) {
      /* El valor local se actualiza */
      saldo = widget.saldo!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cajero Automatico con Flutter'),
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Saldo
              Text(
                'S/.$saldo', // Mostramos el valor del saldo
                style: const TextStyle(
                  fontSize: 100,
                ),
              ),
              const SizedBox(height: 64),
              // Movimientos
              Column(
                children: [
                  /* Iteramos los movimientos */
                  for (int i = 0; i < movimientos.length; i++)
                    /* Instanciamos un Row por cada movimiento */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          /* Dependiendo del valor mostramos 'Retiro' o 'Deposito' */
                          movimientos[i] < 0 ? 'Retiro' : 'Deposito',
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          /* Dependiendo del valor formateamos el texto */
                          '${movimientos[i] < 0 ? movimientos[i] : '+${movimientos[i]}'}',
                          style: TextStyle(
                            color:
                                /* Dependiendo del valor cambiamos el color */
                                movimientos[i] < 0 ? Colors.red : Colors.green,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    )
                ],
              ),
              const SizedBox(height: 64),
              // Formulario
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        /* Al presionar el boton */
                        onPressed: () {
                          /* Navegamos a otra pantalla */
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepositoScreen(
                                /* Enviamos los movimientos y saldo */
                                movimientos: movimientos,
                                saldo: saldo,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Depositar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        /* Al presionar el boton */
                        onPressed: () {
                          /* Navegamos a otra pantalla */
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RetiroScreen(
                                /* Enviamos los movimientos y saldo */
                                movimientos: movimientos,
                                saldo: saldo,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Retirar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/* Pantalla de Deposito */
class DepositoScreen extends StatefulWidget {
  /* Definición de parametros que recibe la clase */
  const DepositoScreen(
      {super.key, required this.movimientos, required this.saldo});
  final List movimientos;
  final int saldo;

  @override
  State<DepositoScreen> createState() => _DepositoScreenState();
}

/* Pantalla de Deposito - State */
class _DepositoScreenState extends State<DepositoScreen> {
  final TextEditingController monto = TextEditingController();

  /* Funcion depositar segun el monto */
  void depositar() {
    /* Obtenemos el monto del input */
    int? data = int.tryParse(monto.text);

    /* Si el monto no es nulo */
    if (data != null) {
      /* Agregamos el monto al saldo actualizado */
      int updatedSaldo = widget.saldo + data;
      /* Agregamos la accion a los movimientos actualizados */
      List updatedMovimientos = [...widget.movimientos, data];
      /* Navegamos de vuelta a la pantalla Cajero */
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CajeroScreen(
            /* Enviamos los nuevos valores */
            movimientos: updatedMovimientos,
            saldo: updatedSaldo,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depositar'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 100,
          right: 100,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'S/.',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.green[200],
                    ),
                  ),
                  Text(
                    /* Mostramos 0 si el monto está vacio, sino mostramos el monto */
                    monto.text.isEmpty ? '0' : monto.text,
                    style: const TextStyle(
                      fontSize: 100,
                      color: Colors.green,
                      height: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              TextFormField(
                controller: monto,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    hintText: 'Ingrese el monto a depositar'),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                /* Al presionar el boton invocamos la función */
                onPressed: depositar,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                child: const Text(
                  'Depositar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/* Pantalla de Retiro */
class RetiroScreen extends StatefulWidget {
  const RetiroScreen(
      {super.key, required this.movimientos, required this.saldo});
  final List movimientos;
  final int saldo;

  @override
  State<RetiroScreen> createState() => _RetiroScreenState();
}

/* Pantalla de Retiro - State */
class _RetiroScreenState extends State<RetiroScreen> {
  final TextEditingController monto = TextEditingController();

  void retirar() {
    int? data = int.tryParse(monto.text);
    if (data != null) {
      int updatedSaldo = widget.saldo - data;
      List updatedMovimientos = [...widget.movimientos, -data];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CajeroScreen(
            movimientos: updatedMovimientos,
            saldo: updatedSaldo,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retirar'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 100,
          right: 100,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'S/.',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.red[200],
                    ),
                  ),
                  Text(
                    monto.text.isEmpty ? '0' : monto.text,
                    style: const TextStyle(
                      fontSize: 100,
                      color: Colors.red,
                      height: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              TextFormField(
                controller: monto,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    hintText: 'Ingrese el monto a retirar'),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: retirar,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                child: const Text(
                  'Retirar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
