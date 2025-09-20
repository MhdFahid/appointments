import 'package:appointments/models/treatment.dart';
import 'package:appointments/providers/auth_provider.dart';
import 'package:appointments/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreatmentSelectionScreen extends StatefulWidget {
  final List<Treatment> initialSelectedTreatments;

  const TreatmentSelectionScreen({
    super.key,
    required this.initialSelectedTreatments,
  });

  @override
  State<TreatmentSelectionScreen> createState() =>
      _TreatmentSelectionScreenState();
}

class _TreatmentSelectionScreenState extends State<TreatmentSelectionScreen> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.selectedTreatments.clear();
    auth.selectedTreatments.addAll(widget.initialSelectedTreatments);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Treatment",
            style: TextStyle(fontSize: 20),
          ),
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              if (auth.isFetchingTreatments) {
                return const Center(child: CircularProgressIndicator());
              }
              final treatments = auth.treatments;
              if (treatments.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('No treatments available'),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Treatment',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Treatment>(
                    value: auth.selectedTreatments.isNotEmpty
                        ? auth.selectedTreatments.first
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    hint: const Text('Select a treatment'),
                    items: treatments
                        .map(
                          (t) => DropdownMenuItem<Treatment>(
                            value: t,
                            child: Text(t.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      auth.selectedTreatments.clear();
                      auth.addTreatment(value);
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Add Patients",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "  Male",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Spacer(),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 25, 98, 27),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ))),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  width: 40,
                  height: 40,
                  child: Center(child: Text("0"))),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 25, 98, 27),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CountRow(),
          SizedBox(
            height: 30,
          ),
          CustomButton(buttonText: "Save", isLoading: true)
        ],
      ),
    );
  }
}

class CountRow extends StatelessWidget {
  const CountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Text(
            "  Female",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Spacer(),
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 25, 98, 27),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ))),
        SizedBox(
          width: 10,
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
            width: 40,
            height: 40,
            child: Center(child: Text("0"))),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 25, 98, 27),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
