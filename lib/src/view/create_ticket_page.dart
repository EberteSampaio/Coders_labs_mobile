import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTicketPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cadastrar Ticket',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String description = descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ticket cadastrado com sucesso!')),
                );
                titleController.clear();
                descriptionController.clear();
              }
            },
            child: Text('Cadastrar Ticket'),
          ),
        ],
      ),
    );
  }
}