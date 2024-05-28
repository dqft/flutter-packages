/// [BoolJsonModifiers] equips [bool] with toJson() capability.
///
/// If you provide the key argument, a json object is returned.
extension BoolJsonModifiers on bool {
  T toJson<T>([String? key]) => key == null ? this as T : {key: toJson()} as T;
}

/// [DateTimeJsonModifiers] equips [DateTime] with toJson() capability.
///
/// If you provide the key argument, a json object is returned.
extension DateTimeJsonModifiers on DateTime {
  T toJson<T>([String? key]) =>
      key == null ? toIso8601String() as T : {key: toJson()} as T;
}

/// [IntJsonModifiers] equips [int] with toJson() capability.
///
/// If you provide the key argument, a json object is returned.
extension IntJsonModifiers on int {
  T toJson<T>([String? key]) => key == null ? this as T : {key: this} as T;
}

/// [StringJsonModifiers] equips [String] with toJson() capability.
///
/// If you provide the key argument, a json object is returned.
extension StringJsonModifiers on String {
  T toJson<T>([String? key]) => key == null ? this as T : {key: this} as T;
}
