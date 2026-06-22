import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/theme/pulse_theme.dart';
import 'package:pulse/features/auth/data/session_record.dart';
import 'package:pulse/features/profile/edit_profile_screen.dart';
import 'package:pulse/features/user/data/user_profile.dart';

import '../../support/test_dependencies.dart';

void main() {
  testWidgets('saves profile changes and returns updated profile', (tester) async {
    const initialProfile = UserProfile(
      id: 'user-1',
      email: 'dev@pulse.test',
      username: 'devuser',
      bio: 'Hello',
    );

    UserProfile? result;
    final deps = buildTestDependencies(
      (request) async {
        if (request.method == 'PUT' && request.url.path == '/api/users/me') {
          return jsonResponse(
            '{"id":"user-1","email":"dev@pulse.test","username":"newname","bio":"Updated bio"}',
          );
        }
        return jsonResponse('{}', status: 404);
      },
      session: SessionRecord(
        userId: 'user-1',
        email: 'dev@pulse.test',
        username: 'devuser',
        token: 'jwt-token',
        savedAt: DateTime.utc(2026, 6, 15, 10),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: PulseTheme.light(),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () async {
                    result = await Navigator.of(context).push<UserProfile>(
                      MaterialPageRoute<UserProfile>(
                        builder: (_) => EditProfileScreen(
                          initialProfile: initialProfile,
                          userService: deps.userService,
                        ),
                      ),
                    );
                  },
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'newname');
    await tester.enterText(find.byType(TextFormField).at(1), 'Updated bio');
    await tester.tap(find.widgetWithText(FilledButton, 'Save changes'));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.username, 'newname');
    expect(result!.bio, 'Updated bio');
  });
}
