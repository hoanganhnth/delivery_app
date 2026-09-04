import 'package:flutter/widgets.dart';

import '../pages/address_list_page.dart';

/// Compatibility route entry point. New code should use [AddressListPage].
class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key, this.isSelectMode = false});

  final bool isSelectMode;

  @override
  Widget build(BuildContext context) =>
      AddressListPage(isSelectMode: isSelectMode);
}
