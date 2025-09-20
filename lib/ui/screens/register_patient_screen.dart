import 'package:appointments/models/branch.dart';
import 'package:appointments/models/patient.dart';
import 'package:appointments/models/treatment.dart';
import 'package:appointments/providers/auth_provider.dart';
import 'package:appointments/ui/widgets/custom_button.dart';
import 'package:appointments/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'treatment_selection_screen.dart';

class RegisterPatientScreen extends StatefulWidget {
  const RegisterPatientScreen({super.key});

  @override
  State<RegisterPatientScreen> createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController executiveController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();
  final TextEditingController dateAndTimeController = TextEditingController();

  Branch? selectedBranch;
  List<Treatment> selectedTreatments = [];

  @override
  void dispose() {
    nameController.dispose();
    executiveController.dispose();
    phoneController.dispose();
    addressController.dispose();
    paymentController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    dateAndTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;
    final combined =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    dateAndTimeController.text = combined.toString();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back,
                        size: 40, color: const Color.fromARGB(255, 41, 40, 40)),
                    const Spacer(),
                    Icon(Icons.notifications_none_outlined,
                        size: 40,
                        color: const Color.fromARGB(255, 142, 115, 115)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Register Patient",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 28, 27, 27),
                        fontWeight: FontWeight.normal)),
                const Divider()
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: nameController,
                  labelText: "Name",
                  field: 'Name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: executiveController,
                  labelText: "Executive",
                  field: 'Executive',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: phoneController,
                  labelText: "Phone",
                  field: 'Phone',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: addressController,
                  labelText: "Address",
                  field: 'Address',
                ),
                const SizedBox(height: 16),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return auth.isFetchingBranches
                        ? const CircularProgressIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Branch",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color:
                                      const Color.fromARGB(255, 240, 235, 235),
                                ),
                                child: DropdownButtonFormField<Branch>(
                                  value: selectedBranch,
                                  decoration: const InputDecoration(
                                    hintText: 'Branch',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                  ),
                                  items: auth.branches.map((branch) {
                                    return DropdownMenuItem(
                                      value: branch,
                                      child: Text(branch.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBranch = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a branch';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  buttonText: "+ Add Treatments",
                  isLoading: true,
                  buttonColor: const Color.fromARGB(255, 158, 200, 160),
                  textColor: Colors.black,
                  onPressed: () async {
                    // Allow provider to fetch treatments if needed, but keep selection local
                    if (authProvider.treatments.isEmpty &&
                        !authProvider.isFetchingTreatments) {
                      await authProvider.fetchTreatments();
                    }
                    if (!context.mounted) return;
                    final result = await showDialog<List<Treatment>>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: SizedBox(
                          width: double.maxFinite,
                          child: TreatmentSelectionScreen(
                            initialSelectedTreatments: selectedTreatments,
                          ),
                        ),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        selectedTreatments = result;
                      });
                    }
                  },
                ),
                if (selectedTreatments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Treatments',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: selectedTreatments.length,
                          separatorBuilder: (_, __) => const Divider(height: 8),
                          itemBuilder: (context, index) {
                            final treatment = selectedTreatments[index];
                            return ListTile(
                              key: ValueKey(treatment.id),
                              contentPadding: EdgeInsets.zero,
                              title: Text(treatment.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    selectedTreatments.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: paymentController,
                  labelText: "Payment",
                  field: 'Payment',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: totalAmountController,
                  labelText: "Total Amount",
                  field: 'Total Amount',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: discountAmountController,
                  labelText: "Discount Amount",
                  field: 'Discount Amount',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: advanceAmountController,
                  labelText: "Advance Amount",
                  field: 'Advance Amount',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: balanceAmountController,
                  labelText: "Balance Amount",
                  field: 'Balance Amount',
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _pickDateTime(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: dateAndTimeController,
                      labelText: "Date and Time",
                      field: 'Date and Time',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return CustomButton(
                      onPressed: () {
                        // Validate form before calling provider
                        if (!_formKey.currentState!.validate()) return;
                        auth.registerPatient(
                          name: nameController.text.trim(),
                          executive: executiveController.text.trim(),
                          phone: phoneController.text.trim(),
                          address: addressController.text.trim(),
                          payment: double.parse(paymentController.text),
                          totalAmount: double.parse(totalAmountController.text),
                          discountAmount:
                              double.parse(advanceAmountController.text),
                          advanceAmount:
                              double.parse(discountAmountController.text),
                          branch: selectedBranch!,
                          balanceAmount: balanceAmountController.text.trim(),
                          dateAndTime: dateAndTimeController.text.trim(),
                        );
                      },
                      buttonText: 'Register',
                      isLoading: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
