import 'package:flutter/material.dart';
import 'package:schiary/code/Profesor/informacion.dart';
import 'package:schiary/code/Profesor/verAlumnos.dart';
import 'package:schiary/code/Profesor/verMaterias.dart';
import 'package:schiary/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';

class AdminProfe extends StatelessWidget {
  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => AdminProfe(mensaje: mensaje),
    );
  }

  final String mensaje;
  const AdminProfe({Key key, @required this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schiary'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    body: LoginScreen(),
                  );
                }),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 70.0),
                Text(
                  "BIENVENIDO SCHIARY",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70.0),
                Text(
                  "Hola Profesor ",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  mensaje,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  "ESCUELA: BUAP",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 200.0),
                MaterialButton(
                  minWidth: 200.0,
                  height: 60.0,
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerMaterias(mensaje: mensaje)),
                    );
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Ver materias',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100.0),
                MaterialButton(
                  minWidth: 200.0,
                  height: 60.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerAlumnos()),
                    );
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Ver alumnos',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
