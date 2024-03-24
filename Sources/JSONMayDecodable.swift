#if PREFER_JSON_MAY_DECODABLE
import Foundation
import SwiftyJSON

public protocol JSONMayDecodable {
  init?(attempt json: JSON)
}

extension JSON: JSONMayDecodable {
  public init?(attempt json: JSON) {
    self = json
  }
}

// MARK: - Initializing

extension Bool: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.bool {
      self = value
    } else {
      return nil
    }
  }
}

extension String: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.string {
      self = value
    } else {
      return nil
    }
  }
}

extension URL: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.url {
      self = value
    } else {
      return nil
    }
  }
}

extension Float: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.float {
      self = value
    } else {
      return nil
    }
  }
}

extension Double: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.double {
      self = value
    } else {
      return nil
    }
  }
}

extension Int: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.int {
      self = value
    } else {
      return nil
    }
  }
}

extension Int8: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.int8 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int16: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.int16 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int32: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.int32 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int64: JSONMayDecodable {
  public init?(attempt json: JSON) {
    if let value = json.int64 {
      self = value
    } else {
      return nil
    }
  }
}

extension Array: JSONMayDecodable where Element: JSONMayDecodable {
  public init?(attempt json: JSON) {
    self = json.arrayValue.resolved()
  }
}

extension Dictionary: JSONMayDecodable where Value: JSONMayDecodable, Key == String {
  public init?(attempt json: JSON) {
    self = json.dictionaryValue.resolved()
  }
}

// MARK: - Resolving

public extension JSON {
  /// Resolve JSON to Model
  func resolved<M: JSONMayDecodable>() -> M? {
    map(M.init(attempt:))
  }

  /// Resolve JSON to [Model]
  func resolved<M: JSONMayDecodable>() -> [M] {
    arrayValue.resolved()
  }

  /// Resolve JSON to [String: Model]
  func resolved<M: JSONMayDecodable>() -> [String: M] {
    dictionaryValue.resolved()
  }
}

public extension [JSON] {
  /// Resolve [JSON] to [Model]
  func resolved<M: JSONMayDecodable>() -> [M] {
    compactMap(M.init(attempt:))
  }
}

public extension [String: JSON] {
  /// Resolve [String: JSON] to [String: Model]
  func resolved<M: JSONMayDecodable>() -> [String: M] {
    compactMapValues(M.init(attempt:))
  }
}

public extension [AnyHashable: JSON] {
  /// Resolve [AnyHashable: JSON] to [AnyHashable: Model]
  func resolved<M: JSONMayDecodable>() -> [AnyHashable: M] {
    compactMapValues(M.init(attempt:))
  }
}

#endif
