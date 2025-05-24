import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interntask/Models/post.dart';

class DetailPage extends StatelessWidget {
  final Post post;
  final String userName;

  const DetailPage({super.key, required this.post, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(post.body, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.favorite_border, size: 20),
                const SizedBox(width: 4),
                const Text('67'),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline, size: 20),
                const SizedBox(width: 4),
                const Text('32'),
                const SizedBox(width: 16),
                const Icon(Icons.repeat, size: 20),
                const SizedBox(width: 4),
                const Text('5'),
              ],
            ),
            const Divider(height: 32),
            Container(
              width: 170,
              height: 40,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Most Relevant',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(CupertinoIcons.down_arrow),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildComment(
              name: 'Sophia Clark',
              date: 'Nov 12',
              comment: 'Sounds amazing! Where exactly did you go?',
              likes: 25,
              replies: 2,
            ),
            _buildComment(
              name: 'Ethan Carter',
              date: 'Nov 12',
              comment: 'I\'m so jealous! I need a break too.',
              likes: 18,
              replies: 1,
            ),
            _buildComment(
              name: 'Olivia Bennett',
              date: 'Nov 12',
              comment: 'The mountains are calling, and I must go!',
              likes: 30,
              replies: 3,
            ),
            const SizedBox(height: 80), // Extra spacing to avoid overlap with fixed input
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.image_outlined),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment({
    required String name,
    required String date,
    required String comment,
    required int likes,
    required int replies,
  }) {
    return Row(
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
              Row(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(comment),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.thumb_up_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(likes.toString()),
                  const SizedBox(width: 16),
                  const Icon(Icons.thumb_down_off_alt_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(replies.toString()),
                ],
              ),
              const Divider(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
