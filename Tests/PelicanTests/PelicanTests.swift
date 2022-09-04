@testable import Pelican
import XCTest

struct ObjectExample: Codable & PelicanStaticKeyed {
    static var storageKey: String { "ObjectExample" }

    let name: String
    let age: Int
}

extension ObjectExample: Equatable {}

final class PelicanTests: XCTestCase {
    // MARK: - FileBased tests

    func testSingleFileBasedSuccess() throws {
        try singleStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    func testMultiFileBasedSuccess() throws {
        try multiStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    func testSingleFileBasedSaveAndClear() throws {
        try singleStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    func testMultiFileBasedSaveAndClear() throws {
        try multiStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    func testSingleFileBasedOverride() throws {
        try singleStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    func testMultiFileBasedOverride() throws {
        try multiStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.fileBasedStorage
        )
    }

    // MARK: - UserDefaults tests

    func testSingleUserDefaultsSuccess() throws {
        try singleStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    func testMultiUserDefaultsSuccess() throws {
        try multiStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    func testSingleUserDefaultsSaveAndClear() throws {
        try singleStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    func testMultiUserDefaultsSaveAndClear() throws {
        try multiStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    func testSingleUserDefaultsOverride() throws {
        try singleStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    func testMultiDefaultsOverride() throws {
        try multiStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
        )
    }

    // MARK: - Security tests

    func testSingleSecuritySuccess() throws {
        try singleStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    func testMultiSecuritySuccess() throws {
        try multiStorageSaveTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    func testSingleSecuritySaveAndClear() throws {
        try singleStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    func testMultiSecuritySaveAndClear() throws {
        try multiStorageSaveAndClearTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    func testSingleSecurityOverride() throws {
        try singleStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    func testMultiSecurityOverride() throws {
        try multiStorageOverrideTest(
            storage: Pelican.StorageFactory<ObjectExample>.securityStorage
        )
    }

    // MARK: - Generification tests

    func singleStorageSaveTest(storage: Pelican.Storage<ObjectExample>) throws {
        let singleStonrage = storage.single

        let object = ObjectExample(name: "Erokha", age: 22)
        try singleStonrage.save(object: object)

        XCTAssertEqual(try singleStonrage.restore(), object)
    }

    func multiStorageSaveTest(storage: Pelican.Storage<ObjectExample>) throws {
        let multiStorage = storage.multi

        let object1 = ObjectExample(name: "Erokha", age: 22)
        let object2 = ObjectExample(name: "MeetyProject", age: 1)

        try multiStorage.save(object: object1, forKey: "1")
        try multiStorage.save(object: object2, forKey: "2")

        XCTAssertEqual(try multiStorage.restore(forKey: "1"), object1)
        XCTAssertEqual(try multiStorage.restore(forKey: "2"), object2)
    }

    func singleStorageSaveAndClearTest(storage: Pelican.Storage<ObjectExample>) throws {
        let singleStorage = storage.single

        let object = ObjectExample(name: "Erokha", age: 22)
        try singleStorage.save(object: object)

        XCTAssertEqual(try singleStorage.restore(), object)

        singleStorage.clear()

        XCTAssertEqual(try? singleStorage.restore(), nil)
    }

    func multiStorageSaveAndClearTest(storage: Pelican.Storage<ObjectExample>) throws {
        let multiStorage = storage.multi

        let object1 = ObjectExample(name: "Erokha", age: 22)
        let object2 = ObjectExample(name: "MeetyProject", age: 1)

        try multiStorage.save(object: object1, forKey: "1")
        try multiStorage.save(object: object2, forKey: "2")

        XCTAssertEqual(try? multiStorage.restore(forKey: "1"), object1)
        XCTAssertEqual(try? multiStorage.restore(forKey: "2"), object2)

        multiStorage.clear(for: "1")

        XCTAssertEqual(try? multiStorage.restore(forKey: "1"), nil)
        XCTAssertEqual(try? multiStorage.restore(forKey: "2"), object2)

        multiStorage.clear(for: "2")

        XCTAssertEqual(try? multiStorage.restore(forKey: "1"), nil)
        XCTAssertEqual(try? multiStorage.restore(forKey: "2"), nil)
    }

    func singleStorageOverrideTest(storage: Pelican.Storage<ObjectExample>) throws {
        let singleStorage = storage.single

        let object1 = ObjectExample(name: "Erokha", age: 22)
        let object2 = ObjectExample(name: "MeetyProject", age: 1)

        try singleStorage.save(object: object1)
        try singleStorage.save(object: object2)

        XCTAssertEqual(try singleStorage.restore(), object2)
    }

    func multiStorageOverrideTest(storage: Pelican.Storage<ObjectExample>) throws {
        let multiStorage = storage.multi

        let object1 = ObjectExample(name: "Erokha", age: 22)
        let object2 = ObjectExample(name: "MeetyProject", age: 1)

        try multiStorage.save(object: object1, forKey: "1")
        try multiStorage.save(object: object2, forKey: "1")

        XCTAssertEqual(try multiStorage.restore(forKey: "1"), object2)
    }
}
