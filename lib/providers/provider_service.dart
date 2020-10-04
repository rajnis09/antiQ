import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import './profile_provider.dart';
import './connectivity_provider.dart';
import './sample_order_data.dart';
import './menu_items_provider.dart';

class ProviderService {
  static List<SingleChildWidget> mainMultiProviders = [
    StreamProvider<ConnectionStatus>.value(
        value: ConnectivityService().connectivityController.stream),
    ChangeNotifierProvider.value(value: ProfileServiceProvider()),
    ChangeNotifierProvider.value(value: SampleData()),
    ChangeNotifierProvider.value(value: MenuItemsProvider()),
  ];
}
