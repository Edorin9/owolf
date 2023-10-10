enum PreferenceValueType {
  defaultValue('Default'),
  customValue('Custom');

  const PreferenceValueType(this.nameText);
  final String nameText;
}
