/// Formats a timestamp as a short relative label (e.g. "2h ago", "Just now").
String formatRelativeTime(DateTime time, {DateTime? now}) {
  final reference = now ?? DateTime.now();
  final diff = reference.difference(time);

  if (diff.inSeconds < 60) {
    return 'Just now';
  }
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes}m ago';
  }
  if (diff.inHours < 24) {
    return '${diff.inHours}h ago';
  }
  if (diff.inDays == 1) {
    return 'Yesterday';
  }
  return '${diff.inDays}d ago';
}
