import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

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
  bool _isSubmitting = false;

  String? _requiredValidator(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi.';
    }
    return null;
  }

  String? _urlValidator(String? value, {bool optional = false}) {
    final url = value?.trim() ?? '';
    if (url.isEmpty && optional) return null;
    if (url.isEmpty) return 'URL proyek wajib diisi.';

    final uri = Uri.tryParse(url);
    final valid =
        uri != null &&
        const ['http', 'https'].contains(uri.scheme.toLowerCase()) &&
        uri.host.isNotEmpty;

    return valid ? null : 'Masukkan URL lengkap http:// atau https://.';
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    final allowed = await ensureLoggedIn(context);
    if (!mounted || !allowed) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isSubmitting = true);

    try {
      await context.read<ApiClient>().createProject(
        Project(
          projectName: _projectName,
          subheading: _subheading,
          description: _description,
          thumbnail: _thumbnail,
          projectUrl: _projectUrl,
        ),
        token: token,
      );

      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan'),
          content: Text('“$_projectName” sudah dikirim ke server.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      _formKey.currentState?.reset();
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan proyek (HTTP ${error.statusCode}).'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat terhubung ke server.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Proyek')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _projectName = value!.trim(),
              validator: (value) => _requiredValidator(value, 'Title'),
            ),
            const SizedBox(height: 12),

            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Tagline',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _subheading = value!.trim(),
              validator: (value) => _requiredValidator(value, 'Tagline'),
            ),
            const SizedBox(height: 12),

            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _description = value!.trim(),
              validator: (value) => _requiredValidator(value, 'Description'),
            ),
            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project URL',
                hintText: 'https://contoh.com',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _projectUrl = value!.trim(),
              validator: _urlValidator,
            ),
            const SizedBox(height: 12),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Thumbnail',
                hintText: 'img/medivoice-preview.png',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _thumbnail = value?.trim() ?? '',
              validator: (value) => _requiredValidator(value, 'Thumbnail'),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
