import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.purple[300], // Adjust this value based on exact color needed
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red[400], // Border Color
                child: const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/zar.jpeg'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'GM khurram Ghazi',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const Center(
              child: Text(
                'Joined Sep 2023',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quote of the day',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            const SizedBox(height: 8),
            const Text(
              'The time we spend apart is precious. But so is the time we are together.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              '- LeBron James',
              style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text('ZEN MASTER', style: TextStyle(color: Colors.orange)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.history, color: Colors.blue),
                    Text('HISTORY', style: TextStyle(color: Colors.blue)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_upward, color: Colors.purple),
                    Text('LV 5', style: TextStyle(color: Colors.purple)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('23',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Completed Sessions'),
                  ],
                ),
                Column(
                  children: [
                    Text('94',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Minutes Total'),
                  ],
                ),
                Column(
                  children: [
                    Text('15',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Days Longest Streak'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Background color
                ),
                child: const Text('Share My Stats',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
