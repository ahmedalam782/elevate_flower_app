import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view/widgets/address_cell.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view/widgets/delete_address_sheet.dart';
import 'package:flutter/material.dart';

class DeletableAddressCell extends StatefulWidget {
  final UserAddressEntity address;
  final VoidCallback onEdit;
  final VoidCallback onDeleteConfirmed; 

  const DeletableAddressCell({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDeleteConfirmed,
  });

  @override
  State<DeletableAddressCell> createState() => _DeletableAddressCellState();
}

class _DeletableAddressCellState extends State<DeletableAddressCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    );
  }


  Future<void> deleteWithAnimation() async {
    await _controller.reverse(); 
    widget.onDeleteConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _controller,
      axisAlignment: 0,
      child: AddressCell(
        key: ValueKey(widget.address.id),
        address: widget.address,
        onEdit: widget.onEdit,
        onDelete: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => DeleteAddressSheet(
              onDelete: () {
                deleteWithAnimation();
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
