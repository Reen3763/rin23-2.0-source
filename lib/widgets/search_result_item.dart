import 'package:material_ui/material_ui.dart';
import 'item_thumbnail.dart';
import '../models/search_result.dart';
import 'open_item_details.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../services/search_service.dart';
import 'package:alphtoolcoin/l10n/context_extensions.dart';

class SearchResultItem extends StatelessWidget {
  final SearchResult item;
  final SearchService searchService;
  final VoidCallback? onRemove;
  final bool showRemoveButton;
  final int pageSize;

  const SearchResultItem({
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
      textDirection: TextDirection.ltr, // Force LTR
      child: Padding(
        // spacing between items
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0.7),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // Card border radius
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () =>
                openItemDetails(context, item, searchService, pageSize),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Flexible(
                  flex: item.packType == 'Persona'
                      ? 3
                      : 5, // Takes 5/10 = 50% of available width
                  child: AspectRatio(
                    aspectRatio: item.packType == 'Persona' ? 1 / 1 : 16 / 9,
                    child: ItemThumbnail(
                      imageUrl: item.imageUrl,
                      isOwned: showRemoveButton || item.isOwned,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                Flexible(
                  flex: 5, // Takes remaining 50%
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate the height that matches the image AspectRatio
                      final imageHeight = item.packType == 'Persona'
                          ? constraints.maxWidth *
                                (3.0 / 5.0) // Persona ratio 1:1
                          : constraints.maxWidth *
                                (9.0 / 16.0); // this is 16:9 ratio

                      return SizedBox(
                        height: imageHeight,
                        child: Container(
                          padding: const EdgeInsets.all(6.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and remove button row
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        item.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        minFontSize: 10,
                                        maxFontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (showRemoveButton &&
                                        onRemove != null) ...[
                                      const SizedBox(width: 4),
                                      SizedBox(
                                        width: 22,
                                        height: 20,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          iconSize: 18,
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          color: Colors.red,
                                          onPressed: onRemove,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              // Creator text
                              AutoSizeText(
                                context.l10n.byCreator(item.creator),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                                maxLines: 1,
                                minFontSize: 8,
                                maxFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Pack type text
                              AutoSizeText(
                                item.packType,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                                maxLines: 1,
                                minFontSize: 8,
                                maxFontSize: 11,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (showRemoveButton && item.price != null)
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/minecoin.png',
                                      width: 12,
                                      height: 12,
                                    ),
                                    const SizedBox(width: 2),
                                    AutoSizeText(
                                      '${item.price}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
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
                      );
                    },
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
