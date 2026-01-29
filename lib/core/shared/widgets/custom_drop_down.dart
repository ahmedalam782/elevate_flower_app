import 'package:flutter/material.dart';

class AppSearchableDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T item) itemLabelBuilder;
  final ValueChanged<T> onChanged;
  final String hintText;

  const AppSearchableDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.value,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),

        // 🔹 Field
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _openSearchSheet(context),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? itemLabelBuilder(value as T) : hintText,
                  style: TextStyle(
                    fontSize: 16,
                    color: value != null ? Colors.black : Colors.grey.shade400,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xffD21E6A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return _SearchSheet<T>(
          items: items,
          itemLabelBuilder: itemLabelBuilder,
          onSelected: (item) {
            Navigator.pop(context);
            onChanged(item);
          },
        );
      },
    );
  }
}

class _SearchSheet<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T> onSelected;

  const _SearchSheet({
    required this.items,
    required this.itemLabelBuilder,
    required this.onSelected,
  });

  @override
  State<_SearchSheet<T>> createState() => _SearchSheetState<T>();
}

class _SearchSheetState<T> extends State<_SearchSheet<T>> {
  late List<T> filteredItems;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filter(String query) {
    setState(() {
      filteredItems = widget.items
          .where(
            (item) => widget
                .itemLabelBuilder(item)
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔎 Search Field
            TextFormField(
              controller: controller,
              onChanged: _filter,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '',
                // hintStyle: Colors.white70,
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 📜 List
            Flexible(
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: MaterialStateProperty.all(Colors.white),
                    trackColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.25),
                    ),
                    radius: const Radius.circular(10),
                    thickness: MaterialStateProperty.all(3),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 3,
                  radius: const Radius.circular(10),
                  child: ListView.separated(
                    itemCount: filteredItems.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.white.withOpacity(0.2)),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(
                          widget.itemLabelBuilder(item),
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () => widget.onSelected(item),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
