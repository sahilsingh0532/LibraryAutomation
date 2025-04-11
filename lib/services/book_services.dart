// lib/services/book_service.dart
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_app/models/book.dart';

class BookService {
  // Replace with your actual MongoDB connection string
  static const String _mongoUri =
      'mongodb+srv://<username>:<password>@cluster0.mongodb.net/library?retryWrites=true&w=majority';
  static const String _collectionName = 'books';

  /// Searches the MongoDB 'books' collection for titles/authors matching [query].
  static Future<List<Book>> searchBooksMongo(String query) async {
    final db = Db(_mongoUri);
    await db.open();
    final coll = db.collection(_collectionName);

    // Case-insensitive regex search on title or author
    final regex = BsonRegexp(query, caseInsensitive: true);
    final results = await coll
        .find(
          where
              .or([
                where.match('title', regex as String),
                where.match('author', regex as String),
              ] as SelectorBuilder)
              .limit(50),
        )
        .toList();

    await db.close();

    // Map MongoDB documents to Book models
    return results.map((doc) => Book.fromMap(doc)).toList();
  }
}
