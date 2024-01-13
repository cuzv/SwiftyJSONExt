import Foundation
import SwiftyJSON

public protocol JSONRepresentable {
  var json: JSON { get }
  init?(json: JSON)
}

public extension JSONRepresentable {
  var json: JSON {
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

public extension JSONRepresentable {
  func encode(
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

public extension JSON {
  /// Map JSON to Model
  func map<M>(_ transform: (JSON) -> M?) -> M? {
    transform(self)
  }

  /// Resolve JSON to Model
  func resolved<M: JSONRepresentable>() -> M? {
    map(M.init(json:))
  }

  /// Resolve JSON to [Model]
  func resolved<M: JSONRepresentable>() -> [M] {
    arrayValue.compactMap(M.init(json:))
  }

  /// Resolve JSON to [String: Model]
  func resolved<M: JSONRepresentable>() -> [String: M] {
    dictionaryValue.compactMapValues(M.init(json:))
  }

  /// Resolve JSON to Bool
  func resolved() -> Bool {
    boolValue
  }

  /// Resolve JSON to String
  func resolved() -> String {
    stringValue
  }

  /// Resolve JSON to NSNumber
  func resolved() -> NSNumber {
    numberValue
  }

  /// Resolve JSON to URL
  func resolved() -> URL {
    url ?? URL(string: "https://httpbin.org/")!
  }

  /// Resolve JSON to Float
  func resolved() -> Float {
    floatValue
  }

  /// Resolve JSON to Double
  func resolved() -> Double {
    doubleValue
  }

  /// Resolve JSON to Int
  func resolved() -> Int {
    intValue
  }

  /// Resolve JSON to Int8
  func resolved() -> Int8 {
    int8Value
  }

  /// Resolve JSON to Int16
  func resolved() -> Int16 {
    int16Value
  }

  /// Resolve JSON to Int32
  func resolved() -> Int32 {
    int32Value
  }

  /// Resolve JSON to Int64
  func resolved() -> Int64 {
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
