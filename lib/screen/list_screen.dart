import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * PACKAGES
 * url_launcher
 * font awesome
 * shared preferences
 * material
 *
 * DOCS
 * https://stackoverflow.com/questions/55294676/how-to-put-opacity-for-container-in-flutter
 * https://stackoverflow.com/questions/44179889/how-do-i-set-background-image-in-flutter
 * https://api.flutter.dev/flutter/dart-core/DateTime/parse.html
 * https://flutterbyexample.com/lesson/ternary-conditional-operator
 * API
 * https://api.jikan.moe/v4/random/anime
 */
import '../model/anime.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Anime>? animes;
  late final String animeUrl;
  late final String? youtubeUrl;
  late final String episodes =
      animes?[i].data['episodes'] > 1 ? 'episodes' : 'episode';
  late final int counter = 0;
  // late final String parsedDateFrom = animes?[i].data['aired']['prop']['from'] + "hi";
  // late final String dateFrom = parsedDateFrom;
  // late final String dateTo = animes?[i].data['aired']['to'];

  get i => 0;

  late int actualCounter = 0;

  void _getAnimes() async {
    const url = "https://api.jikan.moe/v4/random/anime";
    final response = await http.get(Uri.parse(url));
    final body = response.body;
    final json = jsonDecode(body);

    if (json is Map<String, dynamic>) {
      setState(() {
        animes = json.entries.map((e) => Anime(e.value)).toList();
        animeUrl = animes?[i].data['url'];
        youtubeUrl = animes?[i].data['trailer']?['url'];
      });
    }
  }

  incrementCounterToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter+1);
  }

  getCounterFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    actualCounter = prefs.getInt('counter') ?? 0;
    });
  }
  _visitMalUrl() async {
    final Uri url = Uri.parse(animeUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url, may not exist');
    }
  }

  _visitYoutubeUrl() async {
    if (youtubeUrl != null) {
      final Uri url = Uri.parse(youtubeUrl!);
      if (!await launchUrl(url)) {
        throw Exception(
            'Could not launch $url, may not exist for this resource');
      }
    }
    //   https://stackoverflow.com/questions/69251294/a-value-of-type-string-cant-be-assign-to-variable-of-type-string-flutter
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
          color: Colors.white.withOpacity(0.7),
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: const FaIcon(FontAwesomeIcons.youtube),
                    onPressed: () {
                      _visitYoutubeUrl();
                    }),
                title: Text('${anime.data['title']}'),
                subtitle: Text(
                  'Original : ${anime.data['titles'][1]['title']}',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Text("Fetch count : $actualCounter"),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Text("${anime.data['type']}"),
                      title: const Text("Status - "),
                      subtitle: Text(
                        "${anime.data['status']}",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(FontAwesomeIcons.tv),
                      title: Text('${anime.data['episodes']} $episodes'),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     'Aired from $dateFrom to $dateTo',
              //     style: TextStyle(color: Colors.black.withOpacity(0.9)),
              //   ),
              // ),
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
                      _visitMalUrl();
                    },
                    // https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget
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
    incrementCounterToSF();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What anime today?"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/mobile_wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: _wBody(),
        ));
  }
}
