import 'package:flutter/material.dart';

typedef SubmitCallback = void Function(String searchText, String radioGroup1, String radioGroup2);





class MyRowWidget extends StatefulWidget {
  final SubmitCallback onSubmit;

  const MyRowWidget({super.key, required this.onSubmit});

  @override
  _MyRowWidgetState createState() => _MyRowWidgetState();


}




class _MyRowWidgetState extends State<MyRowWidget> {
  final TextEditingController _textFieldController = TextEditingController();
  String _selectedRadioValue1 = 'title';
  String _selectedRadioValue2 = 'title';


    void collectStates() {
      String searchText = _textFieldController.text;
      String radioGroup1 = _selectedRadioValue1;
      String radioGroup2 = _selectedRadioValue2;
      widget.onSubmit(searchText, radioGroup1, radioGroup2);
      // Add additional processing or sending data to server as needed
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
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(labelText: 'Search'),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    collectStates();
                    print('Submit button pressed');
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Search by', style: TextStyle(fontSize: 12.0)),
                        Row(
                          children: [
                            Radio(
                              value: 'title',
                              groupValue: _selectedRadioValue1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue1 = value.toString();
                                });
                              },
                            ),
                            const Text('Title', style: TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'author',
                              groupValue: _selectedRadioValue1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue1 = value.toString();
                                });
                              },
                            ),
                            const Text('Author', style: TextStyle(fontSize: 12.0)),
                          ],
                        ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sort by', style: TextStyle(fontSize: 12.0)),
                        Row(
                          children: [
                            Radio(
                              value: 'title',
                              groupValue: _selectedRadioValue2,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue2 = value.toString();
                                });
                              },
                            ),
                            const Text('Title', style: TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'author',
                              groupValue: _selectedRadioValue2,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue2 = value.toString();
                                });
                              },
                            ),
                            const Text('Author', style: TextStyle(fontSize: 12.0)),
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
