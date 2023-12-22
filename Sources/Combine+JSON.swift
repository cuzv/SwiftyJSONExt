#if canImport(SwiftyJSONExt)
import Foundation
import Combine
import Infrastructure
import SwiftyJSON

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Publisher {
  func json() -> Publishers.Map<Self, JSON> where Output == Data {
    map(JSON.init)
  }

  func decodeJson<Model>(
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
  where Output == JSON, Model: JSONRepresentable {
    decodeJson(type: Model.self, field: field)
  }

  func decodeJson<Model>(
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
  where Output == JSON, Model: JSONRepresentable {
    map { json in
      if let field = field {
        return json[field]
      } else {
        return json
      }
    }
    .compactMap(Model.init(json:))
    .eraseToAnyPublisher()
  }

  func decodeJson<Model>(
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
  where Output == Data, Model: JSONRepresentable {
    json().decodeJson(field: field)
  }

  func decodeJson<Model>(
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
  where Output == Data, Model: JSONRepresentable {
    json().decodeJson(type: type, field: field)
  }

  func validate() -> Publishers.FlatMap<
    AnyPublisher<JSON, AnyError>,
    Self
  > where Output == JSON, Failure == AnyError {
    flatMap { json -> AnyPublisher<JSON, AnyError> in
      if json["status"].stringValue.lowercased() == "ok" {
        return Just(json).setFailureType(to: AnyError.self).eraseToAnyPublisher()
      } else {
        let error = BusinessError(
          code: json["code"].intValue,
          message: json["message"].stringValue
        )
        return Fail(error: .init(error)).eraseToAnyPublisher()
      }
    }
  }

  func validJson() -> Publishers.FlatMap<
    AnyPublisher<JSON, AnyError>,
    Publishers.Map<Self, JSON>
  > where Output == Data, Failure == AnyError {
    json().validate()
  }

  func decodeValidJson<Model>(
    field: String? = nil
  ) -> AnyPublisher<Model, AnyError>
  where Output == Data, Failure == AnyError, Model: JSONRepresentable {
    json().validate().decodeJson(field: field)
  }

  func decodeValidJson<Model>(
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, AnyError>
  where Output == Data, Failure == AnyError, Model: JSONRepresentable {
    json().validate().decodeJson(type: Model.self, field: field)
  }
}

public struct BusinessError: Error {
  public let code: Int
  public let message: String
}

#endif
