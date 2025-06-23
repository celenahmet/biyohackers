import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedOption;
  bool showFeedback = false;

  List<int> selectedAnswers = [];

  final List<String> explanations = [
    "🔋 Mitokondri, enerji üretiminden sorumludur. Hücrenin enerji santrali olarak görev yapar.",
    "🌿 Kloroplast sadece bitki hücresinde bulunur ve fotosentez yapar.",
    "🧬 Ribozom protein sentezler. Hücrenin en küçük organelidir.",
    "🧪 Lizozom yalnızca hayvan hücresinde bulunur ve sindirim yapar.",
    "📦 Golgi aygıtı proteinleri işler ve paketleyerek hücre dışına gönderir."
  ];

  void handleAnswer(int selected) {
    final correct = quizQuestions[currentIndex].correctIndex;
    selectedAnswers.add(selected);

    setState(() {
      selectedOption = selected;
      showFeedback = true;
      if (selected == correct) score += 20;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        currentIndex++;
        selectedOption = null;
        showFeedback = false;
      });
    });
  }

  void _showExplanationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Açıklama"),
        content: Text(
          explanations[index],
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Anladım"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= quizQuestions.length) {
      // Sadece bir kere çalışmasını sağla
      Future.microtask(() async {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
          final docSnap = await docRef.get();
          final currentCount = docSnap.data()?['quizCompleted'] ?? 0;

          await docRef.set({
            'quizCompleted': currentCount + 1,
          }, SetOptions(merge: true));
        }
      });

      return Scaffold(
        appBar: AppBar(title: const Text("Quiz Sonucu")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Toplam Puan: $score / 100",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              for (int index = 0; index < quizQuestions.length; index++)
                _buildResultCard(index),
            ],
          ),
        ),
      );
    }

    final question = quizQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Soru ${currentIndex + 1}/${quizQuestions.length}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              question.question,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            for (int i = 0; i < question.options.length; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showFeedback
                        ? i == question.correctIndex
                            ? Colors.green
                            : i == selectedOption
                                ? Colors.red
                                : null
                        : null,
                  ),
                  onPressed: showFeedback ? null : () => handleAnswer(i),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${String.fromCharCode(65 + i)}. ${question.options[i]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(int index) {
    final question = quizQuestions[index];
    final selected = selectedAnswers[index];
    final correct = question.correctIndex;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Soru ${index + 1}: ${question.question}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.blue),
                  tooltip: "Açıklamayı Gör",
                  onPressed: () => _showExplanationDialog(index),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < question.options.length; i++)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: i == correct
                      ? Colors.green.shade100
                      : i == selected && selected != correct
                          ? Colors.red.shade100
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    "${String.fromCharCode(65 + i)}. ${question.options[i]}",
                    style: TextStyle(
                      fontWeight: i == correct ? FontWeight.bold : FontWeight.normal,
                      color: i == correct
                          ? Colors.green
                          : i == selected && selected != correct
                              ? Colors.red
                              : Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
