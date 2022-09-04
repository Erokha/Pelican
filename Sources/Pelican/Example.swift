import Foundation

struct ObjectExample: Codable & PelicanStaticKeyed {
	static var storageKey: String { "ObjectExample" }

	let name: String
	let age: Int
}

private struct Example {
	let object = ObjectExample(name: "Erokha", age: 22)
    let storage = Pelican.StorageFactory<ObjectExample>.userDefaultsStorage

	func exampleSaveToSingleStorage() throws {
		try storage.single.save(object: object)
	}

	func exampleRestoreFromSingleStorage() throws {
		let object = try storage.single.restore()
		print(object.name)
	}

	func exampleSaveToMultiStorage() throws {
		try storage.multi.save(object: object, forKey: "this is key")
	}

	func exampleRestoreFromMultiStorage() throws {
		let object = try storage.multi.restore(forKey: "this is key")
		print(object.name)
	}
}
