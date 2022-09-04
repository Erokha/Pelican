import Foundation

public protocol PelicanMultiObjectStorage {
    associatedtype ObjectType: Codable

    func save(object: ObjectType, forKey: String) throws

    func restore(forKey: String) throws -> ObjectType

    func clear(for key: String)
}
