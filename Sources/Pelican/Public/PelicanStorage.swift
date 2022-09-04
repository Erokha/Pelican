import Foundation

extension Pelican {
    public struct Storage<Object: Codable & PelicanStaticKeyed> {
        public var single: AnySingleObjectStorage<Object>
        public var multi: AnyMultiObjectStorage<Object>
    }
}
