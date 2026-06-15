import 'package:flutter/material.dart';

import '../../core/di/app_scope.dart';
import '../../core/network/api_exception.dart';
import 'feed_service.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      !_isSubmitting && _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
        ),
        title: const Text('New post'),
        actions: [
          TextButton(
            onPressed: _canSubmit ? _submit : null,
            child: _isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: TextField(
          controller: _controller,
          autofocus: true,
          maxLines: null,
          expands: true,
          enabled: !_isSubmitting,
          onChanged: (_) => setState(() {}),
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'What\'s on your mind?',
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final FeedService feedService = AppScope.of(context).feedService;
    setState(() => _isSubmitting = true);
    try {
      await feedService.createPost(_controller.text);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }
}
