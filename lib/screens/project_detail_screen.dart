import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/config.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final thumbnailPath = project.thumbnail.trim();
    final baseUrl = apiBaseUrl.replaceFirst(RegExp(r'/+$'), '');
    final thumbnailUrl =
        '$baseUrl/static/${thumbnailPath.replaceFirst(RegExp(r'^/+'), '')}';

    return Scaffold(
      appBar: AppBar(title: Text(project.projectName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnailPath.isNotEmpty)
              Image.network(
                thumbnailUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Text('Gambar proyek tidak dapat dimuat.'),
              ),
            const SizedBox(height: 16),
            Text(
              project.projectName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Tagline: ${project.subheading}'),
            const SizedBox(height: 12),
            Text(project.description),
            const SizedBox(height: 12),
            SelectableText('URL proyek: ${project.projectUrl}'),
          ],
        ),
      ),
    );
  }
}
