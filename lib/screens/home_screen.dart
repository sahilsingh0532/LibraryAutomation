// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/book.dart';
import '../services/book_services.dart';
import 'book_search_page.dart';
import 'issue_return_page.dart';
import 'profile_screen.dart';
import 'settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSearch(String query) async {
    setState(() => _isLoading = true);
    if (query.trim().isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = await BookService.searchBooksMongo(query);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? Colors.purpleAccent : Colors.lightBlueAccent;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Library Dashboard')
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.5, duration: 600.ms),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Animated background
          AnimatedContainer(
            duration: 3.seconds,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.deepPurple, Colors.black]
                    : [Colors.blue.shade200, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Column(
            children: [
              // Search bar (only on Search tab)
              if (_currentIndex == 0)
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, kToolbarHeight + 16, 16, 8),
                )
              else
                SizedBox(height: kToolbarHeight + 24),

              // Content area
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          BookSearchPage(initialResults: _searchResults),
                          const IssueReturnPage(),
                          const ProfileScreen(),
                          const SettingsPage(),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: accent,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.3),
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: 400.ms,
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Issue/Return'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
