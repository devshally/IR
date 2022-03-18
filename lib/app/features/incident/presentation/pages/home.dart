// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_report/app/features/incident/presentation/cubit/incident_cubit.dart';

import 'package:incident_report/app/features/incident/presentation/widgets/dropdown_widget.dart';
import 'package:incident_report/app/features/incident/presentation/widgets/multitextfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool checked = false;

  String category = 'Select a category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset('assets/images/irlogo.png', height: 90),
        toolbarHeight: 100,
      ),
      body: BlocConsumer<IncidentCubit, IncidentState>(
        listener: (context, state) {
          if (state is IncidentLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is IncidentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      key: formGlobalKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropDownWidget(
                items: const [
                  'Select a category',
                  'Fire',
                  'Rape',
                  'Police Brutality',
                  'Vehicle Accident',
                  'Natural Disaster',
                  'Misconduct',
                  'Others',
                ],
                hint: 'Select a category',
                value: category,
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MultiLineTextField(
                controller: descriptionController,
                validator: (description) {
                  if (description!.length < 6) {
                    return 'Enter a valid description of the event';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            _buildMediaRow(),
            _buildAccuracyRow(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (formGlobalKey.currentState!.validate()) {
                    formGlobalKey.currentState!.save();
                    if (checked == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kindly check the box to confirm.'),
                        ),
                      );
                    } else {
                      BlocProvider.of<IncidentCubit>(context).reportIncident(
                        category,
                        descriptionController.text,
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: const Text(
                'Media Upload',
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Upload',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyRow() {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: (value) {
            setState(() {
              checked = value!;
            });
          },
        ),
        const Expanded(
          child: Text(
            'Clicking this you agree to all the information provided here is true and accurate',
          ),
        ),
      ],
    );
  }
}
