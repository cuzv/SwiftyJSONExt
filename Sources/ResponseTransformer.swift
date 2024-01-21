import Foundation
import SwiftyJSON

public protocol ResponseTransformer {
  func transform(payload: JSON) throws -> JSON
}

public struct InsResponseTransformer: ResponseTransformer {
  public init() {}

  public func transform(payload: JSON) throws -> JSON {
    if payload["status"].stringValue.lowercased() == "ok" {
      return payload
    } else {
      throw BusinessError(
        code: payload["code"].intValue,
        message: payload["message"].stringValue
      )
    }
  }
}

public struct CommonResponseTransformer: ResponseTransformer {
  public init() {}

  public func transform(payload: JSON) throws -> JSON {
    let code = payload["code"].intValue
    if code == 0 {
      return payload["data"]
    } else {
      throw BusinessError(
        code: code,
        message: payload["message"].stringValue
      )
    }
  }
}
