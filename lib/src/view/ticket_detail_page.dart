import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/src/others/custom_snackbar.dart';
import 'package:flutter_application_1/src/service/AuthService.dart';
import 'package:flutter_application_1/src/service/TicketService.dart';
import 'package:flutter_application_1/src/view/home_page.dart';
import 'package:flutter_application_1/src/view/ticket_list_page.dart';
import '../model/Ticket.dart';
import '../model/TicketFollowup.dart';
import '../service/TicketFollowupService.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket ticket;

  const TicketDetailPage({super.key, required this.ticket});

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  final TextEditingController _followupController = TextEditingController();
  final TicketFollowupService ticketFollowupService = TicketFollowupService();
  final TicketService ticketService = TicketService();
  final Authservice authservice = Authservice();
  final _FUForm = GlobalKey<FormState>();

  List<String> listPriority = [
    "Baixa",
    "Média",
    "Alta",
  ];

  String? selectedPriority;

  @override
  void dispose() {
    _followupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    Stream<QuerySnapshot<Object?>> followupStream =
        ticketFollowupService.getTicketFUStream(ticket.id!);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Ticket',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Informações do Ticket'),
            _buildInfoCard([
              _buildTicketInfo('Título', ticket.title),
              _buildTicketInfo('Prioridade', ticket.priority),
              _buildTicketInfo('Status', ticket.status),
              _buildTicketInfo('Categoria', ticket.category),
              _buildTicketInfo('Criado por', ticket.createdBy),
            ]),
            const SizedBox(height: 20),
            _buildSectionTitle('Descrição'),
            _buildDescriptionCard(ticket.description),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  onPressed: () async {
                    await ticketService.delete(ticket.id ?? '').then((value) {
                      CustomSnackbar.show(
                          context, "Ticket fechado com sucesso!",
                          isSuccess: true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    });
                  },
                  label: Text(
                    'Deletar Chamado',
                    style: TextStyle(
                        color: Colors.white, backgroundColor: Colors.red),
                  )),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: () async {
                  final _titleController =
                      TextEditingController(text: widget.ticket.title);
                  final _priorityController =
                      TextEditingController(text: widget.ticket.priority);

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Editar Ticket'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: _titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Título'),
                              ),
                              const SizedBox(height: 10),
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
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_titleController.text.isEmpty ||
                                  _priorityController.text.isEmpty) {
                                CustomSnackbar.show(
                                  context,
                                  'Preencha todos os campos!',
                                  isSuccess: false,
                                );
                                return;
                              }

                              try {
                                ticket.title = _titleController.text;
                                ticket.priority = selectedPriority!;

                                await ticketService.update(ticket);

                                CustomSnackbar.show(
                                  context,
                                  'Ticket atualizado com sucesso!',
                                  isSuccess: true,
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                CustomSnackbar.show(
                                  context,
                                  'Erro ao atualizar ticket: $e',
                                  isSuccess: false,
                                );
                              }
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                  setState(() {});
                },
                label: Text('Alterar dados',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  label: Text(
                    'Voltar',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Adicionar Comentário'),
            _buildFollowupForm(ticket.id),
            const SizedBox(height: 20),
            _buildSectionTitle('Comentários'),
            _buildFollowups(ticket.id!),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: const TextStyle(fontSize: 18, height: 1.6),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _buildFollowupForm(String? ticketId) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _FUForm,
          child: Column(
            children: [
              TextFormField(
                controller: _followupController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Digite seu comentário',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value == '') {
                    return "Forneça o comentário";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_FUForm.currentState?.validate() ?? false) {
                    User? user = authservice.dataUser();

                    TicketFollowup ticketFU = TicketFollowup(
                      ticketId: ticketId,
                      comment: _followupController.text,
                      createdBy: user?.displayName ?? '',
                      createdAt: DateTime.now(),
                    );

                    await ticketFollowupService.create(ticketFU);

                    _followupController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowups(String ticketId) {
    print(ticketId);
    Stream<QuerySnapshot<Object?>> followups =
        ticketFollowupService.getTicketFUStream(ticketId);

    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: followups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:
                Text('Nenhum comentário ainda', style: TextStyle(fontSize: 16)),
          );
        }

        final followupDocs = snapshot.data!.docs
            .map((doc) => TicketFollowup.fromSnapshot(doc))
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: followupDocs.map((followup) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            followup.createdBy,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            followup.formattedCreatedAt,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        followup.comment,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
