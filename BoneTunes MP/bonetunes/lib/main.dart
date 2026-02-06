import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BoneTunesApp());
}

class BoneTunesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoneTunes',
      theme: ThemeData.dark(),
      home: MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  @override
  _MusicHomePageState createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final TextEditingController _pathController = TextEditingController();

  Future<void> _playSong() async {
    final path = _pathController.text;
    final url = Uri.parse('http://127.0.0.1:8000/play?path=$path');
    try {
      await http.post(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Playing: $path')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BoneTunes')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _pathController,
              decoration: InputDecoration(
                labelText: 'Path to song',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playSong,
              child: Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
