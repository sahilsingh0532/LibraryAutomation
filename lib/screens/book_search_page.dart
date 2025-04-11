// lib/screens/book_search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/book.dart';
import '../services/book_services.dart';

class BookSearchPage extends StatefulWidget {
  final List<Book> initialResults;

  const BookSearchPage({Key? key, this.initialResults = const []})
      : super(key: key);

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  late List<Book> _results;
  final TextEditingController _searchController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _results = widget.initialResults;
  }

  Future<void> _search() async {
    final q = _searchController.text.trim();
    if (q.isEmpty) return;
    setState(() => _loading = true);
    _results = await BookService.searchBooksMongo(q);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for books...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white70,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => _search(),
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 16),
          if (_loading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, i) {
                  final book = _results[i];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      trailing: Icon(
                        book.available ? Icons.check_circle : Icons.cancel,
                        color: book.available ? Colors.green : Colors.red,
                      ),
                    ).animate().slideX(duration: 300.ms),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
