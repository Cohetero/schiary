import 'package:flutter/material.dart';

class VerProfesores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesores'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ProfeList(),
      ),
    );
  }
}

class User {
  String fullname, username, photoUrl;
  User(this.fullname, this.username, this.photoUrl);
}

class ProfeList extends StatefulWidget {
  @override
  _ProfeListState createState() => _ProfeListState();
}

class _ProfeListState extends State<ProfeList> {
  List<User> users;

  @override
  void initState() {
    users = [
      User('Carlos', 'Hernandez', ''),
      User('Mauricio', 'Cohetero', ''),
      User('Raul', 'Olivar', ''),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Se mueve en la lista
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].fullname),
          subtitle: Text(users[index].username),
          leading: Icon(Icons.supervised_user_circle),
        );
      },
      itemCount: users.length,
    );
  }
}
