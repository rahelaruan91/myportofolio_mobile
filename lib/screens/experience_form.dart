import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  static const List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  String _title = '';
  String _description = '';
  String _category = '';
  DateTime? _endedAt;

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickEndDate(FormFieldState<DateTime?> field) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: field.value ?? today,
      firstDate: DateTime(1950),
      lastDate: today,
    );

    if (pickedDate != null && mounted) {
      field.didChange(pickedDate);
    }
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
          title: const Text('Ringkasan Pengalaman'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Judul: $_title'),
                const SizedBox(height: 8),
                Text('Deskripsi: $_description'),
                const SizedBox(height: 8),
                Text('Kategori: $_category'),
                const SizedBox(height: 8),
                Text(
                  'Tanggal selesai: '
                  '${_endedAt == null ? 'Masih berlangsung' : _formatDate(_endedAt!)}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _formKey.currentState?.reset();

                setState(() {
                  _title = '';
                  _description = '';
                  _category = '';
                  _endedAt = null;
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
        title: const Text('Tambah Pengalaman'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  maxLength: 255,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Judul pengalaman',
                    hintText: 'Contoh: Asisten dosen atau UI/UX Designer',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final title = value?.trim() ?? '';

                    if (title.isEmpty) {
                      return 'Judul pengalaman tidak boleh kosong.';
                    }
                    if (title.length > 255) {
                      return 'Judul maksimal 255 karakter.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!.trim();
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Ceritakan tanggung jawab atau kontribusimu.',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi tidak boleh kosong.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!.trim();
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: null,
                  decoration: const InputDecoration(
                    labelText: 'Kategori pengalaman',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih kategori pengalaman.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _category = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                FormField<DateTime?>(
                  onSaved: (value) {
                    _endedAt = value;
                  },
                  builder: (field) {
                    final selectedDate = field.value;

                    return InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Tanggal selesai (opsional)',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedDate == null
                                  ? 'Masih berlangsung'
                                  : _formatDate(selectedDate),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _pickEndDate(field),
                            icon: const Icon(Icons.calendar_month),
                            label: const Text('Pilih'),
                          ),
                          if (selectedDate != null)
                            IconButton(
                              tooltip: 'Hapus tanggal selesai',
                              onPressed: () => field.didChange(null),
                              icon: const Icon(Icons.clear),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _showSummary,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}