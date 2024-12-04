import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/service/TicketFollowupService.dart';

import '../model/Ticket.dart';

class TicketService {
  final CollectionReference firebase = FirebaseFirestore.instance.collection('help_desk');
  final TicketFollowupService ticketFollowupService = TicketFollowupService();

  Future<String?> create(Ticket ticket) async {
    try {
      DocumentReference docRef = await firebase.add(ticket.toMap());

      await docRef.update({'id': docRef.id});

      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }


  Stream<QuerySnapshot> getTicketStream() {
    var ticketStream = firebase.orderBy('priority', descending: true).snapshots();
    return ticketStream;
  }

  Future<void> delete(String id)async {

    this.ticketFollowupService.deleteByTicket(id);

    await firebase.doc(id).delete();

  }
  Future<void> update(Ticket ticket) async {
    try {
      await firebase.doc(ticket.id).update(ticket.toMap());

    } catch (e) {
      throw Exception('Erro ao atualizar o ticket: $e');
    }
  }

}
