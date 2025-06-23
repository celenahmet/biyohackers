class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

final List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: "Hücrede enerji üretiminden hangi organel sorumludur?",
    options: ["Ribozom", "Golgi", "Mitokondri", "Lizozom", "Koful"],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: "Bitki hücresinde bulunup hayvan hücresinde olmayan yapı nedir?",
    options: ["Koful", "Hücre zarı", "Mitokondri", "Hücre duvarı", "Çekirdek"],
    correctIndex: 3,
  ),
  QuizQuestion(
    question: "Protein sentezi hangi yapıda gerçekleşir?",
    options: ["Ribozom", "Lizozom", "Mitokondri", "Golgi", "Koful"],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: "Aşağıdakilerden hangisi çekirdeğin görevidir?",
    options: ["Sindirim", "Enerji üretimi", "Yönetim", "Paketleme", "Temizlik"],
    correctIndex: 2,
  ),
  QuizQuestion(
    question: "Golgi aygıtının görevi nedir?",
    options: ["Protein sentezi", "Paketleme", "Bölünme", "DNA taşıma", "Enerji üretimi"],
    correctIndex: 1,
  ),
];
