class Candidate {
  final int number;
  final String? id;
  final String firstname;
  final String lastname;
  final String? patronymic;

  Candidate({
    required this.number,
    required this.firstname,
    required this.lastname,
    this.patronymic,
    this.id,
  });
}
