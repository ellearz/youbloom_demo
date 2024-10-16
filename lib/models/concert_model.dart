class Concert {
  final String title;
  final String date;
  final String description;
  final String imagePath;

  Concert({required this.title, required this.date, required this.description, required this.imagePath});

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      title: json['title'] as String,
      description : json['description'] as String,
      date: json['date'] as String,
      imagePath: json['photo'] as String,
     
    );
  }
}