import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      /*body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        this.nombre,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Buscar(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),*/
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
        child: ListTile(
          title: Text(record.director),
          trailing: Text(record.clave),
          subtitle: Text(record.direccion),
          leading: Icon(Icons.account_box),
        ),
      ),
    );
  }
}

class Record {
  final String clave, direccion, director, nombre;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Clave'] != null), //En los corchetes van los campos
        assert(map['Direccion'] != null),
        assert(map['Director'] != null),
        assert(map['Nombre'] != null),
        clave = map['Clave'],
        direccion = map['Direccion'],
        director = map['Director'],
        nombre = map['Nombre'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$clave:$direccion:$director:$nombre>";
}
