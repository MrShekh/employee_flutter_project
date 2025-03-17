import 'package:flutter/material.dart';
import 'attendance.dart';
import 'task_box.dart';
import 'leave.dart';
import 'performance.dart';
import 'feedback.dart';
import 'hr_documents.dart';
import 'recruitment.dart';
import 'helpdesk.dart';
import 'employee.dart';
import 'flows.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.blue),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.blue, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())); 
            },
          ),
        ],
      ),
      body: Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            _buildDashboardItem(Icons.task, "Task Box", TaskBoxScreen()),
            _buildDashboardItem(Icons.calendar_today, "Attendance", AttendanceScreen()),
            _buildDashboardItem(Icons.beach_access, "Leave", LeaveScreen()),
            _buildDashboardItem(Icons.trending_up, "Performance", PerformanceScreen()),
            _buildDashboardItem(Icons.feedback, "Feedback", FeedbackScreen()),
            _buildDashboardItem(Icons.description, "HR Documents", HRDocumentsScreen()),
            _buildDashboardItem(Icons.group, "Recruitment", RecruitmentScreen()),
            _buildDashboardItem(Icons.help, "Helpdesk", HelpdeskScreen()),
            _buildDashboardItem(Icons.people, "Employee", EmployeeScreen()),
            _buildDashboardItem(Icons.sync_alt, "Flows", FlowsScreen()),
            _buildDashboardItem(Icons.celebration, "Events", EventsScreen()),
            _buildDashboardItem(Icons.payments, "Payroll", PayrollScreen()), // Added Payroll Card
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
