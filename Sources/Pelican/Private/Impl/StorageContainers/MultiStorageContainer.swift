import Foundation

struct MultiStorageContainer<Service: PelicanStorageService>: PelicanMultiObjectStorage {
    typealias ObjectType = Service.ObjectType
    
    let service: Service
    
    func save(object: ObjectType, forKey key: String) throws {
        try service.save(object: object, forIdentifier: storageKey(with: key))
    }

    func restore(forKey key: String) throws -> ObjectType {
        try service.restore(forIdentifier: storageKey(with: key))
    }

    func clear(for key: String) {
        service.clear(forIdentifier: storageKey(with: key))
    }
    
    private func storageKey(with key: String) -> String {
        return "\(ObjectType.storageKey).muilti.\(key)"
    }
}
