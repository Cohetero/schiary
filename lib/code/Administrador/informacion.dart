import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:schiary/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class VerInformacion extends StatelessWidget {
  static Route<dynamic> route(String nombre) {
    return MaterialPageRoute(
      builder: (context) => VerInformacion(nombre: nombre),
    );
  }

  final String nombre;
  const VerInformacion({
    Key key,
    @required this.nombre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información General'),
      ),
      body: Buscar(),
    );
  }
}

class Buscar extends StatefulWidget {
  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Escuela')
          .snapshots(), //Se llama la coleccion
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildBuscar(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildBuscar(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children:
          snapshot.map((data) => _buildBuscarItem(context, data)).toList(),
    );
  }

  Widget _buildBuscarItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
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
            Texto(cadena: 'Directora:', size: 20.0, color: Colors.greenAccent),
            Texto(cadena: record.directora, size: 25.0, color: Colors.white),
            SizedBox(height: 20.0),
            Texto(cadena: 'Direccion:', size: 20.0, color: Colors.greenAccent),
            Texto(cadena: record.direccion, size: 25.0, color: Colors.white),
            SizedBox(height: 20.0),
            Texto(cadena: 'Clave:', size: 20.0, color: Colors.greenAccent),
            Texto(cadena: record.clave, size: 25.0, color: Colors.white),
            SizedBox(height: 20.0),
            Texto(
                cadena: 'Año de Fudacion:',
                size: 20.0,
                color: Colors.greenAccent),
            Texto(
                cadena: record.fundacion.toString(),
                size: 25.0,
                color: Colors.white),
          ],
        ),
      ),
    );
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
  final String clave, direccion, directora, nombre;
  final int fundacion;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Clave'] != null), //En los corchetes van los campos
        assert(map['Direccion'] != null),
        assert(map['Directora'] != null),
        assert(map['Fundacion'] != null),
        assert(map['Nombre'] != null),
        clave = map['Clave'],
        direccion = map['Direccion'],
        directora = map['Directora'],
        fundacion = map['Fundacion'],
        nombre = map['Nombre'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() =>
      "Record<$clave:$direccion:$directora:$nombre:$fundacion>";
}
