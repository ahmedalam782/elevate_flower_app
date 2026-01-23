import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ProfileHeader Widget Tests", () {
    testWidgets("displays user name and email correctly", (
      WidgetTester tester,
    ) async {
      // Arrange
      const testName = "John Doe";
      const testEmail = "john.doe@example.com";

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(name: testName, email: testEmail),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testName), findsOneWidget);
      expect(find.text(testEmail), findsOneWidget);
    });

    testWidgets("displays placeholder icon when imageUrl is null", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(
                name: "Test User",
                email: "test@example.com",
                imageUrl: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets("displays placeholder icon when imageUrl is empty", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(
                name: "Test User",
                email: "test@example.com",
                imageUrl: "",
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets(
      "attempts to display CachedNetworkImage when imageUrl is valid",
      (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) => const MaterialApp(
              home: Scaffold(
                body: ProfileHeader(
                  name: "Test User",
                  email: "test@example.com",
                  imageUrl: "https://example.com/photo.jpg",
                ),
              ),
            ),
          ),
        );

        // Assert
        expect(find.byType(CachedNetworkImage), findsOneWidget);
      },
    );

    testWidgets("shows edit icon when onEditTap is provided", (
      WidgetTester tester,
    ) async {
      bool editTapped = false;

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ProfileHeader(
                name: "Test User",
                email: "test@example.com",
                onEditTap: () {
                  editTapped = true;
                },
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(SvgPicture), findsOneWidget);

      // Tap the edit icon
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(editTapped, true);
    });

    testWidgets("does not show edit icon when onEditTap is null", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(
                name: "Test User",
                email: "test@example.com",
                onEditTap: null,
              ),
            ),
          ),
        ),
      );

      // Assert - no SvgPicture for edit icon should be shown
      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets("has correct circular border decoration", (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(name: "Test User", email: "test@example.com"),
            ),
          ),
        ),
      );

      // Assert - find Container with circle decoration
      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle,
      );

      expect(containerFinder, findsOneWidget);
    });

    testWidgets("renders within Column layout", (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Scaffold(
              body: ProfileHeader(name: "Test User", email: "test@example.com"),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Column), findsWidgets);
    });
  });
}
