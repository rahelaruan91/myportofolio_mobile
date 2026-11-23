import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = "";
  String _subheading = "";
  String _description = "";
  String _thumbnail = "";
  String _projectUrl = "";

  String? _requiredTextValidator(
    String? value,
    String fieldName, {
    int? maxLength,
  }) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return '$fieldName tidak boleh kosong.';
    }

    if (maxLength != null && text.length > maxLength) {
      return '$fieldName maksimal $maxLength karakter.';
    }

    return null;
  }

  String? _projectUrlValidator(String? value) {
    final url = value?.trim() ?? '';

    if (url.isEmpty) {
      return 'Link proyek tidak boleh kosong.';
    }

    if (url.length > 200) {
      return 'Link proyek maksimal 200 karakter.';
    }

    final uri = Uri.tryParse(url);
    final isHttpUrl = uri != null &&
        uri.hasScheme &&
        ['http', 'https'].contains(uri.scheme.toLowerCase()) &&
        uri.host.isNotEmpty;

    if (!isHttpUrl) {
      return 'Masukkan URL lengkap yang diawali http:// atau https://.';
    }

    return null;
  }

  void _showSummary() {
    final formState = _formKey.currentState;

    if (formState == null || !formState.validate()) {
      return;
    }

    formState.save();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Ringkasan Proyek'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nama Proyek: $_projectName'),
                const SizedBox(height: 8),
                Text('Tagline Proyek: $_subheading'),
                const SizedBox(height: 8),
                Text('Deskripsi Proyek: $_description'),
                const SizedBox(height: 8),
                Text('Gambar Proyek: $_thumbnail'),
                const SizedBox(height: 8),
                Text('Link Proyek: $_projectUrl'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _formKey.currentState?.reset();

                setState(() {
                  _projectName = '';
                  _subheading = '';
                  _description = '';
                  _thumbnail = '';
                  _projectUrl = '';
                });
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Project Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Project Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nama Proyek",
                    hintText: "Masukkan Nama Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectName = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              
              // === Subheading ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Tagline Proyek",
                    hintText: "Masukkan Tagline Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _subheading = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tagline proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Deskripsi Proyek",
                    hintText: "Masukkan Deskripsi Proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Gambar Proyek ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: img/medivoice-preview.png",
                    labelText: "Gambar Proyek",
                    helperText: 'Masukkan path gambar seperti pada website.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Gambar proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Link Proyek ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Tautan Proyek",
                    hintText: "https://contoh.com/proyek",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectUrl = value?.trim() ?? '';
                    });
                  },
                  validator: (String? value) {
                    final url = value?.trim() ?? '';

                    if (url.isEmpty) {
                      return 'Link proyek tidak boleh kosong!';
                    }

                    final uri = Uri.tryParse(url);
                    if (uri == null ||
                        !uri.hasScheme ||
                        !['http', 'https'].contains(uri.scheme.toLowerCase()) ||
                        uri.host.isEmpty) {
                      return 'Masukkan URL lengkap yang diawali http:// atau https://.';
                    }

                    return null;
                  },
                ),
              ),
            
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Proyek berhasil ditambahkan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Proyek: $_projectName'),
                                    Text('Tagline: $_description'),
                                    Text('Deskripsi: $_description'),
                                    Text('Gambar Proyek: $_thumbnail'),
                                    Text(
                                      'Tautan: ${_projectUrl.isEmpty ? "Belum diisi" : _projectUrl}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}