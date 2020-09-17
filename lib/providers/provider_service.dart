import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import './profile_provider.dart';
import './category_items_provider.dart';
import './connectivity_provider.dart';

class ProviderService {
  static List<SingleChildWidget> mainMultiProviders = [
    StreamProvider<ConnectionStatus>.value(
        value: ConnectivityService().connectivityController.stream),
    ChangeNotifierProvider.value(value: CategoryItemsProvider()),
    ChangeNotifierProvider.value(value: ProfileServiceProvider()),
  ];
}
