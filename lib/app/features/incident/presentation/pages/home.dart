// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:incident_report/app/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:incident_report/app/features/incident/presentation/widgets/dropdown_widget.dart';
import 'package:incident_report/app/features/incident/presentation/widgets/multitextfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFieldWidget(controller: fullNameController, label: 'Full Name'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DropDownWidget(
              items: const ['Select a category', 'Fire', 'Accident'],
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
            ),
          ),
          _buildMediaRow(),
          _buildAccuracyRow(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
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
