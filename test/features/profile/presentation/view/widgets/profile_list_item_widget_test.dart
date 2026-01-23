import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ProfileListItem Widget Tests", () {
    testWidgets("displays title correctly", (WidgetTester tester) async {
      // Arrange
      const testTitle = "My Account";

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(icon: Icons.person, title: testTitle),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets("displays Material Icon when icon is provided", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(icon: Icons.settings, title: "Settings"),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets("displays SVG icon when iconPath is provided", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                iconPath: "assets/icons/icon.svg",
                title: "Profile",
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets("shows default chevron when trailing is null", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.person,
                title: "Account",
                trailing: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets("shows custom trailing widget when provided", (
      WidgetTester tester,
    ) async {
      // Arrange
      const customTrailing = Icon(Icons.star, key: Key('custom_trailing'));

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.person,
                title: "Premium",
                trailing: customTrailing,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('custom_trailing')), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      // chevron should not be present when custom trailing is provided
      expect(find.byIcon(Icons.chevron_right), findsNothing);
    });

    testWidgets("calls onTap callback when tapped", (
      WidgetTester tester,
    ) async {
      // Arrange
      bool tapped = false;

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.person,
                title: "Account",
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      // Tap the item
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Assert
      expect(tapped, true);
    });

    testWidgets("uses custom iconColor when provided", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.logout,
                title: "Logout",
                iconColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      // Assert
      final iconFinder = find.byIcon(Icons.logout);
      expect(iconFinder, findsOneWidget);

      final Icon iconWidget = tester.widget(iconFinder);
      expect(iconWidget.color, Colors.red);
    });

    testWidgets("renders within Row layout", (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(icon: Icons.person, title: "Account"),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets("title expands to fill available space", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.person,
                title: "Very Long Account Title That Should Expand",
              ),
            ),
          ),
        ),
      );

      // Assert - find Expanded widget wrapping the title
      final expandedFinder = find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is Text,
      );

      expect(expandedFinder, findsOneWidget);
    });

    testWidgets("asserts when neither icon nor iconPath is provided", (
      WidgetTester tester,
    ) async {
      // Assert
      expect(
        () => ProfileListItem(icon: null, iconPath: null, title: "Test"),
        throwsAssertionError,
      );
    });

    testWidgets("works correctly when onTap is null", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileListItem(
                icon: Icons.person,
                title: "Account",
                onTap: null,
              ),
            ),
          ),
        ),
      );

      // Should not throw when tapped with null onTap
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Assert - widget exists and is tappable even with null callback
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets(
      "icon and iconPath can both be provided (icon takes precedence)",
      (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) => const MaterialApp(
              home: Scaffold(
                body: ProfileListItem(
                  icon: Icons.person,
                  iconPath: "assets/icons/icon.svg",
                  title: "Account",
                ),
              ),
            ),
          ),
        );

        // Assert - Material Icon should be shown, not SVG
        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byType(SvgPicture), findsNothing);
      },
    );
  });
}
