import Foundation

struct SingleStorageContainer<Service: PelicanStorageService>: PelicanSingleObjectStorage {
    typealias SingleStorageObjectType = Service.ObjectType
    
    let service: Service
    
    func save(object: SingleStorageObjectType) throws {
        try service.save(object: object, forIdentifier: storageKey)
    }

    func restore() throws -> SingleStorageObjectType {
        try service.restore(forIdentifier: storageKey)
    }

    func clear() {
        service.clear(forIdentifier: storageKey)
    }
    
    private var storageKey: String {
        return "\(SingleStorageObjectType.storageKey).signle"
    }
}
