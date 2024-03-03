import Foundation
import SwiftyJSON

// MARK: - Resolving

public extension JSON {
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

// MARK: - Aux

public extension JSON {
  /// JSON to string
  var utf8String: String? {
    rawString(.utf8, options: [])
  }

  /// Map JSON to Model
  func map<M>(_ transform: (JSON) throws -> M) rethrows -> M {
    try transform(self)
  }

  /// Map JSON to Model
  func map<M>(_ transform: (JSON) -> M?) -> M? {
    transform(self)
  }
}
