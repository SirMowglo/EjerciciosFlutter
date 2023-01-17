import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPoke(
                                      url: snapshot
                                          .data!.results![index].url!)));
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

class DetailPoke extends StatefulWidget {
  DetailPoke({super.key, required this.url});
  final String url;

  @override
  State<DetailPoke> createState() => _DetailPokeState();
}

class _DetailPokeState extends State<DetailPoke> {
  late Future<PokeDetails> details;

  @override
  void initState() {
    super.initState();
    details = fetchDetails(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Los Pokemone"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10.0, bottom: 10.0),
          child: FutureBuilder<PokeDetails>(
              future: details,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 241, 196),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(children: [
                      Text(
                        StringUtils.capitalize(snapshot.data!.name!),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        '#${snapshot.data!.id}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(
                                snapshot.data!.sprites!.frontDefault!),
                          ),
                          Image(
                            image: NetworkImage(
                                snapshot.data!.sprites!.frontShiny!),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tipos: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (snapshot.data!.types.isNotEmpty)
                            Text(StringUtils.capitalize(
                                snapshot.data!.types[0].type!.name!)),
                          if (snapshot.data!.types.length > 1)
                            const SizedBox(width: 10),
                          if (snapshot.data!.types.length > 1)
                            Text(StringUtils.capitalize(
                                snapshot.data!.types[1].type!.name!)),
                        ],
                      ),
                    ]),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}
