import 'package:flutter/material.dart';

/// Drag Handle of the Modal.
class ModalDragHandleWidget extends StatelessWidget {
  /// Create [ModalDragHandleWidget].
  const ModalDragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(147, 98, 96, 96),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: 4,
        width: 80,
      ),
    );
  }
}
