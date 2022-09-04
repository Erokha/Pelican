import Foundation

class Pelican {
    public struct StorageFactory<StoredObjectType: Codable & PelicanStaticKeyed> {
        public static var userDefaultsStorage: Pelican.Storage<StoredObjectType> {
            return Pelican.Storage<StoredObjectType>(
                single: AnySingleObjectStorage(
                    storage: SingleStorageContainer(
                        service: UserDefaultsStorageService<StoredObjectType>()
                    )
                ),
                multi: AnyMultiObjectStorage(
                    storage: MultiStorageContainer(
                        service: UserDefaultsStorageService<StoredObjectType>()
                    )
                )
            )
        }

        public static var securityStorage: Pelican.Storage<StoredObjectType> {
            return Pelican.Storage<StoredObjectType>(
                single: AnySingleObjectStorage(
                    storage: SingleStorageContainer(
                        service: SecurityStorageService<StoredObjectType>()
                    )
                ),
                multi: AnyMultiObjectStorage(
                    storage: MultiStorageContainer(
                        service: SecurityStorageService<StoredObjectType>()
                    )
                )
            )
        }

        public static var fileBasedStorage: Pelican.Storage<StoredObjectType> {
            return Pelican.Storage<StoredObjectType>(
                single: AnySingleObjectStorage(
                    storage: SingleStorageContainer(
                        service: FileBasedStorageService<StoredObjectType>()
                    )
                ),
                multi: AnyMultiObjectStorage(
                    storage: MultiStorageContainer(
                        service: FileBasedStorageService<StoredObjectType>()
                    )
                )
            )
        }
    }
}
