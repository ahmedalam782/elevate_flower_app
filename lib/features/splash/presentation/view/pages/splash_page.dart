import 'package:elevate_flower_app/core/helper/user_helper/user_helper.dart';

import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/splash_theme.dart';
import '../widgets/app_name.dart';
import '../widgets/background_elements.dart';
import '../widgets/floating_particle.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo_section.dart';
import '../widgets/mesh_gradient.dart';
import '../widgets/particles.dart';
import '../widgets/slogan.dart';
import '../widgets/version_info.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fillController;
  late AnimationController _pulseController;
  late AnimationController _textController;
  late AnimationController _shimmerController;
  late AnimationController _loadingController;
  late AnimationController _rotateController;
  late AnimationController _glowController;
  late AnimationController _particleController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _navigateToNextScreen();
  }

  void _initAnimations() {
    // Logo entrance with bounce
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Fill animation (bottom to top) - smooth and elegant
    _fillController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Subtle pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // Shimmer effect
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    // Loading animation
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    // Rotating ring animation
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    )..repeat();

    // Glow animation
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Particle burst animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat();

    // Text animation (fade in and slide up)
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Start sequence
    _logoController.forward().then((_) {
      if (mounted) {
        _fillController.forward();
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _textController.forward();
        });
      }
    });
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      bool loggedIn = await UserHelper.isLogin();
      bool rememberMe = await UserHelper.isRememberMe() ?? false;
      if (loggedIn && rememberMe && mounted) {
        context.go(Routes.appLayout);
      } else {
        await UserHelper.clearUserData();
        if (mounted) {
          context.go(Routes.login);
        }
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fillController.dispose();
    _pulseController.dispose();
    _textController.dispose();
    _shimmerController.dispose();
    _loadingController.dispose();
    _rotateController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final splashTheme = SplashTheme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.pinkF9,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: splashTheme.backgroundGradient,
              stops: const [0.0, 0.4, 0.8, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Mesh gradient background
              MeshGradient(size: size, plusController: _pulseController),

              // Animated background patterns
              ..._buildBackgroundElements(size),

              // Animated particles
              ...List.generate(12, (index) {
                return Particles(
                  size: size,
                  index: index,
                  particleController: _particleController,
                );
              }),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),

                    // Logo section with enhanced effects
                    LogoSection(
                      rotateController: _rotateController,
                      glowController: _glowController,
                      glowAnimation: _glowAnimation,
                      pulseController: _pulseController,
                      logoController: _logoController,
                      logoOpacity: _logoOpacity,
                      logoScale: _logoScale,
                      fillController: _fillController,
                      orbitController: _rotateController,
                      shimmerController: _shimmerController,
                    ),

                    const SizedBox(height: 40),

                    // App name with gradient
                    AppName(
                      titleOpacity: _titleOpacity,
                      titleSlide: _titleSlide,
                    ),

                    const SizedBox(height: 16),

                    // Slogan with typewriter effect
                    Slogan(textOpacity: _textOpacity, textSlide: _textSlide),

                    const Spacer(flex: 2),

                    // Enhanced loading indicator
                    LoadingIndicator(
                      loadingController: _loadingController,
                      textController: _textController,
                      textOpacity: _textOpacity,
                    ),

                    const SizedBox(height: 24),

                    // Version info
                    VersionInfo(
                      textController: _textController,
                      textOpacity: _textOpacity,
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundElements(Size size) {
    return [
      // Top right decorative circle
      TopRightDecorativeCircle(pulseController: _pulseController, size: size),
      // Bottom left decorative circle
      BottomLeftDecorativeCircle(pulseController: _pulseController, size: size),

      // Subtle floating particles
      ...List.generate(
        5,
        (index) => FloatingParticle(
          animation: _particleController,
          index: index,
          size: size,
        ),
      ),
    ];
  }
}
