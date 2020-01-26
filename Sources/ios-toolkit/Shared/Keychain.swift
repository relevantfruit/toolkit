import KeychainSwift

public struct Credential {
    
    let key: Key
    let value: String
    
    struct Key {
        let keyName: String
        
        static var token: Key {
            return Key(keyName: "token")
        }
        
        static var uuid: Key {
            return Key(keyName: "uuid")
        }
    }
    
    static func token(_ value: String) -> Credential {
        return Credential(key: .token, value: value)
    }
    
    static func uuid(_ value: String) -> Credential {
        return Credential(key: .uuid, value: value)
    }
}

public final class Keychain {
    private static let keychain = KeychainSwift()
    
    static func save(credentials: [Credential]) {
        credentials.forEach { keychain.set($0.value, forKey: $0.key.keyName) }
    }
    
    static func delete(_ keys: [Credential.Key]) {
        keys.forEach { keychain.delete($0.keyName) }
    }
    
    static func get(_ key: Credential.Key) -> Credential? {
        return keychain.get(key.keyName).map { Credential(key: key, value: $0) }
    }
    
    static func has(_ key: Credential.Key) -> Bool {
        return keychain.get(key.keyName) != nil
    }
}

