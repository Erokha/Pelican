import Foundation

extension Pelican {
    struct FileBasedStorageService<StorageObjectType: Codable & PelicanStaticKeyed>: PelicanStorageService {
        func save(object: StorageObjectType, forIdentifier identifier: String) throws {
            let data = try Coders.defaultEncoder.encode(object)
            try data.write(
                to: fileURL(forIdentifier: identifier)
            )
        }

        func restore(forIdentifier identifier: String) throws -> StorageObjectType {
            let url = fileURL(forIdentifier: identifier)
            guard
                let data = FileManager.default.contents(atPath: url.path)
            else {
                throw PelicanError.emtyStorage
            }

            guard
                let decoded = try? Coders.defaultDecoder.decode(
                    StorageObjectType.self,
                    from: data
                )
            else {
                throw PelicanError.unableToDecode
            }

            return decoded
        }

        func clear(forIdentifier identifier: String) {
            let url = fileURL(forIdentifier: identifier)
            try? FileManager.default.removeItem(at: url)
        }

        // MARK: - Private

        private func fileURL(forIdentifier identifier: String) -> URL {
            let path = FileManager.default.urls(
                for: .applicationDirectory,
                in: .userDomainMask
            )[0].appendingPathComponent(identifier)
            return path
        }
    }
}


