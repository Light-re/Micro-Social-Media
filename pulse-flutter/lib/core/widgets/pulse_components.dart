import 'package:flutter/material.dart';

import '../theme/pulse_colors.dart';

class PulseButton extends StatelessWidget {
  const PulseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(onPressed: onPressed, child: Text(label));
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class PulseTextField extends StatelessWidget {
  const PulseTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.controller,
    this.validator,
  });

  final String label;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration();
    final style = Theme.of(context).textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        if (validator != null)
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            onChanged: onChanged,
            validator: validator,
            cursorColor: PulseColors.coral,
            style: style,
            decoration: decoration,
          )
        else
          TextField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            onChanged: onChanged,
            cursorColor: PulseColors.coral,
            style: style,
            decoration: decoration,
          ),
      ],
    );
  }
}

class PulseAvatar extends StatelessWidget {
  const PulseAvatar({super.key, required this.username, this.radius = 22});

  final String username;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: PulseColors.coral.withValues(alpha: 0.18),
      foregroundColor: PulseColors.coral,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.78,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Presentational post card. All behaviour is delegated through callbacks so
/// the widget never talks to services or repositories directly.
class PulsePostCard extends StatelessWidget {
  const PulsePostCard({
    super.key,
    required this.username,
    required this.displayName,
    required this.timestamp,
    required this.text,
    required this.likeCount,
    this.commentCount = 0,
    this.likedByMe = false,
    this.isLikeInFlight = false,
    this.canDelete = false,
    this.onAuthorTap,
    this.onLikeTap,
    this.onCommentTap,
    this.onDeleteTap,
  });

  final String username;
  final String displayName;
  final String timestamp;
  final String text;
  final int likeCount;
  final int commentCount;
  final bool likedByMe;
  final bool isLikeInFlight;
  final bool canDelete;
  final VoidCallback? onAuthorTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.labelMedium;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              username: username,
              displayName: displayName,
              timestamp: timestamp,
              muted: muted,
              onAuthorTap: onAuthorTap,
              canDelete: canDelete,
              onDeleteTap: onDeleteTap,
            ),
            const SizedBox(height: 14),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 14),
            Row(
              children: [
                _LikeButton(
                  likeCount: likeCount,
                  likedByMe: likedByMe,
                  isInFlight: isLikeInFlight,
                  muted: muted,
                  onTap: onLikeTap,
                ),
                const SizedBox(width: 20),
                _CommentButton(
                  commentCount: commentCount,
                  muted: muted,
                  onTap: onCommentTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.username,
    required this.displayName,
    required this.timestamp,
    required this.muted,
    required this.onAuthorTap,
    required this.canDelete,
    required this.onDeleteTap,
  });

  final String username;
  final String displayName;
  final String timestamp;
  final TextStyle? muted;
  final VoidCallback? onAuthorTap;
  final bool canDelete;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PulseAvatar(username: username),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onAuthorTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName,
                    style: Theme.of(context).textTheme.titleMedium),
                Text('@$username · $timestamp', style: muted),
              ],
            ),
          ),
        ),
        if (canDelete)
          IconButton(
            tooltip: 'Delete post',
            icon: const Icon(Icons.more_horiz_rounded, size: 22),
            onPressed: onDeleteTap,
          ),
      ],
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton({
    required this.likeCount,
    required this.likedByMe,
    required this.isInFlight,
    required this.muted,
    required this.onTap,
  });

  final int likeCount;
  final bool likedByMe;
  final bool isInFlight;
  final TextStyle? muted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isInFlight ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              likedByMe
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 20,
              color: PulseColors.coral.withValues(alpha: likedByMe ? 1 : 0.9),
            ),
            const SizedBox(width: 6),
            Text(likeCount == 1 ? '1 like' : '$likeCount likes', style: muted),
          ],
        ),
      ),
    );
  }
}

class _CommentButton extends StatelessWidget {
  const _CommentButton({
    required this.commentCount,
    required this.muted,
    required this.onTap,
  });

  final int commentCount;
  final TextStyle? muted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mode_comment_outlined,
              size: 19,
              color: PulseColors.coral.withValues(alpha: 0.9),
            ),
            const SizedBox(width: 6),
            Text(
              commentCount == 1 ? '1 comment' : '$commentCount comments',
              style: muted,
            ),
          ],
        ),
      ),
    );
  }
}
