import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAlumno extends StatelessWidget {
  static Route<dynamic> route(String nombre, String apellidos, String email,
      String password, String nivel, int matricula) {
    return MaterialPageRoute(
      builder: (context) => AddAlumno(
          nombre: nombre,
          apellidos: apellidos,
          email: email,
          password: password,
          nivel: nivel,
          matricula: matricula),
    );
  }

  final String nombre, apellidos, email, password, nivel;
  final int matricula;
  const AddAlumno(
      {Key key,
      @required this.nombre,
      @required this.apellidos,
      @required this.email,
      @required this.password,
      @required this.nivel,
      @required this.matricula})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cree una CollectionReference denominada materias que haga referencia a la colección Firestore
    CollectionReference alumno = Firestore.instance.collection('User');

    Future<void> addAlumno() {
      // Llame a CollectionReference de la materia para agregar un nuevo usuario
      return alumno
          .document(email)
          .setData({
            'Nombre': nombre, // moviles
            'Apellidos': apellidos, // Sara
            'Correo': email,
            'Password': password,
            'Nivel': nivel,
            'Matricula': matricula
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
