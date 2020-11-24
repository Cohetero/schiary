import 'package:flutter/material.dart';
import 'package:schiary/code/Administrador/addAlumno.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:schiary/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class VerAlumnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Icon(Icons.group)),
              Tab(child: Icon(Icons.person_add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Alumnos(),
            AgregarAlumno(),
          ],
        ),
      ),
    );
  }
}

//////////////////////////// Lista de Alumnos ///////////////////////////////
class Alumnos extends StatefulWidget {
  @override
  _AlumnosState createState() => _AlumnosState();
}

class _AlumnosState extends State<Alumnos> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Alumno').snapshots(),
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
          trailing: Text(record.escuela.toString()),
          subtitle: Text(record.apellidos),
          leading: Icon(Icons.account_circle),
        ),
      ),
    );
  }
}

class Record {
  final String nombre, apellidos, escuela;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Nombre'] != null), //En los corchetes van los campos
        assert(map['Apellidos'] != null),
        assert(map['Escuela'] != null),
        nombre = map['Nombre'],
        apellidos = map['Apellidos'],
        escuela = map['Escuela'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nombre:$apellidos:$escuela>";
}

//////////////////////////// Agregar Alumno ///////////////////////////////
class AgregarAlumno extends StatefulWidget {
  @override
  _AgregarAlumnoState createState() => _AgregarAlumnoState();
}

class _AgregarAlumnoState extends State<AgregarAlumno> {
  GlobalKey<FormState> _key = GlobalKey();
  String _nombre, _apellidos, _email, _password;
  int _matricula;
  bool _agregar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _agregar
          ? AddAlumno(
              nombre: _nombre,
              apellidos: _apellidos,
              email: _email,
              password: _password,
              nivel: 'Alumno',
              matricula: _matricula,
            )
          : agregarForm(),
      //body: agregarForm(),
    );
  }

  //////////////////////////////--ALUMNO--/////////////////////////////
  Widget _buildNombreTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre',
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
              hintText: 'Ingrese el Nombre',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _nombre = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--APELLIDOS--/////////////////////////////
  Widget _buildApellidosTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Apellidos',
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
                Icons.face,
                color: Colors.white,
              ),
              hintText: 'Ingrese sus Apellidos',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _apellidos = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--EMAIL--/////////////////////////////
  Widget _buildEmailTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Correo',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
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
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Ingrese el correo',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _email = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--PASSWORD--/////////////////////////////
  Widget _buildPasswordTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
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
                Icons.remove_red_eye,
                color: Colors.white,
              ),
              hintText: '*****',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _password = text,
          ),
        ),
      ],
    );
  }

  //////////////////////////////--MATRICULA--/////////////////////////////
  Widget _buildMatriculaTFF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Matricula',
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
                Icons.grain,
                color: Colors.white,
              ),
              hintText: 'Introduzca la matricula',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _matricula = int.parse(text),
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
          'Agregar Alumno',
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
                  vertical: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Agregar Alumno',
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
                          _buildApellidosTFF(),
                          SizedBox(height: 30.0),
                          _buildEmailTFF(),
                          SizedBox(height: 30.0),
                          _buildPasswordTFF(),
                          SizedBox(height: 30.0),
                          _buildMatriculaTFF(),
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
