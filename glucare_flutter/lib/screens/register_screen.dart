import 'package:flutter/material.dart';
import 'package:glucare/screens/login_screen.dart';
import 'package:glucare/services/api_service.dart';
import 'package:glucare/widgets/custom_appbar.dart';

class CrearCuenta extends StatefulWidget {
  const CrearCuenta({super.key});

  @override
  _CrearCuentaState createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoElectronicoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  String _selectedDiabetesType = '1';


  final ApiService apiService = ApiService('http://192.168.0.15:8080');
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _nombreController.addListener(_checkFields);
    _correoElectronicoController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
    _confirmPasswordController.addListener(_checkFields);
    _edadController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _isButtonDisabled = _nombreController.text.isEmpty ||
                          _correoElectronicoController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty ||
                          _edadController.text.isEmpty;
    });
  }

  void _registerUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final userData = {
      'nombre': _nombreController.text,
      'correoElectronico': _correoElectronicoController.text,
      'password': _passwordController.text,
      'edad': int.tryParse(_edadController.text) ?? 0,
      'diabetesTipo': _selectedDiabetesType,
    };

    try {
      await apiService.registerUser(userData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IniciarSesion(correoElectronico: _correoElectronicoController.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: Color(0xFFC0DEF4),
        automaticallyImplyLeading: true, // Habilita la flecha de retroceso
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Color(0xFFC0DEF4),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _correoElectronicoController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Re ingrese contraseña',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _edadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedDiabetesType,
                  items: <String>['1', '2', '0']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDiabetesType = newValue!;
                      _checkFields();
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Diabetes',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: _isButtonDisabled ? null : _registerUser,
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
