library statham;

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

/// [Json] is just a shortcut alias.
typedef Json = Map<String, dynamic>;

/// [JsonModifiers] equips [Json] with parsing capabilities.
///
/// You can add you custom string or json parsers for your own classes or types.
extension JsonModifiers on Json {
  /// Holds the string parsers.
  ///
  /// You can  you own string parsers.
  static Map<Type, dynamic Function(String)> strings = {
    bool: bool.parse,
    DateTime: DateTime.parse,
    int: int.parse,
  };

  /// Holds the json parsers.
  ///
  /// You need to add your own jsons parsers for benefiting from it.
  static Map<Type, dynamic Function(Json)> jsons = {};

  /// [fromKey] returns the value contained in the key.
  T fromKey<T>(String key) {
    // Key does not exist
    if (!containsKey(key)) {
      throw FormatException("Key '$key' not found", this);
    }

    // Key already holds the value as we want it
    if (this[key] is T) return this[key] as T;

    // Key holds the value as a string and we have a string parser
    if (this[key] is String && strings.containsKey(T)) {
      return strings[T]!(this[key]) as T;
    }

    // Key holds the value as json and we have a json parser
    if (this[key] is Json && jsons.containsKey(T)) {
      return jsons[T]!(this[key]) as T;
    }

    // We don't know how to handle this...
    throw UnimplementedError("No parser for this");
  }

  /// [tryFormKey] does the same as [fromKey] except it returns null in case of
  /// an issue.
  T? tryFromKey<T>(String key) {
    try {
      return fromKey<T>(key);
    } on FormatException {
      return null;
    }
  }
}
