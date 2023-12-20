import 'package:flutter/material.dart';

typedef void SubmitCallback(
    String selectedOption
);

class SortWidget extends StatefulWidget {
  final SubmitCallback onSubmit;
  const SortWidget({super.key, required this.onSubmit});

  @override
  _SortWidgetState createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  String _selectedValue = 'user';

  void collectStates() {
    String selectedOption = _selectedValue;
    widget.onSubmit(selectedOption);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    collectStates();
                    print('Submit button pressed');
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sort by', style: TextStyle(fontSize: 12.0)),
                    Row(
                      children: [
                        Radio(
                          value: 'member.user.username',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value.toString();
                            });
                          },
                        ),
                        const Text('User', style: TextStyle(fontSize: 12.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'review_text',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value.toString();
                            });
                          },
                        ),
                        const Text('Ulasan', style: TextStyle(fontSize: 12.0)),
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
