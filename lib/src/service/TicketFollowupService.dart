import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/src/model/TicketFollowup.dart';

import '../model/Ticket.dart';

class TicketFollowupService {
  final CollectionReference firebase = FirebaseFirestore.instance.collection('help_desk_fu');

  Future<void> create(TicketFollowup ticketFU) async {
    try {
      DocumentReference docRef = await firebase.add(ticketFU.toMap());

      await docRef.update({'id': docRef.id});
    } on FirebaseException catch (e) {
      debugPrint("Failed with error '${e.code}': '${e.message}'");
      throw Exception(e.message);
    }
  }

  deleteByTicket(String ticketId) async{
    var allFUs = await this.firebase.where('ticket_id', isEqualTo: ticketId).get();

    for (var followUp in allFUs.docs) {
      await followUp.reference.delete();
    }
  }
  Stream<QuerySnapshot<Object?>> getTicketFUStream(String ticketId) {
    return firebase
        .where('ticket_id', isEqualTo: ticketId)
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
