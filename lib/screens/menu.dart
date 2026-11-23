import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506598513';
  final String nama = 'Rahel Meilinda Aruan';
  final String kelas = 'PBP F';

  final List<ItemHomepage> items = const [
    ItemHomepage(
      name: 'Lihat Proyek',
      icon: Icons.folder_open,
      color: Colors.indigo,
    ),
    ItemHomepage(
      name: 'Tambah Pengalaman',
      icon: Icons.work,
      color: Colors.teal,
    ),
    ItemHomepage(
      name: 'Tentang Saya',
      icon: Icons.person,
      color: Colors.deepOrange,
    ),
    ItemHomepage(
      name: 'Tambah Proyek',
      icon: Icons.create_new_folder,
      color: Color.fromARGB(255, 157, 181, 63),
    ),
    ItemHomepage(
      name: 'Logout',
      icon: Icons.logout,
      color: Color.fromARGB(255, 200, 55, 55),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(title: 'NPM', content: npm),
                      InfoCard(title: 'Nama', content: nama),
                      InfoCard(title: 'Kelas', content: kelas),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Selamat datang di MyPortofolio Mobile!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: screenWidth < 360 ? 0.75 : 1.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: items.map((item) {
                      return ItemCard(
                        item: item,
                        onTap: () {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text('Kamu telah menekan tombol ${item.name}!',),
                              ),
                            );
                          // Navigate ke halaman yang sesuai
                          if (item.name == "Tambah Proyek") {
                            // TODO: Gunakan Navigator.push() untuk melakukan navigasi ke MaterialPageRoute yang mencakup ProjectFormPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProjectFormPage(),
                              ),
                            );
                          }
                          if (item.name == "Tambah Pengalaman") {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const ExperienceFormPage(),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        ((screenWidth - 56) / 3).clamp(48.0, 160.0).toDouble();

    return Card(
      elevation: 2,
      child: SizedBox(
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage({
    required this.name,
    required this.icon,
    required this.color,
  });
}