import 'package:flutter/widgets.dart';

import '../pages/address_list_page.dart';

/// Compatibility route entry point. New code should use [AddressListPage].
class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) => const AddressListPage();
}
