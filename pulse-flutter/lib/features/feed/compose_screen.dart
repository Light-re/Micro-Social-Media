import 'package:flutter/material.dart';

import '../../core/widgets/pulse_components.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  String _draft = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('New post'),
        actions: [
          TextButton(
            onPressed: _draft.trim().isEmpty
                ? null
                : () => Navigator.of(context).pop(),
            child: const Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: TextField(
          autofocus: true,
          maxLines: null,
          expands: true,
          onChanged: (value) => setState(() => _draft = value),
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'What\'s on your mind?',
          ),
        ),
      ),
    );
  }
}
