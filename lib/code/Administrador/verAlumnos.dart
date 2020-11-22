import 'package:flutter/material.dart';

class VerAlumnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos'),
      ),
      body: Center(
        child: MaterialButton(
          minWidth: 200.0,
          height: 40.0,
          color: Colors.blueGrey,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Regresar'),
        ),
      ),
    );
  }
}
