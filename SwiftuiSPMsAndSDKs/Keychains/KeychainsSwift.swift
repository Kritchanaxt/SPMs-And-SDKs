//
//  KeychainsSwift.swift
//  SwiftuiSPMsAndSDKs
//
//  Created by Kritchanat on 10/7/2567 BE.
//

import SwiftUI
import KeychainSwift

// Keychain is similar to UserDefaults or AppStorage
// Keychain is encrypted
// Keychain is good for: passwords, ssn, credit card info, sensitive data
// Keychain persists between installs and across devices

final class KeychainManager {
    
    let keychain: KeychainSwift
    
    init() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        self.keychain = keychain
    }
    
    func set(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(forKey key: String) -> String? {
        keychain.get(key)
    }
}

struct KeychainManagerKey: EnvironmentKey {
    // Define the default value for the environment key.
    // You could also choose to initialize it with a specific configuration if needed.
    static let defaultValue: KeychainManager = KeychainManager()
}

extension EnvironmentValues {
    var keychain: KeychainManager {
        get { self[KeychainManagerKey.self] }
        set { self[KeychainManagerKey.self] = newValue }
    }
}

@propertyWrapper
struct KeychainStore: DynamicProperty {
    @State private var newValue: String = ""
    let key: String
    let keychain: KeychainManager
    
    var wrappedValue: String {
        get {
            newValue
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
        })
    }
    
    init(wrappedValue: String, _ key: String, keychain: KeychainManager = KeychainManager()) {
        self.key = key
        self.keychain = keychain
        self.newValue = keychain.get(forKey: key) ?? ""
        print("SUCCESS READ")
    }
    
    func save(newValue: String) {
        keychain.set(newValue, forKey: key)
        self.newValue = newValue
        print("SUCCESS SAVED")
    }
}

struct KeychainSwiftView: View {
    
//    @Environment(\.keychain) var keychain
//    @State private var userPassword: String = ""
    
    @KeychainStore("user_password") var userPassword: String = ""
    
    var body: some View {
        Button(userPassword.isEmpty ? "No password" : userPassword) {
            let newPassword = "aaaaa"
            userPassword = newPassword
            
//            keychain.set(newPassword, forKey: "user_password")
//            userPassword = newPassword
        }
//        .onAppear {
//            userPassword = keychain.get(key: "user_password") ?? ""
//        }
    }
}


#Preview {
    KeychainSwiftView()
}

