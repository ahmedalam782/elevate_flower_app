import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/about_app/data/models/section_style_model.dart';
import 'package:elevate_flower_app/features/about_app/presentation/view/widgets/about_app_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  List<AboutSectionModel> sections = [];
  bool isLoading = true;
  String? error;
  String locale = 'en';

  @override
  void initState() {
    super.initState();
    _loadAboutData();
  }

  Future<void> _loadAboutData() async {
    try {
      final String response = await rootBundle.loadString(
        EndPoints.aboutAppPath,
      );

      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> aboutAppList = data['about_app'];

      setState(() {
        sections = aboutAppList
            .map((item) => AboutSectionModel.fromJson(item))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      debugPrint('Error loading about data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = locale == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: AppColors.primerColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  context.go(Routes.appLayout);
                },
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      locale == 'en' ? 'ع' : 'EN',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      locale = locale == 'en' ? 'ar' : 'en';
                    });
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  isArabic ? 'عن التطبيق' : 'About Flowery',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primerColor,
                        AppColors.primerColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.local_florist_rounded,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: _buildBody(locale)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(String currentLocale) {
    if (isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primerColor),
        ),
      );
    }

    if (error != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.primerColor,
              ),
              const SizedBox(height: 16),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black35,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.black85,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (sections.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: const Center(child: Text('No data available')),
      );
    }

    return Column(
      children: sections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;

        return AboutAppBody(
          section: section,
          locale: currentLocale,
          index: index,
        );
      }).toList(),
    );
  }
}
