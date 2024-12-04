import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/others/custom_snackbar.dart';
import 'package:flutter_application_1/src/service/AuthService.dart';
import 'package:flutter_application_1/src/service/TicketService.dart';
import 'package:intl/intl.dart';

import '../model/Ticket.dart';

class CreateTicketPage extends StatefulWidget {
  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _newTicketForm = GlobalKey<FormState>();
  final Authservice authservice = Authservice();
  static const String OPEN_STATUS = "Aberto";

  final TicketService service = TicketService();

  List<String> listCategory = [
    "Desenvolvimento",
    "Infraestrutura",
    "Hardware",
    "Sites Externos"
  ];
  List<String> listPriority = [
    "Baixa",
    "Média",
    "Alta",
  ];

  String? selectedCategory;
  String? selectedPriority;

  _saveTicket() {
    if (_newTicketForm.currentState?.validate() ?? false) {
      User? user = authservice.dataUser();
      String title = titleController.text;
      String description = descriptionController.text;
      String categoryValue = selectedCategory!;
      String priorityValue = selectedPriority!;

      Ticket ticket = Ticket(
        title: title,
        description: description,
        category: categoryValue,
        priority: priorityValue,
        status: OPEN_STATUS,
        createdBy: user?.displayName ?? '',
      );

      service.create(ticket).then((error) {
        if (error != null) {
          CustomSnackbar.show(context, error, isSuccess: false);
          return;
        }

        CustomSnackbar.show(
            context, 'Ticket cadastrado com sucesso!', isSuccess: true);


        setState(() {
          titleController.clear();
          descriptionController.clear();
          _newTicketForm.currentState?.reset();
          selectedCategory = null;
          selectedPriority = null;
        });

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Form(
            key: _newTicketForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registrar novo ticket',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value == '') {
                      return "Informe o título do ticket";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição do ticket',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Forneça a descrição do ticket";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Assunto'),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: Text('Selecione uma categoria'),
                  isExpanded: true,
                  items: listCategory.map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Informe a categoria";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Prioridade'),
                DropdownButtonFormField<String>(
                  value: selectedPriority,
                  isExpanded: true,
                  hint: Text('Selecione a prioridade'),
                  items: listPriority.map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedPriority = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Informe a prioridade";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                    ),
                    onPressed: () {
                      if (_newTicketForm.currentState?.validate() ?? false) {
                        _saveTicket();
                      }
                    },
                    child: Text(
                      'Cadastrar Ticket',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
