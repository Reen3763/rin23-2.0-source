import 'package:alphtoolcoin/l10n/context_extensions.dart';
import 'package:alphtoolcoin/models/search_result.dart';
import 'package:alphtoolcoin/services/search_service.dart';
import 'open_item_details.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'item_thumbnail.dart';
import 'package:material_ui/material_ui.dart';

String? getPackTypeAsset(String packType) {
  final key = packType.toLowerCase().replaceAll(RegExp(r'\s+'), '');
  switch (key) {
    case 'addon':
      return 'assets/addon.png';
    case 'world':
      return 'assets/world.png';
    case 'texturepack':
    case 'texture':
      return 'assets/texture.png';
    case 'skinpack':
    case 'skin':
      return 'assets/skin.png';
    case 'mashup':
      return 'assets/mashup.png';
    case 'persona':
      return 'assets/persona.png';
    default:
      return null;
  }
}

class DiscoveryCard extends StatelessWidget {
  final SearchResult item;
  final SearchService searchService;
  final int pageSize;
  final double? width;

  const DiscoveryCard({
    super.key,
    required this.item,
    required this.searchService,
    required this.pageSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final packAsset = getPackTypeAsset(item.packType);

    Widget card = Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openItemDetails(context, item, searchService, pageSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 16:9 Thumbnail Image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ItemThumbnail(
                  imageUrl: item.imageUrl,
                  isOwned: item.isOwned,
                  placeholderIconSize: 32,
                ),
              ),

              // Card Details (Title, Creator, Pack Type)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      AutoSizeText(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.15,
                        ),
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),

                      // Creator and Pack Type Icon/Text
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              context.l10n.byCreator(item.creator),
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.65,
                                ),
                              ),
                              maxLines: 1,
                              minFontSize: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (packAsset != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Image.asset(
                                packAsset,
                                width: 13,
                                height: 13,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.55,
                                ),
                                filterQuality: FilterQuality.none,
                              ),
                            )
                          else if (item.packType.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                item.packType,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.55,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (width != null) {
      final cardHeight = (width! * 9 / 16) + 48.0;
      return SizedBox(width: width, height: cardHeight, child: card);
    }

    return card;
  }
}
