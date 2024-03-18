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
        return ListTile(
          title: Text('${anime.data}'),
          // trailing: Icon(Icons.arrow_forward),
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
        title: const Text("List screen"),
      ),
      body: _wBody(),
    );
  }
}
