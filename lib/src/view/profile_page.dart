import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/service/AuthService.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Authservice authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    User? user = authservice.dataUser();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.person,
              size: 70,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              user?.displayName ?? 'Usuário Anônimo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? 'Email não disponível',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalhes do Perfil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.person_outline, color: Colors.blue[800]),
                      title: Text('Nome'),
                      subtitle: Text(user?.displayName ?? 'Usuário Anônimo'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email_outlined, color: Colors.blue[800]),
                      title: Text('Email'),
                      subtitle: Text(user?.email ?? 'Email não disponível'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined, color: Colors.blue[800]),
                      title: Text('UID'),
                      subtitle: Text(user?.uid ?? 'UID não disponível'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
