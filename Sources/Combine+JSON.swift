import Combine
import Foundation
import SwiftyJSON

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Publisher {
  func json() -> Publishers.Map<Self, JSON> where Output == Data {
    map(JSON.init)
  }

  func decodeJson<Model>(
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
    where Output == JSON, Model: JSONRepresentable
  {
    decodeJson(type: Model.self, field: field)
  }

  func decodeJson<Model>(
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
    where Output == JSON, Model: JSONRepresentable
  {
    map { json in
      if let field {
        json[field]
      } else {
        json
      }
    }
    .compactMap(Model.init(json:))
    .eraseToAnyPublisher()
  }

  func decodeJson<Model>(
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
    where Output == Data, Model: JSONRepresentable
  {
    json().decodeJson(field: field)
  }

  func decodeJson<Model>(
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, Failure>
    where Output == Data, Model: JSONRepresentable
  {
    json().decodeJson(type: type, field: field)
  }
}

#if canImport(Infrastructure)
import Infrastructure

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Publisher {
  func validate(
    with transformer: some ResponseTransformer
  ) -> Publishers.FlatMap<
    AnyPublisher<JSON, AnyError>,
    Self
  > where Output == JSON, Failure == AnyError {
    flatMap { json -> AnyPublisher<JSON, AnyError> in
      do {
        let data = try transformer.transform(payload: json)
        return Just(data)
          .setFailureType(to: AnyError.self)
          .eraseToAnyPublisher()
      } catch {
        return Fail(error: .init(error))
          .eraseToAnyPublisher()
      }
    }
  }

  func validJson(
    with transformer: some ResponseTransformer = CommonResponseTransformer()
  ) -> Publishers.FlatMap<
    AnyPublisher<JSON, AnyError>,
    Publishers.Map<Self, JSON>
  > where Output == Data, Failure == AnyError {
    json().validate(with: transformer)
  }

  func decodeValidJson<Model>(
    with transformer: some ResponseTransformer = CommonResponseTransformer(),
    field: String? = nil
  ) -> AnyPublisher<Model, AnyError>
    where Output == Data, Failure == AnyError, Model: JSONRepresentable
  {
    json().validate(with: transformer).decodeJson(field: field)
  }

  func decodeValidJson<Model>(
    with transformer: some ResponseTransformer = CommonResponseTransformer(),
    type: Model.Type,
    field: String? = nil
  ) -> AnyPublisher<Model, AnyError>
    where Output == Data, Failure == AnyError, Model: JSONRepresentable
  {
    json().validate(with: transformer).decodeJson(type: Model.self, field: field)
  }
}

#endif
