import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMateria extends StatelessWidget {
  static Route<dynamic> route(String nombre, String profesor, int nrc) {
    return MaterialPageRoute(
      builder: (context) =>
          AddMateria(nombre: nombre, profesor: profesor, nrc: nrc),
    );
  }

  final String nombre, profesor;
  final int nrc;
  const AddMateria({
    Key key,
    @required this.nombre,
    @required this.profesor,
    @required this.nrc,
  }) : super(key: key);
  //AddMateria(this.nombre, this.profesor, this.nrc);

  @override
  Widget build(BuildContext context) {
    // Cree una CollectionReference denominada materias que haga referencia a la colección Firestore
    CollectionReference materias = Firestore.instance.collection('Materia');

    Future<void> addMateria() {
      // Llame a CollectionReference de la materia para agregar un nuevo usuario
      return materias
          .document(nombre)
          .setData({
            'Nombre': nombre, // moviles
            'Profesor': profesor, // Sara
            'NRC': nrc // 26449
          })
          .then((value) => print('Materia Agregada'))
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
          onPressed: addMateria,
          child: Text("Si"),
        ),
      ],
    );
  }
}
