import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlumnoScreen extends StatelessWidget {
  static Route<dynamic> route(String mensaje, int matricula) {
    return MaterialPageRoute(
      builder: (context) =>
          AlumnoScreen(mensaje: mensaje, matricula: matricula),
    );
  }

  final String mensaje;
  final int matricula;
  const AlumnoScreen(
      {Key key, @required this.mensaje, @required this.matricula})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Icon(Icons.bookmarks)),
              Tab(child: Icon(Icons.account_circle)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VerMaterias(matricula),
            VerInformacion(mensaje),
          ],
        ),
      ),
    );
  }
}

//----------------VER MATERIAS------------------------
class VerMaterias extends StatelessWidget {
  final int documentId;

  VerMaterias(this.documentId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Materia')
          .snapshots(), //Se llama la coleccion
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final materia = Materias.fromSnapshot(data);

    if (documentId == materia.matricula) {
      return Padding(
        key: ValueKey(materia.nombre),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Text(materia.nombre),
            trailing: Text(materia.nrc.toString()),
            subtitle: Text(materia.profesor),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class Materias {
  final String nombre, profesor;
  final int matricula, nrc;
  final DocumentReference reference;

  Materias.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Nombre'] != null), //En los corchetes van los campos
        assert(map['Profesor'] != null),
        assert(map['Matricula'] != null),
        assert(map['NRC'] != null),
        nombre = map['Nombre'],
        profesor = map['Profesor'],
        matricula = map['Matricula'],
        nrc = map['NRC'];

  Materias.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nombre:$profesor:$matricula:$nrc>";
}

//----------------VER INFORMACION------------------------
class VerInformacion extends StatelessWidget {
  final String documentId;

  VerInformacion(this.documentId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('User')
          .snapshots(), //Se llama la coleccion
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    if (documentId == record.correo) {
      print(documentId);
      print(record.nombre);
      print(record.apellidos);
      return Padding(
        key: ValueKey(record.nombre),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: <Widget>[
              Texto(cadena: 'Nombre:', size: 20.0, color: Colors.greenAccent),
              Texto(cadena: record.nombre, size: 25.0, color: Colors.white),
              SizedBox(height: 20.0),
              Texto(
                  cadena: 'Apellidos:', size: 20.0, color: Colors.greenAccent),
              Texto(cadena: record.apellidos, size: 25.0, color: Colors.white),
              SizedBox(height: 20.0),
              Texto(cadena: 'Correo:', size: 20.0, color: Colors.greenAccent),
              Texto(cadena: record.correo, size: 25.0, color: Colors.white),
              SizedBox(height: 20.0),
              Texto(
                  cadena: 'Matricula:', size: 20.0, color: Colors.greenAccent),
              Texto(
                  cadena: record.matricula.toString(),
                  size: 25.0,
                  color: Colors.white),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(),
      );
    }
  }
}

class Texto extends StatelessWidget {
  final String cadena;
  final double size;
  final Color color;

  const Texto({
    Key key,
    @required this.cadena,
    @required this.size,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.cadena,
      style: TextStyle(
        color: this.color,
        fontFamily: 'OpenSans',
        fontSize: this.size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Record {
  final String nombre, apellidos, correo;
  final int matricula;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Nombre'] != null), //En los corchetes van los campos
        assert(map['Apellidos'] != null),
        assert(map['Correo'] != null),
        assert(map['Matricula'] != null),
        nombre = map['Nombre'],
        apellidos = map['Apellidos'],
        correo = map['Correo'],
        matricula = map['Matricula'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nombre:$apellidos:$correo:$matricula>";
}
