import 'package:flutter/material.dart';
import 'package:test_app/database.dart';

class Add_Employee extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? existingData;

  const Add_Employee({super.key, this.docId, this.existingData});

  @override
  State<Add_Employee> createState() => _Add_EmployeeState();
}

class _Add_EmployeeState extends State<Add_Employee> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      nameController.text = widget.existingData!['name'] ?? '';
      ageController.text = widget.existingData!['age'].toString();
      locationController.text = widget.existingData!['location'] ?? '';
    }
  }

  // Reusable TextField style
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.docId == null ? "Add Employee" : "Edit Employee",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Box
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration("Full Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 16),

              // Age Box
              TextFormField(
                controller: ageController,
                decoration: _inputDecoration("Age"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Age" : null,
              ),
              const SizedBox(height: 16),

              // Location Box
              TextFormField(
                controller: locationController,
                decoration: _inputDecoration("Location"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Location" : null,
              ),
              const SizedBox(height: 30),

              // Animated Gradient Button
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> employeeData = {
                      "name": nameController.text,
                      "age": int.parse(ageController.text),
                      "location": locationController.text,
                    };

                    if (widget.docId == null) {
                      await DatabaseMethods().addUserDetails(employeeData);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Employee Added Successfully",
                            style: const TextStyle(
                              color: Colors.green, // ✅ text color
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: const Color.fromARGB(255, 200, 235, 201), // ✅ background color
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      await DatabaseMethods().updateUSerDetails(
                        widget.docId!,
                        employeeData,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Employee Updated Successfully",
                            style: const TextStyle(
                              color: Colors.green, // ✅ text color
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: const Color.fromARGB(255, 212, 247, 213), // ✅ background color
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }

                    Navigator.pop(context);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.docId == null ? "Add Employee" : "Update Employee",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom SnackBar with style
  SnackBar _customSnack(String message) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 2),
    );
  }
}
