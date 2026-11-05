import 'dart:math';

import 'package:alphtoolcoin/l10n/context_extensions.dart';
import 'package:material_ui/material_ui.dart';

class LoadingScreen extends StatefulWidget {
  final String loadingKey;
  final String? titleAsset;

  const LoadingScreen({super.key, required this.loadingKey, this.titleAsset});

  static const List<String> titleAssets = [
    'assets/titles/amethyst_title.png',
    'assets/titles/bamboo_title.png',
    'assets/titles/beach_title.png',
    'assets/titles/cake_title.png',
    'assets/titles/classic_title.png',
    'assets/titles/copper_title.png',
    'assets/titles/crimson_title.png',
    'assets/titles/crystal_title.png',
    'assets/titles/deep_dark_title.png',
    'assets/titles/fire_title.png',
    'assets/titles/flat_title.png',
    'assets/titles/fruit_title.png',
    'assets/titles/glow_squid_title.png',
    'assets/titles/grass_flowers_title.png',
    'assets/titles/grass_title.png',
    'assets/titles/hay_bale_title.png',
    'assets/titles/midnight_title.png',
    'assets/titles/mangrove_title.png',
    'assets/titles/neon_title.png',
    'assets/titles/oxidised_copper_title.png',
    'assets/titles/oxidizing_copper_title.png',
    'assets/titles/smooth_title.png',
    'assets/titles/sniffer_title.png',
    'assets/titles/sponge_title.png',
    'assets/titles/warped_title.png',
    'assets/titles/white_title.png',
    'assets/titles/winter_title.png',
  ];

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final String _selectedTitle;

  @override
  void initState() {
    super.initState();
    _selectedTitle =
        widget.titleAsset ??
        LoadingScreen.titleAssets[Random().nextInt(
          LoadingScreen.titleAssets.length,
        )];
  }

  double _getTargetProgress() {
    switch (widget.loadingKey) {
      case 'apiLogin':
        return 0.33;
      case 'processingEntitlement':
        return 0.66;
      case 'checkingKeys':
        return 1.0;
      default:
        return 1.0;
    }
  }

  String _getMessage(BuildContext context) {
    switch (widget.loadingKey) {
      case 'apiLogin':
        return context.l10n.apiLogin;
      case 'processingEntitlement':
        return context.l10n.initializingMcDec;
      case 'checkingKeys':
      case 'completed':
        return context.l10n.checkingKeys;
      default:
        return 'Loading...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = _getMessage(context);
    final targetProgress = _getTargetProgress();
    final contentColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Image.asset(_selectedTitle, fit: BoxFit.contain),
                ),
                const SizedBox(height: 40),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: targetProgress),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    builder: (context, progress, child) {
                      final percentage = (progress * 100).toInt();
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Outer blocky border box
                          Container(
                            height: 12,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: contentColor,
                                width: 2.0,
                              ),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(color: contentColor),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Text(
                            '$percentage%',
                            style: TextStyle(
                              fontFamily: 'MinecraftFont',
                              fontSize: 15,
                              color: contentColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Status Message
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    message,
                    key: ValueKey<String>(message),
                    style: TextStyle(
                      fontFamily: 'MinecraftFont',
                      fontSize: 13,
                      color: contentColor.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
