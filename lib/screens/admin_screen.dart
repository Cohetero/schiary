import 'package:flutter/material.dart';
import 'package:schiary/code/Administrador/informacion.dart';
import 'package:schiary/code/Administrador/verAlumnos.dart';
import 'package:schiary/code/Administrador/verMaterias.dart';
import 'package:schiary/code/Administrador/verProfesores.dart';
import 'package:schiary/screens/login_screen.dart';

class Admin extends StatelessWidget {
  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => Admin(mensaje: mensaje),
    );
  }

  final String mensaje;
  const Admin({Key key, @required this.mensaje}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                Text(
                  "COBAEP Plantel 1",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 200.0,
                  height: 40.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerMaterias()),
                    );
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Ver Materias',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 200.0,
                  height: 40.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerProfesores()),
                    );
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Ver Profesores',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 200.0,
                  height: 40.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerInformacion(nombre: 'BUAP')),
                    );
                  },
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Informacion General',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 200.0,
                  height: 40.0,
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
                      'Ver Alumnos',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 60),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  minWidth: 300.0,
                  height: 40.0,
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Administrar Escuela',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
