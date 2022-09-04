import Foundation

extension Pelican {
    struct UserDefaultsStorageService<StorageObjectType: Codable & PelicanStaticKeyed>: PelicanStorageService {
        func save(object: StorageObjectType, forIdentifier identifier: String) throws {
            let data = try Coders.defaultEncoder.encode(object)
            UserDefaults.standard.set(data, forKey: identifier)
        }

        func restore(forIdentifier identifier: String) throws -> StorageObjectType {
            guard
                let anyObject = UserDefaults.standard.object(forKey: identifier),
                let anyData = anyObject as? Data
            else {
                throw PelicanError.emtyStorage
            }
            let decoded = try Coders.defaultDecoder.decode(StorageObjectType.self, from: anyData)
            return decoded
        }

        func clear(forIdentifier identifier: String) {
            UserDefaults.standard.removeObject(forKey: identifier)
        }
    }
}


