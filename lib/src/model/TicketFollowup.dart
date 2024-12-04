import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TicketFollowup {
  String? id;
  String? ticketId;
  String comment;
  String createdBy;
  DateTime createdAt;

  TicketFollowup({
    this.id,
    required this.ticketId,
    required this.comment,
    required this.createdBy,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  String get formattedCreatedAt {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(createdAt);
  }

  factory TicketFollowup.fromMap(Map<String, dynamic> map) {
    return TicketFollowup(
      id: map['id'],
      ticketId: map['ticket_id'],
      comment: map['comment'],
      createdBy: map['created_by'],
      createdAt: (map['created_at'] is Timestamp)
          ? (map['created_at'] as Timestamp).toDate()
          : DateTime.parse(map['created_at']),
    );
  }

  factory TicketFollowup.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TicketFollowup(
      id: snapshot.id,
      ticketId: data['ticket_id'],
      comment: data['comment'],
      createdBy: data['created_by'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ticket_id': ticketId,
      'comment': comment,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
