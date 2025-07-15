// screens/result_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int total;
  final int correct;
  final int attempted;

  const ResultScreen({
    super.key,
    required this.total,
    required this.correct,
    required this.attempted,
  });

  @override
  Widget build(BuildContext context) {
    final int incorrect = attempted - correct;
    final int unattempted = total - attempted;
    final int percent = ((correct / total) * 100).round();

    Color gradeColor() {
      if (percent >= 80) return Colors.green;
      if (percent >= 60) return const Color(0xFF6C5CE7);
      if (percent >= 40) return Colors.orange;
      return Colors.red;
    }

    String gradeText() {
      if (percent >= 80) return 'Excellent!';
      if (percent >= 60) return 'Good Job!';
      if (percent >= 40) return 'Not Bad!';
      return 'Keep Practicing!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(          // ← fixes overflow
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // badge
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: gradeColor(),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: gradeColor().withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  percent >= 60 ? Icons.check_circle : Icons.info,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),

              Text(gradeText(),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: gradeColor())),
              const SizedBox(height: 30),

              // score box
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text('Your Score',
                          style:
                          TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 10),
                      Text('$correct / $total',
                          style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C5CE7))),
                      const SizedBox(height: 6),
                      Text('$percent%',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: gradeColor())),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // breakdown
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _stat('Correct', correct, Colors.green),
                      _stat('Incorrect', incorrect, Colors.red),
                      _stat('Unattempted', unattempted,
                          const Color(0xFFFFC107)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // actions
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomeScreen()),
                            (_) => false);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Go to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // helper widget
  Widget _stat(String title, int value, Color color) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 6),
        Text('$value',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color)),
      ],
    );
  }
}
