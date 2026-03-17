class GradeCalculator {
  static Map<String, dynamic> calculate({
    required double assignment,
    required double test,
    required double exam,
  }) {
    final double finalScore =
        (assignment * 0.2) + (test * 0.3) + (exam * 0.5);

    String grade;
    String remark;

    if (finalScore >= 80) {
      grade = 'A';
      remark = 'Excellent';
    } else if (finalScore >= 70) {
      grade = 'B';
      remark = 'Very Good';
    } else if (finalScore >= 60) {
      grade = 'C';
      remark = 'Good';
    } else if (finalScore >= 50) {
      grade = 'D';
      remark = 'Pass';
    } else {
      grade = 'F';
      remark = 'Fail';
    }

    return {
      'finalScore': finalScore,
      'grade': grade,
      'remark': remark,
    };
  }
}