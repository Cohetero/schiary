import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProfesor extends StatelessWidget {
  static Route<dynamic> route(String nombre, String apellidos, String escuela) {
    return MaterialPageRoute(
      builder: (context) =>
          AddProfesor(nombre: nombre, apellidos: apellidos, escuela: escuela),
    );
  }

  final String nombre, apellidos, escuela;
  const AddProfesor({
    Key key,
    @required this.nombre,
    @required this.apellidos,
    @required this.escuela,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cree una CollectionReference denominada materias que haga referencia a la colección Firestore
    CollectionReference materias = Firestore.instance.collection('Profesor');

    Future<void> addAlumno() {
      // Llame a CollectionReference de la materia para agregar un nuevo usuario
      return materias
          .add({
            'Nombre': nombre, // moviles
            'Apellidos': apellidos, // Sara
            'Escuela': escuela
          })
          .then((value) => print('Profesor Agregado'))
          .catchError((error) => print('No se pudo agregar: $error'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Seguro que quiere agregar?',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        RaisedButton(
          onPressed: addAlumno,
          child: Text("Si"),
        ),
      ],
    );
  }
}
