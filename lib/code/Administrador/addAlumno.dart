import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAlumno extends StatelessWidget {
  static Route<dynamic> route(
    String nombre,
    String apellidos,
    String escuela,
  ) {
    return MaterialPageRoute(
      builder: (context) => AddAlumno(
        nombre: nombre,
        apellidos: apellidos,
        escuela: escuela,
      ),
    );
  }

  final String nombre, apellidos, escuela;
  const AddAlumno(
      {Key key,
      @required this.nombre,
      @required this.apellidos,
      @required this.escuela})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cree una CollectionReference denominada materias que haga referencia a la colección Firestore
    CollectionReference alumno = Firestore.instance.collection('Alumno');

    Future<void> addAlumno() {
      // Llame a CollectionReference de la materia para agregar un nuevo usuario
      return alumno
          .add({
            'Nombre': nombre, // moviles
            'Apellidos': apellidos, // Sara
            'Escuela': escuela
          })
          .then((value) => print('Alumno Agregado'))
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
