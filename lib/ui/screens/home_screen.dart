import 'package:appointments/ui/screens/register_patient_screen.dart';
import 'package:appointments/ui/widgets/custom_app_bar.dart';
import 'package:appointments/ui/widgets/custom_button.dart';
import 'package:appointments/ui/widgets/patient_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).fetchPatients();
    });
  }

  Future<void> _refreshPatients() async {
    await Provider.of<AuthProvider>(context, listen: false).fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220.0),
        child: CustomAppBar(),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isFetchingPatients) {
            return const Center(child: CircularProgressIndicator());
          } else if (authProvider.error != null) {
            return Center(child: Text('Error: ${authProvider.error}'));
          } else if (authProvider.patients.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox,
                      size: 100, color: Colors.grey), // Placeholder
                  SizedBox(height: 16),
                  Text('No patients found.'),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _refreshPatients,
              child: ListView.builder(
                itemCount: authProvider.patients.length,
                itemBuilder: (context, index) {
                  final patient = authProvider.patients[index];
                  return PatientCardItem(
                    name: patient.name,
                    tretmentName: patient.patientDetailsSet[0].treatmentName,
                    index: (index + 1).toString(),
                    date: patient.createdAt.toString(),
                    age: 25.toString(),
                  );
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CustomButton(
          buttonText: "Register Patient",
          isLoading: false,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterPatientScreen()),
            );
            if (!mounted) return;
            Provider.of<AuthProvider>(context, listen: false).fetchPatients();
          },
        ),
      ),
    );
  }
}
