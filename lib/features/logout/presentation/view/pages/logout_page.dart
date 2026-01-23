import 'package:elevate_flower_app/core/helper/user_helper/user_helper.dart';
import 'package:elevate_flower_app/features/logout/presentation/view_model/token_manager/token_manager.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';

/// Screen for debugging token status
/// استخدمه للتأكد إن الـ tokens اتمسحت
class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final TokenManager _tokenManager = getIt<TokenManager>();

  bool? _isAuthenticated;

  @override
  void initState() {
    super.initState();
    _checkTokens();
  }

  Future<void> _checkTokens() async {
    final isAuth = await _tokenManager.isAuthenticated();

    setState(() {
      _isAuthenticated = isAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: const Text('Debug Token Status')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authentication Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          _isAuthenticated == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _isAuthenticated == true
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isAuthenticated == true
                              ? 'Authenticated'
                              : 'Not Authenticated',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isAuthenticated == true
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //!_____________Button logout____________________________
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // عرض الـ Dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: const Text(
                            'LOGOUT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          content: const Text(
                            'Confirm logout!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // زر Cancel
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(); // إغلاق الـ Dialog
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancle',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // زر Logout
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(
                                        context,
                                      ).pop(); // إغلاق الـ Dialog أولاً

                                      // عمل Logout
                                      await UserHelper.clearUserData();

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Logout Successfully',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Clear All Tokens'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primerColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            //!__________________________________________________________
          ],
        ),
      ),
    );
  }
}
