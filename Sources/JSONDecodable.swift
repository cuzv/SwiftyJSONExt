#if !PREFER_JSON_MAY_DECODABLE
import Foundation
import SwiftyJSON

public protocol JSONDecodable {
  init(json: JSON) throws
}

extension JSON: JSONDecodable {
  public var json: JSON {
    self
  }

  public init(json: JSON) throws {
    self = json
  }
}

// MARK: - Initializing

extension Bool: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.bool {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension String: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.string {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension URL: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.url {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Float: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.float {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Double: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.double {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.int {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int8: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.int8 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int16: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.int16 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int32: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.int32 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Int64: JSONDecodable {
  public init(json: JSON) throws {
    if let value = json.int64 {
      self = value
    } else {
      throw SwiftyJSONError.wrongType
    }
  }
}

extension Array: JSONDecodable where Element: JSONDecodable {
  public init(json: JSON) throws {
    self = try json.arrayValue.resolved()
  }
}

extension Dictionary: JSONDecodable where Value: JSONDecodable, Key == String {
  public init(json: JSON) throws {
    self = try json.dictionaryValue.resolved()
  }
}

// MARK: - Resolving

public extension JSON {
  /// Resolve JSON to Model
  func resolved<M: JSONDecodable>() throws -> M {
    try map(M.init(json:))
  }

  /// Resolve JSON to [Model]
  func resolved<M: JSONDecodable>() throws -> [M] {
    try arrayValue.resolved()
  }

  /// Resolve JSON to [String: Model]
  func resolved<M: JSONDecodable>() throws -> [String: M] {
    try dictionaryValue.resolved()
  }
}

public extension [JSON] {
  /// Resolve [JSON] to [Model]
  func resolved<M: JSONDecodable>() throws -> [M] {
    try map(M.init(json:))
  }
}

public extension [String: JSON] {
  /// Resolve [String: JSON] to [String: Model]
  func resolved<M: JSONDecodable>() throws -> [String: M] {
    try mapValues(M.init(json:))
  }
}

public extension [AnyHashable: JSON] {
  /// Resolve [AnyHashable: JSON] to [AnyHashable: Model]
  func resolved<M: JSONDecodable>() throws -> [AnyHashable: M] {
    try mapValues(M.init(json:))
  }
}
#endif
