class Review {
  String title;
  String author;
  String reviewText;

  Review({
    required this.title,
    required this.author,
    required this.reviewText,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json['title'],
      author: json['author'],
      reviewText: json['review'],
    );
  }
}
