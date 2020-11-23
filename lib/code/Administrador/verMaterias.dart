import 'package:flutter/material.dart';
import 'package:schiary/code/Administrador/addMateria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:schiary/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class VerMaterias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Icon(Icons.bookmarks)),
              Tab(child: Icon(Icons.book)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Materias(),
            AgregarMaterias(),
          ],
        ),
      ),
    );
  }
}

//////////////////////////// Lista de Materias ///////////////////////////////
class Materias extends StatefulWidget {
  @override
  _MateriasState createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
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
          title: Text(record.nombre),
          trailing: Text(record.nrc.toString()),
          subtitle: Text(record.profesor),
        ),
      ),
    );
  }
}

class Record {
  final String nombre, profesor;
  final int nrc;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Nombre'] != null), //En los corchetes van los campos
        assert(map['Profesor'] != null),
        assert(map['NRC'] != null),
        nombre = map['Nombre'],
        profesor = map['Profesor'],
        nrc = map['NRC'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nombre:$nrc:$profesor>";
}

//////////////////////////// Agregar Materias ///////////////////////////////
class AgregarMaterias extends StatefulWidget {
  @override
  _AgregarMateriasState createState() => _AgregarMateriasState();
}

class _AgregarMateriasState extends State<AgregarMaterias> {
  GlobalKey<FormState> _key = GlobalKey();
  String _nombre, _profesor;
  int _nrc;
  bool _agregar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _agregar
          ? AddMateria(nombre: _nombre, profesor: _profesor, nrc: _nrc)
          : agregarForm(),
      //body: loginForm(),
    );
  }

  //////////////////////////////--MATERIAS--/////////////////////////////
  Widget _buildNombreTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Materia',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (text) {
              if (text.length == 0) {
                return 'Este campo es requerido';
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.book,
                color: Colors.white,
              ),
              hintText: 'Ingresa la Materia',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _nombre = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--DOCENTES--/////////////////////////////
  Widget _buildDocenteTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Docentes',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (text) {
              if (text.length == 0) {
                return 'Este campo es requerido';
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Nombre del Docente',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _profesor = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--NRC--/////////////////////////////
  Widget _buildNrcTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'NRC',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            validator: (text) {
              if (text.length == 0) {
                return 'Este campo es requerido';
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.dialpad,
                color: Colors.white,
              ),
              hintText: 'Inserta el NRC',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _nrc = int.parse(text),
          ),
        ),
      ],
    );
  }

  //////////////////////////////--AGREGAR BOTON--/////////////////////////////
  Widget _buildAgregarBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            //Aqui se llamaria a su API para hacer el login
            setState(() {
              _agregar = true;
            });
            //mensaje = 'Bienvenido \n $_user';
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue,
        child: Text(
          'Agregar Materia',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget agregarForm() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Agregar Materia',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          _buildNombreTFF(),
                          SizedBox(height: 30.0),
                          _buildDocenteTFF(),
                          SizedBox(height: 30.0),
                          _buildNrcTFF(),
                          SizedBox(height: 15.0),
                          _buildAgregarBtn(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
