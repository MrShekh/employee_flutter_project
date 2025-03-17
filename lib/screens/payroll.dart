import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class PayrollScreen extends StatefulWidget {
  @override
  _PayrollScreenState createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  String? selectedMonth;
  String? selectedYear;

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  final List<String> years = ["2023", "2024", "2025"];

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String currentMonth = months[now.month - 1];
    String currentYear = now.year.toString();

    return Scaffold(
      appBar: AppBar(title: Text("Payroll")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Month & Year", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: selectedMonth,
                    hint: Text("Select Month"),
                    onChanged: (value) => setState(() => selectedMonth = value),
                    items: months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month));
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: selectedYear,
                    hint: Text("Select Year"),
                    onChanged: (value) => setState(() => selectedYear = value),
                    items: years.map((year) {
                      return DropdownMenuItem(value: year, child: Text(year));
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (selectedMonth != null && selectedYear != null)
              if (_isSalaryAvailable(selectedMonth!, selectedYear!))
                Expanded(child: PayslipView(selectedMonth!, selectedYear!))
              else
                Center(child: Text("Salary details are not available for this month.")),
            SizedBox(height: 20),
            _recentSalaryHistory(),
          ],
        ),
      ),
    );
  }

  bool _isSalaryAvailable(String month, String year) {
    DateTime selectedDate = DateTime(years.indexOf(year) + 2023, months.indexOf(month) + 1);
    return selectedDate.isBefore(DateTime(now.year, now.month));
  }

  Widget _recentSalaryHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Salary History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Table(
          border: TableBorder.all(),
          columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.3), 2: FractionColumnWidth(0.3)},
          children: [
            _buildTableRow(["Month", "Amount", "Date"], isHeader: true),
            _buildTableRow(["${months[now.month - 2]} ${now.year}", "\$9500", "5th ${months[now.month - 1]}"]),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader ? BoxDecoration(color: Colors.grey[300]) : null,
      children: cells.map((text) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(text, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal))),
        );
      }).toList(),
    );
  }
}

class PayslipView extends StatelessWidget {
  final String month;
  final String year;

  PayslipView(this.month, this.year);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payslip", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Zoonoodle Inc"),
              Text("21023 Pearson Point Road, Gateway Avenue"),
              SizedBox(height: 10),
              Text("Employee Name: Sally Harley"),
              Text("Date of Joining: 2018-06-23"),
              Text("Designation: Marketing Executive"),
              Text("Department: Marketing"),
              Text("Pay Period: $month $year"),
              Text("Worked Days: 26"),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final pdfBytes = await _generatePdf();
                    await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
                  },
                  icon: Icon(Icons.download),
                  label: Text("Download Payslip"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text("Payslip", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    pw.Text("Zoonoodle Inc"),
                    pw.Text("21023 Pearson Point Road, Gateway Avenue"),
                  ],
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Text("Employee Name: Sally Harley"),
              pw.Text("Date of Joining: 2018-06-23"),
              pw.Text("Designation: Marketing Executive"),
              pw.Text("Department: Marketing"),
              pw.Text("Pay Period: $month $year"),
              pw.Text("Worked Days: 26"),
              pw.SizedBox(height: 15),
              pw.Table.fromTextArray(
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
                data: [
                  ["Earnings", "Amount", "Deductions", "Amount"],
                  ["Basic", "10000", "Provident Fund", "1200"],
                  ["Incentive Pay", "1000", "Professional Tax", "500"],
                  ["House Rent Allowance", "400", "Loan", "400"],
                  ["Meal Allowance", "200", "", ""],
                  ["Total Earnings", "11600", "Total Deductions", "2100"],
                  ["Net Pay", "9500", "", ""],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text("Net Pay: 9500"),
              pw.Text("In Words: Nine Thousand Five Hundred"),
              pw.SizedBox(height: 30),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Employer Signature: __________"),
                  pw.Text("Employee Signature: __________"),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text("This is a system-generated payslip."),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
