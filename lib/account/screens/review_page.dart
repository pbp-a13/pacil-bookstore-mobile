import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:toko_buku/account/models/review.dart';

class MemberReviewsPage extends StatefulWidget {
  const MemberReviewsPage({Key? key, required this.cookieRequest})
      : super(key: key);
  final CookieRequest cookieRequest;

  @override
  _MemberReviewsPageState createState() =>
      _MemberReviewsPageState(cookieRequest);
}

class _MemberReviewsPageState extends State<MemberReviewsPage> {
  final CookieRequest cookieRequest;
  _MemberReviewsPageState(this.cookieRequest);

  final TextEditingController _searchController = TextEditingController();
  List<Review> _reviews = [];
  List<Review> _displayReviews = [];

  @override
  void initState() {
    super.initState();
    _fetchReviews(cookieRequest);
  }

  Future<void> _fetchReviews(CookieRequest request) async {
    final data = await request.get(
      'http://localhost:8000/account/get_member_reviews/',
    );

    List<Review> reviews =
        (data as List).map((review) => Review.fromJson(review)).toList();

    setState(() {
      _reviews = reviews;
      _displayReviews = reviews;
    });
  }

  void _searchReviews(String query, String filter) {
    if (query.isEmpty) {
      setState(() {
        _displayReviews = _reviews;
      });
      return;
    }

    final searchResults = _reviews.where((review) {
      return filter == 'title'
          ? review.title.contains(query)
          : review.author.contains(query);
    }).toList();

    setState(() {
      _displayReviews = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Member Reviews',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for reviews...',
                    ),
                    onChanged: (query) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Search by'),
                          content:
                              const Text('Choose a filter for your search'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                _searchReviews(query, 'title');
                                Navigator.pop(context, 'title');
                              },
                              child: const Text('Title'),
                            ),
                            TextButton(
                              onPressed: () {
                                _searchReviews(query, 'author');
                                Navigator.pop(context, 'author');
                              },
                              child: const Text('Author'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _displayReviews.length,
                itemBuilder: (context, index) {
                  Review review = _displayReviews[index];
                  return ListTile(
                    title: Text('${review.title} - ${review.author}'),
                    subtitle: Text(review.reviewText),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
