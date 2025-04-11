// lib/models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final bool available;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.available,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: (map['_id'] as dynamic).toHexString(),
      title: map['title'] as String? ?? '',
      author: map['author'] as String? ?? '',
      available: map['available'] as bool? ?? false,
    );
  }

  /// 5 sample books for testing / initial data
  static List<Book> samples = [
    Book(
      id: '1',
      title: 'Clean Code',
      author: 'Robert C. Martin',
      available: true,
    ),
    Book(
      id: '2',
      title: 'The Pragmatic Programmer',
      author: 'Andrew Hunt & David Thomas',
      available: true,
    ),
    Book(
      id: '3',
      title: 'Flutter in Action',
      author: 'Eric Windmill',
      available: false,
    ),
    Book(
      id: '4',
      title: 'Introduction to Algorithms',
      author: 'Cormen, Leiserson, Rivest, Stein',
      available: true,
    ),
    Book(
      id: '5',
      title: 'Design Patterns',
      author: 'Erich Gamma et al.',
      available: false,
    ),
  ];
}
