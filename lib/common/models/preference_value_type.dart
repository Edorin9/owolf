enum PreferenceValueType {
  defaultValue('Default'),
  customValue('Custom');

  const PreferenceValueType(this.displayText);
  final String displayText;
}

extension PreferenceValueTypeExt on String {
  PreferenceValueType toPreferenceValueType() =>
      PreferenceValueType.values.firstWhere((type) => type.name == this);
}
