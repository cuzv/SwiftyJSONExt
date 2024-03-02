import Foundation
import SwiftyJSON

public protocol JSONCodable {
  var json: JSON { get }
  init(json: JSON) throws
}

public extension JSONCodable {
  var json: JSON {
    .init(self)
  }
}

extension JSON: JSONCodable {
  public var json: JSON {
    self
  }

  public init(json: JSON) throws {
    self = json
  }
}

public extension JSONCodable {
  func encode(
    encoding: String.Encoding = .utf8,
    options: JSONSerialization.WritingOptions = []
  ) -> String? {
    json.rawString(encoding, options: options)
  }
}

public extension JSON {
  var utf8String: String? {
    rawString(.utf8, options: [])
  }
}

// MARK: - Collection

extension Array: JSONCodable where Element: JSONCodable {
  public init(json: JSON) throws {
    self = try json.arrayValue.map(Element.init(json:))
  }

  public var json: JSON {
    .init(map(\.json))
  }
}

extension Dictionary: JSONCodable where Value: JSONCodable, Key == String {
  public var json: JSON {
    .init(mapValues(\.json))
  }

  public init(json: JSON) throws {
    self = try json.dictionaryValue.mapValues(Value.init(json:))
  }
}

// MARK: - Resolving

extension Bool: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.bool {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension String: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.string {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension URL: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.url {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Float: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.float {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Double: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.double {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.int {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int8: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.int8 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int16: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.int16 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int32: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.int32 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int64: JSONCodable {
  public init(json: JSON) throws {
    if let value = json.int64 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

// MARK: - Resolve

public extension JSON {
  /// Map JSON to Model
  func map<M>(_ transform: (JSON) throws -> M) rethrows -> M {
    try transform(self)
  }

  /// Resolve JSON to Model
  func resolved<M: JSONCodable>() throws -> M {
    try map(M.init(json:))
  }

  /// Resolve JSON to [Model]
  func resolved<M: JSONCodable>() throws -> [M] {
    try arrayValue.map(M.init(json:))
  }

  /// Resolve JSON to [String: Model]
  func resolved<M: JSONCodable>() throws -> [String: M] {
    try dictionaryValue.mapValues(M.init(json:))
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
