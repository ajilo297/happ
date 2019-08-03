import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:happ/core/services/database_service.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ..._independentProviders,
  ..._dependentProviders,
  ..._consumableProviders,
];
List<SingleChildCloneableWidget> _independentProviders = [
  Provider.value(value: PreferenceService()),
  Provider.value(value: DatabaseService()),
];
List<SingleChildCloneableWidget> _dependentProviders = [];
List<SingleChildCloneableWidget> _consumableProviders = [
  StreamProvider<ThemeVariant>(
    builder: (context) => Provider.of<PreferenceService>(context, listen: false)
        .selectedThemeStream,
    initialData: ThemeVariant.fromIndex(1),
  ),
  StreamProvider<UserModel>(
    builder: (context) =>
        Provider.of<PreferenceService>(context, listen: false).userStream,
  ),
];
