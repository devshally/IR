// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incident_report/app/features/incident/domain/entities/incident.dart';
import 'package:incident_report/app/features/incident/domain/repositories/incident_repo.dart';
import 'package:incident_report/app/features/incident/presentation/widgets/reportcard_widget.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset('assets/images/irlogo.png', height: 90),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final user = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder<List<Incident>>(
        stream: IncidentRepo.incidentStream(user),
        builder:
            (BuildContext context, AsyncSnapshot<List<Incident>> snapshot) {
          Widget body;
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              body = const Center(
                child: Text('No reports yet.'),
              );
            } else {
              final data = snapshot.data!;
              body = _buildIncidentList(data);
            }
          } else {
            body = const Center(child: CircularProgressIndicator());
          }
          return AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: body,
          );
        },
      ),
    );
  }

  Widget _buildIncidentList(List<Incident> incidents) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 0,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final natureOfIncident = incidents[index].natureOfIncident;
        final description = incidents[index].description;
        final date = incidents[index].date;
        final timeOfReport = DateFormat.yMMMd().add_jm().format(date!.toDate());
        final location = incidents[index].location;
        return index >= incidents.length
            ? Container(
                alignment: Alignment.center,
                child: const Center(
                  child: SizedBox(
                    width: 33,
                    height: 33,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ),
                  ),
                ),
              )
            : ReportCard(
                natureOfIncident: natureOfIncident.toString(),
                description: description.toString(),
                address: location!,
                date: timeOfReport,
              );
      },
      itemCount: incidents.length,
    );
  }
}
