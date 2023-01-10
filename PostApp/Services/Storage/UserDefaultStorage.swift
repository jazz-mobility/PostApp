//
//  FavoritePostsInteractor.swift
//  PostApp
//
//  Created by Jasveer Singh on 10.01.23.
//

import Foundation

@propertyWrapper struct UserDefaultStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults

    init(
        key: String,
        default: T,
        storage: UserDefaults = .standard
    ) {
        self.key = key
        self.defaultValue = `default`
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let jsonString = storage.string(forKey: key) else {
                return defaultValue
            }
            guard let jsonData = jsonString.data(using: .utf8) else {
                return defaultValue
            }
            guard let value = try? JSONDecoder().decode(T.self, from: jsonData) else {
                return defaultValue
            }
            return value
        }
        set {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            guard let jsonData = try? encoder.encode(newValue) else { return }
            let jsonString = String(bytes: jsonData, encoding: .utf8)
            storage.set(jsonString, forKey: key)
        }
    }
}
