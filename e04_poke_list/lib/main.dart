import 'dart:convert';

import 'package:e04_poke_list/poke_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonResponse {
  int? count;
  String? next;
  Null previous;
  List<Results>? results;

  PokemonResponse({this.count, this.next, this.previous, this.results});

  PokemonResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? name;
  String? url;

  Results({this.name, this.url});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<dynamic> futurePoke;

  @override
  void initState() {
    super.initState();
    futurePoke = fetchPoke();
  }

  @override
  Widget build(BuildContext context) {
    const title = "Los pokemone";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder<dynamic>(
              future: futurePoke,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.results!.length,
                    prototypeItem: ListTile(
                      title: Text(snapshot.data!.results!.first.name!),
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.results![index].name!),
                        onTap: () {
                          //TODO: que haga un fetch de la informacion y que pase los detalles de pokemon
                          //PokeDetails amigo = fetchDetails(snapshot.data!.results![index].url!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPoke(
                                      details: 
                                      )
                                    )
                                  );
                        },
                        leading: Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/${pokemonEntry(snapshot.data!.results![index].url!)}.png'),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          )),
    );
  }

  Future<dynamic> fetchPoke() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#39'));

    dynamic pokelist;

    if (response.statusCode == 200) {
      pokelist = PokemonResponse.fromJson(jsonDecode(response.body));
      return pokelist;
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<PokeDetails> fetchDetails(url) async {
    final response = await http.get(Uri.parse(url));

    PokeDetails details;

    if (response.statusCode == 200) {
      details = PokeDetails.fromJson(jsonDecode(response.body));
      return details;
    } else {
      throw Exception('Failed to load Details');
    }
  }

  String pokemonEntry(String url) {
    String result = url.split('/').reversed.elementAt(1);

    return result;
  }
}

class DetailPoke extends StatelessWidget {
  const DetailPoke({super.key, required this.details});

  final PokeDetails details;

  @override
  Widget build(BuildContext context) {
    const title = "Los pokemone";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(details.types!.first!.type!.name!),
      ),
    );
  }
}
