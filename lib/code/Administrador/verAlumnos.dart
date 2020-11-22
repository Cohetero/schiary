import 'package:flutter/material.dart';

class VerAlumnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: AlumnoList(),
      ),
    );
  }
}

class Alumno {
  String nombre, apellido, escuela;
  Alumno(this.nombre, this.apellido, this.escuela);
}

class AlumnoList extends StatefulWidget {
  @override
  _AlumnoListState createState() => _AlumnoListState();
}

class _AlumnoListState extends State<AlumnoList> {
  List<Alumno> users;

  @override
  void initState() {
    users = [
      Alumno('Carlos', 'Hernandez', 'BUAP'),
      Alumno('Mauricio', 'Cohetero', 'BUAP'),
      Alumno('Raul', 'Olivar', 'UTP'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Se mueve en la lista
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].nombre),
          subtitle: Text(users[index].apellido),
          leading: Icon(Icons.supervised_user_circle),
        );
      },
      itemCount: users.length,
    );
  }
}
