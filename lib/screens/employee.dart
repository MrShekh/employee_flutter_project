import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String role;
  final String profilePic;
  final String email;
  final String department;
  final String about;

  Employee({
    required this.name,
    required this.role,
    required this.profilePic,
    required this.email,
    required this.department,
    required this.about,
  });
}

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<Employee> employees = [
    Employee(
      name: "John Doe",
      role: "Software Engineer",
      profilePic: "https://randomuser.me/api/portraits/men/1.jpg",
      email: "john.doe@example.com",
      department: "IT",
      about: "Passionate about coding and technology.",
    ),
    Employee(
      name: "Jane Smith",
      role: "UI/UX Designer",
      profilePic: "https://randomuser.me/api/portraits/women/2.jpg",
      email: "jane.smith@example.com",
      department: "Design",
      about: "Loves creating intuitive user experiences.",
    ),
    Employee(
      name: "Michael Brown",
      role: "HR Manager",
      profilePic: "https://randomuser.me/api/portraits/men/3.jpg",
      email: "michael.brown@example.com",
      department: "Human Resources",
      about: "Ensuring a great workplace culture.",
    ),
    Employee(
      name: "Alice Johnson",
      role: "Finance Analyst",
      profilePic: "https://randomuser.me/api/portraits/women/4.jpg",
      email: "alice.johnson@example.com",
      department: "Finance",
      about: "Loves analyzing company growth metrics.",
    ),
  ];

  List<Employee> filteredEmployees = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredEmployees = employees;
    searchController.addListener(_filterEmployees);
  }

  void _filterEmployees() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredEmployees = employees.where((employee) {
        return employee.name.toLowerCase().contains(query) ||
            employee.role.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employees")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by name or role...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),

            // Employee Grid View
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjust for card height
                ),
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) {
                  var employee = filteredEmployees[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeProfileScreen(employee: employee),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(employee.profilePic),
                          ),
                          SizedBox(height: 10),
                          Text(employee.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 5),
                          Text(employee.role, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeProfileScreen extends StatelessWidget {
  final Employee employee;

  EmployeeProfileScreen({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(employee.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(employee.profilePic),
              ),
            ),
            SizedBox(height: 15),
            Text(employee.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(employee.role, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            Divider(),
            SizedBox(height: 10),
            Row(children: [Icon(Icons.email, color: Colors.blue), SizedBox(width: 10), Text(employee.email)]),
            SizedBox(height: 10),
            Row(children: [Icon(Icons.business, color: Colors.green), SizedBox(width: 10), Text(employee.department)]),
            SizedBox(height: 20),
            Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(employee.about, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
