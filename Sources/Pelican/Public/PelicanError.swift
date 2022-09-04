import Foundation

enum PelicanError: Error {
    case typeMismath
    case emtyStorage
    case unableToDecode
    case secirityError(String)
}
