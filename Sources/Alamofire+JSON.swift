import Foundation

#if canImport(Alamofire)
import Alamofire
import SwiftyJSON

public struct SwiftyJSONEncoding: ParameterEncoding {
  public static var `default`: SwiftyJSONEncoding { SwiftyJSONEncoding() }
  public static var prettyPrinted: SwiftyJSONEncoding { SwiftyJSONEncoding(options: .prettyPrinted) }
  public let options: JSONSerialization.WritingOptions

  public init(options: JSONSerialization.WritingOptions = []) {
    self.options = options
  }

  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var urlRequest = try urlRequest.asURLRequest()

    guard let json = parameters?["json"] as? JSON else { return urlRequest }

    do {
      let data = try json.rawData(options: options)

      if urlRequest.headers["Content-Type"] == nil {
        urlRequest.headers.update(.contentType("application/json"))
      }

      urlRequest.httpBody = data
    } catch {
      throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
    }

    return urlRequest
  }
}

#endif
