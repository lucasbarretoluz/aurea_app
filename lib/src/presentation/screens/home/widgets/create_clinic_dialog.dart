import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:flutter/material.dart';

class CreateClinicDialog extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String? initialName;
  final Future<void> Function(String name) onSubmit;

  const CreateClinicDialog({
    super.key,
    this.title = 'Criar clínica',
    this.confirmLabel = 'Criar',
    this.initialName,
    required this.onSubmit,
  });

  static Future<String?> show({
    required BuildContext context,
    required Future<void> Function(String name) onSubmit,
    String title = 'Criar clínica',
    String confirmLabel = 'Criar',
    String? initialName,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => CreateClinicDialog(
        title: title,
        confirmLabel: confirmLabel,
        initialName: initialName,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<CreateClinicDialog> createState() => _CreateClinicDialogState();
}

class _CreateClinicDialogState extends State<CreateClinicDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _isLoading) return;

    final name = _controller.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await widget.onSubmit(name);
      if (!mounted) return;
      Navigator.of(context).pop(name);
    } on RepositoryException catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Não foi possível salvar a clínica';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isLoading,
      child: AlertDialog(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controller,
                autofocus: true,
                enabled: !_isLoading,
                decoration: const InputDecoration(
                  labelText: 'Nome da clínica',
                  hintText: 'Ex.: Clínica Sorriso',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome da clínica';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(widget.confirmLabel),
          ),
        ],
      ),
    );
  }
}
