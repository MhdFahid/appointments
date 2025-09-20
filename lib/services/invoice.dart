import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Preview"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = pw.Document();

            // Add page
            pdf.addPage(pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'KUMARAKOM',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Cheepunkal P.O. Kumarakom, Kottayam, Kerala - 686653\n'
                          'e-mail: unknown@gmail.com\n'
                          'Mob: +91 9876543210\nGST No: 32AABCU9603R1ZW',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Patient Details',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text('Name: Salih T'),
                    pw.Text('Address: Nadakkave, Kozhikode'),
                    pw.Text('WhatsApp Number: +91 9876543210'),
                    pw.Text('Booked On: 31/01/2024 | 12:12 PM'),
                    pw.Text('Treatment Date: 21/02/2024'),
                    pw.Text('Treatment Time: 11:00 AM'),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Treatment',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Table.fromTextArray(
                      headers: ['Treatment', 'Price', 'Male', 'Female', 'Total'],
                      data: [
                        ['Panchakarma', '₹230', '4', '4', '₹2,540'],
                        ['Njavara Kizhi Treatment', '₹230', '4', '4', '₹2,540'],
                        ['Panchakarma', '₹230', '4', '6', '₹2,540'],
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text('Total Amount: ₹7,620'),
                    pw.Text('Discount: ₹500'),
                    pw.Text('Advance: ₹1,200'),
                    pw.Text('Balance: ₹5,920'),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Thank you for choosing us',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      'Your well-being is our commitment, and we\'re honored you\'ve entrusted us with your health journey.',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment.',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'love',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ));

            // Print or save the document
            await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
          },
          child: Text("Generate PDF"),
        ),
      ),
    );
  }
}

 