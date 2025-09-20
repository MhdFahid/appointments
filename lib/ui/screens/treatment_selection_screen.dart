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
    auth.selectedTreatments
      ..clear()
      ..addAll(widget.initialSelectedTreatments);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Choose Treatment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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

                return DropdownButtonFormField<Treatment>(
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
                          child: Text(
                            t.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    auth.selectedTreatments
                      ..clear()
                      ..add(value);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Add Patients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const PatientCountRow(isMale: true),
            const SizedBox(height: 10),
            const PatientCountRow(isMale: false),
            const Spacer(),
            const CustomButton(buttonText: "Save", isLoading: true),
          ],
        ),
      ),
    );
  }
}

class PatientCountRow extends StatelessWidget {
  final bool isMale;

  const PatientCountRow({super.key, required this.isMale});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        int count = isMale ? auth.maleCount : auth.femaleCount;

        return Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "  ${isMale ? 'Male' : 'Female'}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(),
            CircleButton(
              icon: Icons.remove,
              onTap: () {
                isMale ? auth.decrementMale() : auth.decrementFemale();
              },
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(count.toString(), key: UniqueKey())),
            ),
            const SizedBox(width: 10),
            CircleButton(
              icon: Icons.add,
              onTap: () {
                isMale ? auth.incrementMale() : auth.incrementFemale();
              },
            ),
          ],
        );
      },
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 25, 98, 27),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
