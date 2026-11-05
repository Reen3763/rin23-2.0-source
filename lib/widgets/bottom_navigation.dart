import 'package:material_ui/material_ui.dart';
import 'package:alphtoolcoin/l10n/context_extensions.dart';
import '../services/announcements_service.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Force LTR
      child: NavigationBarTheme(
        data: NavigationBarTheme.of(context).copyWith(
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ),
        child: NavigationBar(
          height: 67,
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: context.l10n.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.download),
              label: context.l10n.downloads,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: AnnouncementsService.hasUnreadNotifier,
              builder: (context, hasUnread, child) {
                return NavigationDestination(
                  icon: Badge(
                    isLabelVisible: hasUnread,
                    child: const Icon(Icons.newspaper_outlined),
                  ),
                  label: context.l10n.news,
                );
              },
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: context.l10n.settings,
            ),
          ],
        ),
      ),
    );
  }
}
