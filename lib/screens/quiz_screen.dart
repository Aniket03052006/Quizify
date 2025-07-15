// screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'If a train travels 120 km in 2 hours, what is its speed in km/h?',
      'options': ['50 km/h', '60 km/h', '70 km/h', '80 km/h'],
      'correct': 1,
    },
    {
      'question': 'What is the next number in the sequence: 2, 6, 12, 20, 30, ?',
      'options': ['40', '42', '44', '46'],
      'correct': 1,
    },
    {
      'question': 'If 5 workers can complete a task in 8 days, how many days will 10 workers take?',
      'options': ['16 days', '8 days', '4 days', '2 days'],
      'correctAnswer': 2,
    },
    {
      'question': 'What is 25% of 80?',
      'options': ['15', '20', '25', '30'],
      'correctAnswer': 1,
    },
    {
      'question': 'If today is Wednesday, what day will it be after 100 days?',
      'options': ['Monday', 'Tuesday', 'Wednesday', 'Thursday'],
      'correctAnswer': 2,
    },
    {
      'question': 'A rectangle has length 12 cm and width 8 cm. What is its area?',
      'options': ['96 cm²', '40 cm²', '20 cm²', '48 cm²'],
      'correctAnswer': 0,
    },
    {
      'question': 'What is the average of 15, 25, 35, and 45?',
      'options': ['25', '30', '35', '40'],
      'correctAnswer': 1,
    },
    {
      'question': 'If a book costs Rs.12 and you get a 25% discount, how much do you pay?',
      'options': ['Rs.8', 'Rs.9', 'Rs.10', 'Rs.11'],
      'correctAnswer': 1,
    },
    {
      'question': 'What is the square root of 144?',
      'options': ['10', '11', '12', '13'],
      'correctAnswer': 2,
    },
    {
      'question': 'If you buy 3 apples for Rs.2, how much would 12 apples cost?',
      'options': ['Rs.6', 'Rs.7', 'Rs.8', 'Rs.9'],
      'correctAnswer': 2,
    },
  ];

  int _index = 0;                       // current question index
  final Map<int, int?> _answers = {};   // null = un-attempted

  // helpers
  bool get _isLast => _index == _questions.length - 1;
  bool get _isFirst => _index == 0;
  int get _attempted =>
      _answers.values.where((e) => e != null).length;
  int get _unattempted => _questions.length - _attempted;

  void _select(int option) {
    setState(() => _answers[_index] = option);
  }

  void _next() {
    setState(() => _index = _isLast ? _index : _index + 1);
  }

  void _previous() {
    setState(() => _index = _isFirst ? _index : _index - 1);
  }

  void _finish() {
    final int correct = _answers.entries
        .where((e) => e.value == _questions[e.key]['correct'])
        .length;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          total: _questions.length,
          correct: correct,
          attempted: _attempted,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${_index + 1} / ${_questions.length}',
                      style: const TextStyle(color: Colors.grey)),
                  Text('Attempted: $_attempted | Unattempted: $_unattempted',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (_index + 1) / _questions.length,
                color: const Color(0xFF6C5CE7),
                backgroundColor: Colors.grey[800],
              ),
              const SizedBox(height: 30),

              // question
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(q['question'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 25),
                          ...List.generate(q['options'].length, (i) {
                            final bool selected = _answers[_index] == i;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ElevatedButton(
                                onPressed: () => _select(i),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selected
                                      ? const Color(0xFF6C5CE7)
                                      : const Color(0xFF2A2A2A),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${String.fromCharCode(65 + i)}. ${q['options'][i]}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // navigation buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isFirst ? null : _previous,
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _next,
                      child: const Text('Skip'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLast ? _finish : _next,
                  child: Text(_isLast ? 'Finish Quiz' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
