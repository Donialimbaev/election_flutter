class Party {
  final int number;
  final id;
  final String titleKyrgyz;
  final String titleRussian;
  final String? image;

  Party({
    required this.number,
    required this.titleKyrgyz,
    required this.titleRussian,
    this.image,
    this.id,
  });
}
