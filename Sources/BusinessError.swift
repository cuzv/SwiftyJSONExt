import Foundation

public struct BusinessError: Error {
  public let code: Int
  public let message: String

  public init(code: Int, message: String) {
    self.code = code
    self.message = message
  }
}
