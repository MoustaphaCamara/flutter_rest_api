typedef Json = Map<String, dynamic>;

class Anime {
  final dynamic data;

  Anime(this.data);

  Anime.fromJson(Json json) : data = json['data'];
}
