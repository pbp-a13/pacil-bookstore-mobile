import 'package:flutter/material.dart';

// REVIEW SORT BELUM

typedef void SubmitCallback(String radioGroup);

class FilteredReviewWidget extends StatefulWidget {
  final SubmitCallback onSubmit;

  FilteredReviewWidget({required this.onSubmit});

  @override
  _FilteredReviewWidgetState createState() => _FilteredReviewWidgetState();
}

class _FilteredReviewWidgetState extends State<FilteredReviewWidget> {
  TextEditingController _textFieldController = TextEditingController();
  String _selectedRadioValue = 'rating';

    void collectStates() {
      String radioGroup = _selectedRadioValue;
      widget.onSubmit(radioGroup);
      // Add additional processing or sending data to server as needed
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sort by', style: TextStyle(fontSize: 12.0)),
                      Row(
                        children: [
                          Radio(
                            value: 'rating',
                            groupValue: _selectedRadioValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadioValue = value.toString();
                              });
                            },
                          ),
                          Text('High to Low', style: TextStyle(fontSize: 12.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'rating',
                            groupValue: _selectedRadioValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadioValue = value.toString();
                              });
                            },
                          ),
                          Text('Low to High', style: TextStyle(fontSize: 12.0)),
                        ],
                        ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
