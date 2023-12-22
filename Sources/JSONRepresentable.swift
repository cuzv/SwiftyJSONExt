import Foundation
import SwiftyJSON

public protocol JSONRepresentable {
  var json: JSON { get }
  init?(json: JSON)
}

extension JSONRepresentable {
  public var json: JSON {
    .init(self)
  }
}

extension JSON: JSONRepresentable {
  public var json: JSON {
    self
  }

  public init?(json: JSON) {
    self = json
  }
}

extension JSONRepresentable {
  public func encode(
    encoding: String.Encoding = .utf8,
    options: JSONSerialization.WritingOptions = []
  ) -> String? {
    json.rawString(encoding, options: options)
  }
}

// MARK: - Collection

extension Array: JSONRepresentable where Element: JSONRepresentable {
  public init?(json: JSON) {
    let resolved: [Element] = json.resolved()

    if resolved.isEmpty {
      return nil
    } else {
      self = resolved
    }
  }

  public var json: JSON {
    .init(map(\.json))
  }
}

extension Dictionary: JSONRepresentable where Value: JSONRepresentable, Key == String {
  public var json: JSON {
    .init(mapValues(\.json))
  }

  public init?(json: JSON) {
    let resolved: [String: Value] = json.resolved()

    if resolved.isEmpty {
      return nil
    } else {
      self = resolved
    }
  }
}

// MARK: - Resolving

extension JSON {
  /// Map JSON to Model
  public func map<M>(_ transform: (JSON) -> M?) -> M? {
    transform(self)
  }

  /// Resolve JSON to Model
  public func resolved<M: JSONRepresentable>() -> M? {
    map(M.init(json:))
  }

  /// Resolve JSON to [Model]
  public func resolved<M: JSONRepresentable>() -> [M] {
    arrayValue.compactMap(M.init(json:))
  }

  /// Resolve JSON to [String: Model]
  public func resolved<M: JSONRepresentable>() -> [String: M] {
    dictionaryValue.compactMapValues(M.init(json:))
  }

  /// Resolve JSON to Bool
  public func resolved() -> Bool {
    boolValue
  }

  /// Resolve JSON to String
  public func resolved() -> String {
    stringValue
  }

  /// Resolve JSON to NSNumber
  public func resolved() -> NSNumber {
    numberValue
  }

  /// Resolve JSON to URL
  public func resolved() -> URL {
    url ?? URL(string: "https://httpbin.org/")!
  }

  /// Resolve JSON to Float
  public func resolved() -> Float {
    floatValue
  }

  /// Resolve JSON to Double
  public func resolved() -> Double {
    doubleValue
  }

  /// Resolve JSON to Int
  public func resolved() -> Int {
    intValue
  }

  /// Resolve JSON to Int8
  public func resolved() -> Int8 {
    int8Value
  }

  /// Resolve JSON to Int16
  public func resolved() -> Int16 {
    int16Value
  }

  /// Resolve JSON to Int32
  public func resolved() -> Int32 {
    int32Value
  }

  /// Resolve JSON to Int64
  public func resolved() -> Int64 {
    int64Value
  }
}

extension Bool: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.bool {
      self = value
    } else {
      return nil
    }
  }
}

extension String: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.string {
      self = value
    } else {
      return nil
    }
  }
}

extension URL: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.url {
      self = value
    } else {
      return nil
    }
  }
}

extension Float: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.float {
      self = value
    } else {
      return nil
    }
  }
}

extension Double: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.double {
      self = value
    } else {
      return nil
    }
  }
}

extension Int: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.int {
      self = value
    } else {
      return nil
    }
  }
}

extension Int8: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.int8 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int16: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.int16 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int32: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.int32 {
      self = value
    } else {
      return nil
    }
  }
}

extension Int64: JSONRepresentable {
  public init?(json: JSON) {
    if let value = json.int64 {
      self = value
    } else {
      return nil
    }
  }
}
