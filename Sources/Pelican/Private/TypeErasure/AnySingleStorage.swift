import Foundation

// MARK: - TypeErasure

public class AnySingleObjectStorage<StorageType: Codable & PelicanStaticKeyed>: PelicanSingleObjectStorage {
	private let storage: _AnySingleObjectStorageBox<StorageType>

	init<Storage: PelicanSingleObjectStorage>(storage: Storage)
		where Storage.SingleStorageObjectType == StorageType
	{
		self.storage = _SingleObjectStorageBox(storage)
	}

	public func save(object: StorageType) throws {
		try storage.save(object: object)
	}

	public func restore() throws -> StorageType {
		try storage.restore()
	}

	public func clear() {
		storage.clear()
	}
}

private class _AnySingleObjectStorageBox<
	SomeObjectType: Codable &
		PelicanStaticKeyed
>: PelicanSingleObjectStorage {
	func save(object _: SomeObjectType) throws {
		fatalError("abstract method should not be called")
	}

	func restore() throws -> SomeObjectType {
		fatalError("abstract method should not be called")
	}

	func clear() {
		fatalError("abstract method should not be called")
	}
}

private class _SingleObjectStorageBox<Base: PelicanSingleObjectStorage>:
    _AnySingleObjectStorageBox<Base.SingleStorageObjectType>
{
	private let box: Base

	init(_ box: Base) {
		self.box = box
	}

	override func save(object: Base.SingleStorageObjectType) throws {
		try box.save(object: object)
	}

	override func restore() throws -> Base.SingleStorageObjectType {
		try box.restore()
	}

	override func clear() {
		box.clear()
	}
}
