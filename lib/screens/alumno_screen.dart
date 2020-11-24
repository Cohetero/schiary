import 'package:flutter/material.dart';

class AlumnoScreen extends StatelessWidget {
  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => AlumnoScreen(mensaje: mensaje),
    );
  }

  final String mensaje;
  const AlumnoScreen({Key key, @required this.mensaje}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: MaterialButton(
          minWidth: 200.0,
          height: 40.0,
          color: Colors.blueGrey,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('AlumnoRegresar'),
        ),
      ),
    );
  }
}
