import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/anime.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Anime>? animes;

  void _getAnimes() async {
    const url = "https://api.jikan.moe/v4/random/anime";
    final response = await http.get(Uri.parse(url));
    final body = response.body;
    final json = jsonDecode(body);
    print(json);

    if (json is Map<String, dynamic>) {
      setState(() {
        animes = json.entries.map((e) => Anime(e.value)).toList();
      });
    }
  }

  Widget _wBody() {
    if (animes == null) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.purple));
    }
    return ListView.builder(
      itemCount: animes?.length,
      itemBuilder: (context, index) {
        final anime = animes![index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.arrow_drop_down_circle),
                title: Text('${anime.data['title']}'),
                subtitle: Text(
                  'Original : ${anime.data['titles'][1]['title']}',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ListTile(
                leading: Text("${anime.data['type']}"),
                title: Text("Status - "),
                subtitle: Text(
                  "${anime.data['status']}",
                  style: const TextStyle(color: Colors.green),
                ),
                // subtitle: Text("${anime.data['airing']}"),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${anime.data['synopsis']}',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(anime.data['images']['jpg']['image_url']),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF6200EE),
                    ),
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('See on MAL'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF6200EE),
                    ),
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Available platforms'),
                  ),
                ],
              ),
              Image.asset('assets/mobile_wallpaper.jpg'),
              Image.asset('assets/test.jpg'),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _getAnimes();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What anime today?"),
      ),
      body: _wBody(),
    );
  }
}
