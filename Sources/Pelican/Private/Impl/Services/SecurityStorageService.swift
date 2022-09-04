import Foundation
import Security

extension Pelican {
    struct SecurityStorageService<StorageObjectType: Codable & PelicanStaticKeyed>: PelicanStorageService {
        // MARK: - Internal

        func save(object: StorageObjectType, forIdentifier identifier: String) throws {
            let data = try Coders.defaultEncoder.encode(object)
            let query = [
                kSecValueData: data,
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: identifier,
                kSecAttrAccount: identifier,
            ] as CFDictionary

            let status = SecItemAdd(query, nil)

            switch status {
            case errSecDuplicateItem:
                try update(object: object, forIdentifier: identifier)
            case errSecSuccess:
                return
            default:
                throw PelicanError.secirityError("\(status)")
            }
        }

        func restore(forIdentifier identifier: String) throws -> StorageObjectType {
            let query = [
                kSecAttrService: identifier,
                kSecAttrAccount: identifier,
                kSecClass: kSecClassGenericPassword,
                kSecReturnData: true,
            ] as CFDictionary

            var result: AnyObject?

            SecItemCopyMatching(query, &result)

            guard let result = result else {
                throw PelicanError.emtyStorage
            }
            guard
                let data = result as? Data,
                let decoded = try? Coders.defaultDecoder.decode(
                    StorageObjectType.self,
                    from: data
                )
            else {
                throw PelicanError.typeMismath
            }

            return decoded
        }

        func clear(forIdentifier identifier: String) {
            let query = [
                kSecAttrAccount: identifier,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            SecItemDelete(query)
        }

        // MARK: - Private

        private func update(object: StorageObjectType, forIdentifier identifier: String) throws {
            let query = [
                kSecAttrService: identifier,
                kSecAttrAccount: identifier,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let data = try Coders.defaultEncoder.encode(object)

            let attributes = [
                kSecValueData: data,
            ] as CFDictionary

            let status = SecItemUpdate(
                query as CFDictionary,
                attributes as CFDictionary
            )

            guard status == errSecSuccess else {
                throw PelicanError.secirityError("\(status)")
            }
        }
    }

}
