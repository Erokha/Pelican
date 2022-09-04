import Foundation

// MARK: - TypeErasure

extension Pelican {
    public class AnyMultiObjectStorage<StorageType: Codable>: PelicanMultiObjectStorage {
        private let storage: _AnyMultiObjectStorageBox<StorageType>

        init<Storage: PelicanMultiObjectStorage>(storage: Storage)
            where Storage.ObjectType == StorageType
        {
            self.storage = _MultiObjectStorageBox(storage)
        }

        public func save(object: StorageType, forKey: String) throws {
            try storage.save(object: object, forKey: forKey)
        }

        public func restore(forKey: String) throws -> StorageType {
            try storage.restore(forKey: forKey)
        }

        public func clear(for key: String) {
            storage.clear(for: key)
        }
    }

    private class _AnyMultiObjectStorageBox<SomeObjectType: Codable>: PelicanMultiObjectStorage {
        func save(object _: SomeObjectType, forKey _: String) throws {
            fatalError("abstract method should not be called")
        }

        func restore(forKey _: String) throws -> SomeObjectType {
            fatalError("abstract method should not be called")
        }

        func clear(for _: String) {
            fatalError("abstract method should not be called")
        }
    }

    private class _MultiObjectStorageBox<Base: PelicanMultiObjectStorage>: _AnyMultiObjectStorageBox<
        Base
            .ObjectType
    > {
        private let box: Base

        init(_ box: Base) {
            self.box = box
        }

        override func save(object: Base.ObjectType, forKey: String) throws {
            try box.save(object: object, forKey: forKey)
        }

        override func restore(forKey: String) throws -> Base.ObjectType {
            try box.restore(forKey: forKey)
        }

        override func clear(for key: String) {
            box.clear(for: key)
        }
    }
}


