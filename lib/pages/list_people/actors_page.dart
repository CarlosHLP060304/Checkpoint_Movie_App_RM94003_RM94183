import 'package:flutter/material.dart';
import 'package:movie_app/models/actors_details.dart';

import 'package:movie_app/services/api_services.dart';

import 'widgets/actor_card.dart';

class ActorsPage extends StatefulWidget {
  const ActorsPage({super.key});

  @override
  State<ActorsPage> createState() => _ActorsPageState();
}

class _ActorsPageState extends State<ActorsPage> {
  ApiServices apiServices = ApiServices();
  late Future<ActorsResult> popularActorsFuture;

  @override
  void initState() {
    popularActorsFuture = apiServices.getActors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Popular Actors'),
      ),
      body: FutureBuilder<ActorsResult>(
        future: popularActorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                var actor = snapshot.data!.results![index];
                return TopPopularActor(actor: actor);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}