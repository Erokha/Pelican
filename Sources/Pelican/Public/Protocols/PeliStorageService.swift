import Foundation


public protocol PelicanStorageService {
    associatedtype ObjectType: Codable, PelicanStaticKeyed

    func save(object: ObjectType, forIdentifier identifier: String) throws

    func restore(forIdentifier identifier: String) throws -> ObjectType

    func clear(forIdentifier identifier: String)
}
