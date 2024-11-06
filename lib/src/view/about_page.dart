import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Versão do App: 1.0.0',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text('Política de Privacidade'),
          ),
          TextButton(
            onPressed: () {  },
            child: Text('Termos de Uso'),
          ),
          TextButton(
            onPressed: () {  },
            child: Text('Contato de Suporte'),
          ),
        ],
      ),
    );
  }
}