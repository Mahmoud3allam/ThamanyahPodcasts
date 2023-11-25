//
//  UserDefaultManager.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//
import Foundation

protocol LocalStorageKeysProtocol {
    var rawValue: String { get }
}

protocol Storeable {
    var storeData: Data? { get }

    init?(storeData: Data?)
}

protocol LocalStorageProtocol {
    func value<T>(key: LocalStorageKeysProtocol) -> T?
    func write<T>(key: LocalStorageKeysProtocol, value: T?)
    func remove(key: LocalStorageKeysProtocol)

    func valueStoreable<T>(key: LocalStorageKeysProtocol) -> T? where T: Storeable
    func writeStoreable<T>(key: LocalStorageKeysProtocol, value: T?) where T: Storeable
}

class UserDefaultManager: LocalStorageProtocol {
    fileprivate let userDefaults: UserDefaults = .standard

    func value<T>(key: LocalStorageKeysProtocol) -> T? {
        return self.userDefaults.object(forKey: key.rawValue) as? T
    }

    func write<T>(key: LocalStorageKeysProtocol, value: T?) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }

    func remove(key: LocalStorageKeysProtocol) {
        self.userDefaults.set(nil, forKey: key.rawValue)
    }

    func valueStoreable<T>(key: LocalStorageKeysProtocol) -> T? where T: Storeable {
        let data: Data? = self.userDefaults.data(forKey: key.rawValue)
        return T(storeData: data)
    }

    func writeStoreable<T>(key: LocalStorageKeysProtocol, value: T?) where T: Storeable {
        self.userDefaults.set(value?.storeData, forKey: key.rawValue)
    }
}
