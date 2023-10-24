/// Preferences settable value types
///
enum PreferenceValueType {
  defaultValue('Default'),
  customValue('Custom');

  const PreferenceValueType(this.displayText);
  final String displayText;

  /// Return [PreferenceValueType] from [name] String
  ///
  static PreferenceValueType from(String name) =>
      PreferenceValueType.values.singleWhere((type) => type.name == name);
}
