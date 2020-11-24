import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schiary/utilities/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schiary/screens/admin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schiary/screens/alumno_screen.dart';
import 'package:schiary/screens/profe_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final databaseReference = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  String paspor;
  GlobalKey<FormState> _key = GlobalKey();
  String mensaje = "";
  String _usuario;
  bool _logueado = false;

  GoogleSignIn _googleSignIn = new GoogleSignIn();
////////////////////////////////////////////control facebook logica
  Future<void> _loginWithFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();
      print(
        accessToken.toJson(),
      );
      final userData = await FacebookAuth.instance.getUserData(fields: 'email');
      print(userData);
      buscacorreo('hola');
    } catch (e, s) {
      print(s);
      if (e is FacebookAuthException) {
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("FacebookAuthErrorCode.OPERATION_IN_PROGRESS");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("FacebookAuthErrorCode.CANCELLED");
            break;
          case FacebookAuthErrorCode.FAILED:
            print("FacebookAuthErrorCode.FAILED");
            break;
        }
      }
    }
  }

///////////////////////////////////////////////////////logica google
  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
    });

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String pasacorreo;
    print('este es uid:');
    pasacorreo = user.email;
    print(pasacorreo);
    buscacorreo(pasacorreo);
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = true;
      });
    });
  }

//////////////////////termina/////////////////////
  Widget _build() {
    print('entre');
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

////////////////////////////////////////////manda a pantallas////
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    String tiponivel;
    String nombreusuario;
    tiponivel = record.niveluser;
    nombreusuario = record.nombre;
    print(tiponivel);

    if (tiponivel == 'Administrador') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Admin(mensaje: nombreusuario)),
      );
    }
    if (tiponivel == 'Profesor') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfeScreen(mensaje: nombreusuario)),
      );
    }
    if (tiponivel == 'Alumno') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AlumnoScreen(mensaje: nombreusuario)),
      );
    }

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
        ),
      ),
    );
  }

  ///
  ///
  void buscacorreo(String email) {
    print(email);

    databaseReference
        .collection('User')
        .document(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _build();
        _buildListItem(context, documentSnapshot);
      } else {
        print('no existe el correo');
      }
    });
  }

///////////////////////////////////////////////////////////77
  TextEditingController emailController = new TextEditingController();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //controller: emailController,
            keyboardType: TextInputType.emailAddress,
            /*validator: (text) {
              if (text.length == 0) {
                return 'Este campo es requerido';
              }
              return null;
            },*/
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
              hintText: 'Ingresa tu Email',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => _usuario = text,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '¿Haz olvidado tu contraseña?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
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
            obscureText: true,
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
              hintText: '*************',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (text) => paspor = text,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        //key: key,

        //onPressed: () => buscacorreo(_user),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Admin(mensaje: 'hola')),
          );
        },
        /*if (_key.currentState.validate()) {
            _key.currentState.save();
            //Aqui se llamara la API para hacer el login
            setState(() {
              _logueado = true;
            });
            mensaje = 'Bienvenido \n $_usuario';
          }*/
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue,
        child: Text(
          'Iniciar Sesión',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- O -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Inicia sesión con',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            _loginWithFacebook,
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            handleSignIn,
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '¿Todavia no tienes cuenta? ',
              style: TextStyle(
                color: Colors.white12,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Crea una',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logueado ? Admin(mensaje: mensaje) : loginForm(context),
    );
  }

  Widget loginForm(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF000000),
                    Color(0xFF000000),
                    Color(0xFF000000),
                    Color(0xFF000000),
                  ],
                ),
              ),
            ),
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
                      'Bienvenido a Schiary',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    _buildEmailTF(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _buildPasswordTF(),
                    _buildForgotPasswordBtn(),
                    _buildLoginBtn(),
                    _buildSignInWithText(),
                    _buildSocialBtnRow(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Record {
  final databaseReference = Firestore.instance;
  final String nombre, apellidos, correo, password, niveluser;
  final int matricula;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Nombre'] != null), //En los corchetes van los campos
        assert(map['Apellidos'] != null),
        assert(map['Correo'] != null),
        assert(map['Password'] != null),
        assert(map['Nivel'] != null),
        assert(map['Matricula'] != null),
        nombre = map['Nombre'],
        apellidos = map['Apellidos'],
        correo = map['Correo'],
        password = map['Password'],
        niveluser = map['Nivel'],
        matricula = map['Matricula'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() =>
      "Record<$nombre:$apellidos:$correo:$password:$niveluser:$matricula>";
}
