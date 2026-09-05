import 'package:flutter/widgets.dart';

import '../../application/address_list_context.dart';
import '../pages/address_list_page.dart';

/// Compatibility route entry point. New code should use [AddressListPage].
class AddressListScreen extends StatelessWidget {
  const AddressListScreen({
    super.key,
    this.selectionContext = AddressListContext.management,
    this.isSelectMode,
  });

  final AddressListContext selectionContext;
  final bool? isSelectMode;

  @override
  Widget build(BuildContext context) => AddressListPage(
    selectionContext: selectionContext,
    isSelectMode: isSelectMode,
  );
}
