// lib/screens/issue_return_page.dart
import 'package:flutter/material.dart';

class IssueReturnPage extends StatefulWidget {
  const IssueReturnPage({Key? key}) : super(key: key);

  @override
  State<IssueReturnPage> createState() => _IssueReturnPageState();
}

class _IssueReturnPageState extends State<IssueReturnPage> {
  String? selectedBook;
  DateTime? returnDate;

  final List<String> dummyBookList = ['Clean Code', 'Flutter Basics'];

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      setState(() {
        returnDate = date;
      });
    }
  }

  void _issueBook() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Book issued successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButton<String>(
            hint: const Text('Select Book'),
            value: selectedBook,
            isExpanded: true,
            items: dummyBookList.map((book) {
              return DropdownMenuItem(value: book, child: Text(book));
            }).toList(),
            onChanged: (val) => setState(() => selectedBook = val),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _selectDate,
            child: Text(returnDate == null
                ? 'Select Return Date'
                : 'Return by: ${returnDate!.toLocal()}'.split(' ')[0]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed:
                selectedBook != null && returnDate != null ? _issueBook : null,
            child: const Text("Issue Book"),
          ),
        ],
      ),
    );
  }
}
