import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/terms_and_conditions/data/models/terms_section_model.dart';
import 'package:elevate_flower_app/features/terms_and_conditions/presentation/view/widgets/terms_and_conditions_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  List<TermsSectionModel> sections = [];
  bool isLoading = true;
  String? error;
  String locale = 'en';
  String pageTitle = '';

  @override
  void initState() {
    super.initState();
    _loadTermsData();
  }

  Future<void> _loadTermsData() async {
    try {
      final String response = await rootBundle.loadString(EndPoints.termsPath);

      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> termsData =
          data['terms_and_conditions'] as List<dynamic>;

      // Find the title section
      final titleSection = termsData.firstWhere(
        (item) => item['section'] == 'title',
        orElse: () => null,
      );

      if (titleSection != null) {
        final Map<String, dynamic> titleContent = titleSection['content'];
        pageTitle = titleContent[locale] ?? 'Terms and Conditions';
      } else {
        pageTitle = locale == 'ar' ? 'الشروط والأحكام' : 'Terms and Conditions';
      }

      setState(() {
        sections = termsData
            .map(
              (item) =>
                  TermsSectionModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      debugPrint('Error loading terms data: $e');
    }
  }

  // Reload data when locale changes
  void _changeLocale() {
    setState(() {
      locale = locale == 'en' ? 'ar' : 'en';
      isLoading = true;
      sections = [];
    });
    _loadTermsData();
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
                  onPressed: _changeLocale,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  isArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
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
                      Icons.description_outlined,
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
      children: [
        // Page Title
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primerColor,
            ),
          ),
        ),

        // Sections
        ...sections.asMap().entries.map((entry) {
          final index = entry.key;
          final section = entry.value;

          return TermsSectionBody(
            section: section,
            locale: currentLocale,
            index: index,
          );
        }).toList(),

        // Bottom spacing
        const SizedBox(height: 40),
      ],
    );
  }
}
