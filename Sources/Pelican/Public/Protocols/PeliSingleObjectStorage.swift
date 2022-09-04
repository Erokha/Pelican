import Foundation

public protocol PelicanSingleObjectStorage {
    associatedtype SingleStorageObjectType: Codable, PelicanStaticKeyed

    func save(object: SingleStorageObjectType) throws

    func restore() throws -> SingleStorageObjectType

    func clear()
}
