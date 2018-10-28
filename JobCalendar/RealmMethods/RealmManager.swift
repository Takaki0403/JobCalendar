import RealmSwift
import UIKit

struct RealmManager {
    static func realmConfig() {
        // realm変更後はversion変更
        let version: UInt64 = 0
        let config = Realm.Configuration(
            // encryptionKey: getKey(), // 暗号化設定
            schemaVersion: version, // マイグレーション 新しいバージョンを書く（初期値0で整数）
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < version) {
                    // 初期値のoldSchemaVersionは0
                    // Realmが勝手に更新してくれる
                }
        })
        // 新しい設定を読み込む
        Realm.Configuration.defaultConfiguration = config
        print("Realmファイルパス: \(config.fileURL!.path)")
        do {
            _ = try Realm()
        } catch {
            print("Create Realm or Realm Config failed")
            // 初回起動時 or realmファイルが開けない時
            resetRealm(config: config)
            print("新規Realmファイルパス: \(config.fileURL!.path)")
        }
    }
    
    static func resetRealm(config: Realm.Configuration) {
        let fileManager = FileManager.default
        let fileUrl = config.fileURL!
        if fileManager.fileExists(atPath: fileUrl.path) {
            try! fileManager.removeItem(at: fileUrl)
        }
        Realm.Configuration.defaultConfiguration = config
    }
    
    
    static func getKey() -> Data {
        let keychainIdentifier = "io.Realm.EncryptionInakenAppKey"
        var keychainIdentifierData: Data {
            return keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        }
        
        // キーチェーンから暗号化キーを取得するクエリを生成
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // 暗号キーを取得
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            let data = dataTypeRef as! Data
            print("Realmブラウザ用パスワード: \(data.map { String(format: "%.2hhx", $0) }.joined())\n")
            return data
        }
        
        // 新規作成
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        print("新規作成: \(result)")
        print("Realmブラウザ用パスワード: \((keyData as Data).map { String(format: "%.2hhx", $0) }.joined())\n")
        
        // キーチェーンに保存
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        print("SaveKeychain")
        return keyData as Data
    }
    
}
