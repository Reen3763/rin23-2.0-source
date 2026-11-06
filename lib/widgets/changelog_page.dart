import 'package:material_ui/material_ui.dart';
import 'package:alphtoolcoin/l10n/context_extensions.dart';
import '../services/settings_service.dart';

class ChangelogScreen extends StatelessWidget {
  final Function(bool)? onDevModeChanged;
  const ChangelogScreen({super.key, required this.onDevModeChanged});

  @override
  Widget build(BuildContext context) {
    final changelog = ChangelogData.getChangelog();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.changelog)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.appUpdates,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.appUpdatesDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final version = changelog[index];
              return _buildVersionCard(context, version, index);
            }, childCount: changelog.length),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
              child: Column(
                children: [
                  // Bee GIF footer
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: ClipRRect(
                      child: Image.asset('assets/bee.gif', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Always buzzing with improvements',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _CreditsSection(onDevModeChanged: onDevModeChanged),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionCard(
    BuildContext context,
    ChangelogVersion version,
    int index,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            version.version,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (version.isBeta) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'BETA',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (version.releaseDate != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          version.releaseDate!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerRight,
              children: [
                const Divider(),
                if (index == 0)
                  Positioned(
                    right: 0,
                    bottom: 8.7,
                    child: Image.asset(
                      'assets/steve_sleep.gif',
                      width: 42,
                      filterQuality: FilterQuality.none,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            ...version.changes.map(
              (change) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 12),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        change,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangelogVersion {
  final String version;
  final String? releaseDate;
  final List<String> changes;
  final bool isBeta;

  ChangelogVersion({
    required this.version,
    this.releaseDate,
    required this.changes,
    this.isBeta = false,
  });
}

// Changelogs are not gonna be localized/translated
class ChangelogData {
  static List<ChangelogVersion> getChangelog() => [
    ChangelogVersion(
      version: 'v2.0.0',
      releaseDate: '6 พฤศจิกายน 2569',
      changes: [
        'Rin23 แอปใหม่แยกจากรุ่นเดิม พร้อมธีมแดงและภาษาไทยเริ่มต้น',
        'แก้ช่องเชื่อมต่อ Flutter กับ Android สำหรับดาวน์โหลด เปิดไฟล์ และเลือกโฟลเดอร์',
        'บันทึกไฟล์ใน Download/rin23 และเชื่อมชุมชน Rin23 Discord',
        'ดึงลงเพื่อรีเฟรช และป้องกันผลค้นหาเก่าทับคำค้นล่าสุด',
        'ใช้ข้อมูลในเครื่องเมื่อยังไม่ได้ตั้งค่าเซิร์ฟเวอร์เสริม',
      ],
    ),
  ];
}
