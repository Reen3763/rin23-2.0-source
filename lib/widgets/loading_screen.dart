import 'package:material_ui/material_ui.dart';
import 'package:alphtoolcoin/l10n/context_extensions.dart';

class LoadingScreen extends StatelessWidget {
  final String loadingKey;
  final String? titleAsset;
  const LoadingScreen({super.key, required this.loadingKey, this.titleAsset});

  @override
  Widget build(BuildContext context) {
    final message = switch (loadingKey) {
      'apiLogin' => context.l10n.apiLogin,
      'processingEntitlement' => context.l10n.initializingMcDec,
      _ => context.l10n.checkingKeys,
    };
    return Scaffold(body: SafeArea(child: Center(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ClipRRect(borderRadius: BorderRadius.circular(28),
          child: Image.asset('assets/icon.png', width: 112, height: 112)),
        const SizedBox(height: 24),
        const Text('Rin23', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('ADD-ON • WORLD • SKIN', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 36),
        const SizedBox(width: 200, child: LinearProgressIndicator()),
        const SizedBox(height: 16),
        Text(message, textAlign: TextAlign.center),
      ]),
    ))));
  }
}
