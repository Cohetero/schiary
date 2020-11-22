import 'package:flutter/material.dart';
import 'package:schiary/code/Administrador/agregarMateria.dart';

class VerMaterias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materias'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        //childAspectRatio: 4 / 3,
        children: <Widget>[
          Muestra(
            child: RaisedButton(
              onPressed: () {},
              child: Text('Programación'),
              shape: StadiumBorder(),
            ),
            text: "Esta materia bla bla bla :3",
          ),
          Muestra(
            child: RaisedButton(
              onPressed: () {},
              child: Text('Materia 2'),
              shape: StadiumBorder(),
            ),
            text: "Esta materia bla bla bla :3",
          ),
          Muestra(
            child: OutlineButton(
              onPressed: () {},
              child: Text('Materia 3'),
              shape: StadiumBorder(),
            ),
            text: "Esta materia bla bla bla :3",
          ),
          Muestra(
            child: OutlineButton.icon(
              icon: Icon(Icons.add_circle),
              label: Text('NuevaMateria'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgregarMateria()),
                );
              },
              shape: StadiumBorder(),
              highlightColor: Colors.blue[100],
            ),
            text: "Agregar una nueva materia",
          ),
          Muestra(
            child: BackButton(),
            text: 'Regresar',
          ),
        ],
      ),
    );
  }
}

class Muestra extends StatelessWidget {
  final Widget child;
  final String text;

  const Muestra({
    Key key,
    @required this.child,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              this.child,
              SizedBox(height: 10),
              Text(this.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.0)),
            ],
          ),
        ),
      ),
    );
  }
}
