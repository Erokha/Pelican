# Pelican
Small library that allows you to use Storage in Swifty style

# Install

When you have your Swift package set up, simply add StorageKit as a dependency, by placing it to the dependencies value of your Package.swift.
```swift
dependencies: [
    .package(url: "https://github.com/Erokha/Pelican.git", .upToNextMajor(from: "1.0.0"))
]
```

# Usage

For example, we have some struct
```swift
struct ObjectExample: Codable {
    let name: String
    let age: Int
}
```

What we have to do, to save it into some storage?

Step 1: Add PelicanStaticKeyed protocol
```swift
extension ObjectExample: PelicanStaticKeyed {
    static var storageKey: String { "ObjectExample" }
}
```

Step 2: Create Storage

```swift
let storage = Pelican.StorageFactory<ObjectExample>.userDefaultsStorage
```

Step3: Save to single or multi-object storage

```swift
let object = ObjectExample(name: "Erokha", age: 22)

// Single storage
try? storage.single.save(object: object)

// Multi storage
try? storage.multi.save(object: object, forKey: "this is key")
```

Step 4: Restore object from Storage

If you saved to single storage
```swift
let object = try storage.single.restore()
        
// Do not forget: you may use optional try
let optionalObject = try? storage.single.restore()
```

If you saved to multi-object storage

```swift
let object = try storage.multi.restore(forKey: "this is key")

// Do not forget: you may use optional try
let optionalObject = try? storage.multi.restore(forKey: "this is key")
```
