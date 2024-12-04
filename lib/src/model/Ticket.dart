import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
    String? id;
    String title;
    String description;
    String priority;
    String status;
    String category;
    String createdBy;

  Ticket({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.category,
    required this.createdBy,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? '',
      status: map['status'] ?? '',
      category: map['category'] ?? '',
      createdBy: map['created_by'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'category': category,
      'created_by': createdBy,
    };
  }

  @override
  String toString() {
    return 'Ticket{id: $id, titulo: $title, descricao: $description, categoria: $category, '
        'prioridade: $priority, status: $status, criadoPor: $createdBy}';
  }
}
