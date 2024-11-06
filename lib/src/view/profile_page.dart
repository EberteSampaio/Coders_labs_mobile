import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: Colors.blue[600],
          ),
          SizedBox(height: 20),
          Text(
            'Perfil do Usuário',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}