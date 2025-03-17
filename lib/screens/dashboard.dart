import 'package:flutter/material.dart';
import 'attendance.dart';
import 'task_box.dart';
import 'leave.dart';
import 'performance.dart';
import 'feedback.dart';
import 'hr_documents.dart';
import 'helpdesk.dart';
import 'employee.dart';
import 'events.dart';
import 'profile.dart';
import 'payroll.dart'; // Import Payroll Screen

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 2, 2),
        elevation: 0,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Add Notification Functionality Here
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())); 
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildDashboardItem(Icons.task, "Task Box", TaskBoxScreen(), Colors.blueAccent),
            _buildDashboardItem(Icons.calendar_today, "Attendance", AttendanceScreen(), Colors.green),
            _buildDashboardItem(Icons.beach_access, "Leave", LeaveScreen(), Colors.orange),
            _buildDashboardItem(Icons.trending_up, "Performance", PerformanceScreen(), Colors.redAccent),
            _buildDashboardItem(Icons.feedback, "Feedback", FeedbackScreen(), Colors.teal),
            _buildDashboardItem(Icons.description, "HR Documents", HRDocumentsScreen(), Colors.purpleAccent),
            _buildDashboardItem(Icons.help, "Helpdesk", HelpdeskScreen(), Colors.deepOrange),
            _buildDashboardItem(Icons.people, "Employee", EmployeeScreen(), Colors.indigo),
            _buildDashboardItem(Icons.celebration, "Events", EventsScreen(), Colors.pinkAccent),
            _buildDashboardItem(Icons.payments, "Payroll", PayrollScreen(), Colors.brown), // Payroll Card
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(IconData icon, String title, Widget page, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
