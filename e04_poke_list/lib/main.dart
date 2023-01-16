import 'dart:convert';

import 'package:e04_poke_list/poke_details.dart';
import 'package:e04_poke_list/poke_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<PokemonResponse> futurePoke;

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
            child: FutureBuilder<PokemonResponse>(
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
                          Future<PokeDetails> prueba = fetchDetails(snapshot.data!.results![index].url!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPoke(
                                      details: prueba)));
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

  String pokemonEntry(String url) {
    String result = url.split('/').reversed.elementAt(1);

    return result;
  }
}

Future<PokemonResponse> fetchPoke() async {
  final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#39'));

  PokemonResponse pokelist;

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

class DetailPoke extends StatelessWidget {
  DetailPoke({super.key, required this.details});
  final Future<PokeDetails> details;

  @override
  Widget build(BuildContext context) {
    const title = "Los pokemone";
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: FutureBuilder<PokeDetails>(
              future: details,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.types!.first!.type!.name!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}
