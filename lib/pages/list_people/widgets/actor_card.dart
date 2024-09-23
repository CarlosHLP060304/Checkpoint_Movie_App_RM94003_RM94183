import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/actors_details.dart';
import 'package:movie_app/pages/actor_details/actor_details_page.dart';

class TopPopularActor extends StatelessWidget {
  const TopPopularActor({
    super.key,
    required this.actor,
  });

  final Results actor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ActorDetailPage(
                  actorId: actor.id!,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Stack(
          children: [
            // Background container with a more subtle gradient
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.grey.shade900, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),

            // Actor Image with transparency overlay
            Positioned(
              left: 16,
              top: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Image.network(
                      '$imageUrl${actor.profilePath}',
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                    Container(
                      width: 100,
                      height: 140,
                      color: Colors.black.withOpacity(0.4), // Slightly darker overlay
                    ),
                  ],
                ),
              ),
            ),

            // Actor Details
            Positioned(
              left: 130,
              top: 30,
              right: 16,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actor Name with a clean font style
                  Text(
                    actor.name ?? actor.originalName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Popularity and Known For with icons
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        actor.popularity != null
                            ? actor.popularity!.toStringAsFixed(1)
                            : 'N/A',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.movie, color: Colors.blueAccent, size: 16),
                      const SizedBox(width: 4),
                      if (actor.knownFor != null && actor.knownFor!.isNotEmpty)
                        Expanded(
                          child: Text(
                            actor.knownFor![0].title ?? actor.knownFor![0].name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow Icon for navigation on the right side
            Positioned(
              right: 16,
              top: 65,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
