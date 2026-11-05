import 'package:alphtoolcoin/services/search_service.dart';
import 'package:material_ui/material_ui.dart';
import 'item_thumbnail.dart';
import '../models/search_result.dart';
import 'open_item_details.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:alphtoolcoin/l10n/context_extensions.dart';

class SearchResultGridItem extends StatelessWidget {
  final SearchResult item;
  final SearchService searchService;
  final VoidCallback? onRemove;
  final bool showRemoveButton;
  final int pageSize;

  const SearchResultGridItem({
    super.key,
    required this.item,
    required this.searchService,
    this.onRemove,
    this.showRemoveButton = false,
    required this.pageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () =>
                  openItemDetails(context, item, searchService, pageSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ItemThumbnail(
                      imageUrl: item.imageUrl,
                      isOwned: showRemoveButton || item.isOwned,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Bottom info section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            minFontSize: 10,
                            maxFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          AutoSizeText(
                            context.l10n.byCreator(item.creator),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            minFontSize: 8,
                            maxFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            item.packType,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                            maxLines: 1,
                            minFontSize: 8,
                            maxFontSize: 11,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Price display
                          if (showRemoveButton && item.price != null)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/minecoin.png',
                                  width: 14,
                                  height: 14,
                                ),
                                const SizedBox(width: 2),
                                AutoSizeText(
                                  '${item.price}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 8,
                                  maxFontSize: 11,
                                  overflow: TextOverflow.ellipsis,
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
          // Remove button overlay
          if (showRemoveButton && onRemove != null)
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.red.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
