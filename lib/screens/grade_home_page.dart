import 'package:flutter/material.dart';
import '../utils/grade_calculator.dart';

class GradeHomePage extends StatefulWidget {
  const GradeHomePage({super.key});

  @override
  State<GradeHomePage> createState() => _GradeHomePageState();
}

class _GradeHomePageState extends State<GradeHomePage> {
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController assignmentController = TextEditingController();
  final TextEditingController testController = TextEditingController();
  final TextEditingController examController = TextEditingController();

  String studentName = '';
  String courseName = '';
  double finalScore = 0.0;
  String grade = '';
  String remark = '';
  bool hasResult = false;

  void calculateGrade() {
    final String enteredStudentName = studentNameController.text.trim();
    final String enteredCourseName = courseNameController.text.trim();

    if (enteredStudentName.isEmpty ||
        enteredCourseName.isEmpty ||
        assignmentController.text.isEmpty ||
        testController.text.isEmpty ||
        examController.text.isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }

    final double assignment = double.tryParse(assignmentController.text) ?? -1;
    final double test = double.tryParse(testController.text) ?? -1;
    final double exam = double.tryParse(examController.text) ?? -1;

    if (assignment < 0 ||
        test < 0 ||
        exam < 0 ||
        assignment > 100 ||
        test > 100 ||
        exam > 100) {
      showMessage('Please enter valid scores between 0 and 100.');
      return;
    }

    final gradeData = GradeCalculator.calculate(
      assignment: assignment,
      test: test,
      exam: exam,
    );

    setState(() {
      studentName = enteredStudentName;
      courseName = enteredCourseName;
      finalScore = gradeData['finalScore'];
      grade = gradeData['grade'];
      remark = gradeData['remark'];
      hasResult = true;
    });
  }

  void clearFields() {
    studentNameController.clear();
    courseNameController.clear();
    assignmentController.clear();
    testController.clear();
    examController.clear();

    setState(() {
      studentName = '';
      courseName = '';
      finalScore = 0.0;
      grade = '';
      remark = '';
      hasResult = false;
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    studentNameController.dispose();
    courseNameController.dispose();
    assignmentController.dispose();
    testController.dispose();
    examController.dispose();
    super.dispose();
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2),
          ),
        ),
      ),
    );
  }

  Widget buildResultCard() {
    if (!hasResult) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Text(
          'Result will appear here.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            Text('Student Name: $studentName',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Course Name: $courseName',
                style: const TextStyle(fontSize: 16)),
            const Divider(height: 24),
            Text('Final Score: ${finalScore.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Grade: $grade', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Remark: $remark', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grade Calculator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Student Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildTextField(
                'Student Name',
                studentNameController,
                icon: Icons.person,
              ),
              buildTextField(
                'Course Name',
                courseNameController,
                icon: Icons.book,
              ),
              buildTextField(
                'Assignment Score',
                assignmentController,
                keyboardType: TextInputType.number,
                icon: Icons.edit_note,
              ),
              buildTextField(
                'Test Score',
                testController,
                keyboardType: TextInputType.number,
                icon: Icons.quiz,
              ),
              buildTextField(
                'Exam Score',
                examController,
                keyboardType: TextInputType.number,
                icon: Icons.school,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: calculateGrade,
                        child: const Text('Calculate'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: clearFields,
                        child: const Text('Clear'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }
}