// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:incident_report/app/features/incident/domain/entities/incident.dart';

class IncidentRepo {
  static Stream<List<Incident>> incidentStream(String uid) {
    final _firestore = FirebaseFirestore.instance;
    final query =
        _firestore.collection('incidents').where('uid', isEqualTo: uid);
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((docs) => Incident.fromMap(docs.data()))
          .toList();
    });
  }
}
