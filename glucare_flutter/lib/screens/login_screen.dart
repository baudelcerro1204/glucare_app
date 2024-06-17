import 'package:flutter/material.dart';
import 'package:glucare/main.dart';
import 'package:glucare/screens/register_screen.dart';
import 'package:glucare/services/api_service.dart';

class IniciarSesion extends StatefulWidget {
  final String correoElectronico;

  const IniciarSesion({Key? key, required this.correoElectronico})
      : super(key: key);

  @override
  _IniciarSesionState createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion>
    with SingleTickerProviderStateMixin {
  late TextEditingController _correoElectronicoController;
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService('http://192.168.0.15:8080');

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _correoElectronicoController =
        TextEditingController(text: widget.correoElectronico);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(_animationController);
  }

  @override
  void dispose() {
    _correoElectronicoController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Método para manejar el inicio de sesión
  void _login(BuildContext context) async {
    final String correoElectronico = _correoElectronicoController.text;
    final String password = _passwordController.text;

    if (correoElectronico.isEmpty || password.isEmpty) {
      // Mostrar mensaje de error si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    try {
      await apiService.login(correoElectronico, password);
      // Mostrar mensaje de éxito y navegar a la pantalla principal
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      print(e);
      // Mostrar mensaje de error en el inicio de sesión
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email o contraseña incorrectos')),
      );
    }
  }

  // Método para manejar el olvido de contraseña
  void _forgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad de recuperar contraseña')),
    );
  }

  // Método para navegar a la pantalla de registro
  void _goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearCuenta()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC0DEF4),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'lib/assets/glucare_removeBG.png',
                  height: 200,   // Ajusta el tamaño según sea necesario
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _animation,
                  child: Image.asset(
                    'lib/assets/glucare_panda_saludando.png',
                    fit: BoxFit.cover,
                    height: 200, // Ajusta el tamaño según sea necesario
                    width: 200, // Ajusta el tamaño según sea necesario
                  ),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: child,
                    );
                  },
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _correoElectronicoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Contraseña',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _login(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _forgotPassword(context);
                      },
                      child: const Text('Olvidé mi contraseña'),
                    ),
                    TextButton(
                      onPressed: () {
                        _goToRegister(context); // Ir a la pantalla de registro
                      },
                      child: const Text('Registrarse'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
