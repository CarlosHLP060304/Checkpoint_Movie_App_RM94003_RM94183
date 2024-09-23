import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/actor_details.dart';
import 'package:movie_app/services/api_services.dart';

class ActorDetailPage extends StatefulWidget {
  final int actorId;
  const ActorDetailPage({super.key, required this.actorId});

  @override
  State<ActorDetailPage> createState() => _ActorDetailPageState();
}

class _ActorDetailPageState extends State<ActorDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<ActorResults> actorDetail;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    actorDetail = apiServices.getActorDetails(widget.actorId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: actorDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final actor = snapshot.data;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage("$imageUrl${actor!.profilePath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 20,
                            child: SafeArea(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Actor Details Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              actor.name!,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Birthday and Place
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoChip(Icons.cake, 'Birthday', actor.birthday ?? 'N/A'),
                                _buildInfoChip(Icons.location_on, 'Place', actor.placeOfBirth ?? 'N/A'),
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Biography
                            Text(
                              'Biography',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              actor.biography!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Actor Movies Section (you can add more details here)
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  // Custom Chip for Actor Info
  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Chip(
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      avatar: Icon(icon, size: 18, color: Colors.blueAccent),
      label: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
