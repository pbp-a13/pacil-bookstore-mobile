class Review {
  String title;
  String author;
  String reviewText;
  String username;
  String memberName;
  int rating;

  Review({
    required this.title,
    required this.author,
    required this.reviewText,
    required this.username,
    required this.memberName,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json['title'],
      author: json['author'],
      reviewText: json['review'],
      username: json['member']['user']['usernama'],
      memberName: json['member']['nama'],
      rating: json['book']['rating'],
    );
  }
}
