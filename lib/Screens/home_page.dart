import 'package:flutter/material.dart';
import 'package:interntask/Screens/detail_page.dart';
import '../Models/post.dart';
import '../Services/api_service.dart';
import 'bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> futurePosts;
  int selectedIndex = 0;

  final List<String> userNames = [
    "Sophia Bennett",
    "Ethan Carter",
    "Olivia Davis",
    "Liam Foster",
    "Ava Green",
    "Noah Harris",
    "Emma Wilson",
    "Oliver King",
    "Charlotte Lee",
    "James Miller",
  ];

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService.fetchPosts();
  }

  void onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Threads',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              print('Add icon pressed');
            },
          ),
        ],
      ),
      body: selectedIndex == 0
          ? FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                final userName = userNames[index % userNames.length];
                return PostCard(
                  post: post,
                  userName: userName,
                  index: index,
                );
              },
            );
          }
        },
      )
          : Center(
        child: Text(
          ['Home', 'Search', 'Add', 'Favorites', 'Profile'][selectedIndex],
          style: const TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: selectedIndex,
        onTap: onNavItemTapped,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final String userName;
  final int index;

  const PostCard({
    super.key,
    required this.post,
    required this.userName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(post: post, userName: userName),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(post.body, style: const TextStyle(fontSize: 14, color: Colors.blue)),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${index % 3 + 1}d',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
