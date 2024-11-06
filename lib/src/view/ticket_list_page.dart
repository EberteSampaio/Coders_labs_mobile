
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/view/ticket_detail_page.dart';

class TicketListPage extends StatelessWidget {
  final List<Map<String, String>> tickets = [
    {
      'title': 'Problema com o login',
      'description': 'Não consigo acessar o sistema.'
    },
    {
      'title': 'Erro na tela de relatórios',
      'description': 'A tela de relatórios não carrega os dados corretamente.'
    },
    {
      'title': 'Solicitação de novo acesso',
      'description': 'Preciso de acesso ao sistema de vendas.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tickets[index]['title']!),
          subtitle: Text(tickets[index]['description']!),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketDetailPage(ticket: tickets[index]),
              ),
            );
          },
        );
      },
    );
  }
}
