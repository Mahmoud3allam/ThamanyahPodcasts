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
    func value<ValueType>(key: LocalStorageKeysProtocol) -> ValueType?
    func write<ValueType>(key: LocalStorageKeysProtocol, value: ValueType?)
    func remove(key: LocalStorageKeysProtocol)
    func valueStoreable<StoreableType>(key: LocalStorageKeysProtocol) -> StoreableType? where StoreableType: Storeable
    func writeStoreable<StoreableType>(key: LocalStorageKeysProtocol, value: StoreableType?) where StoreableType: Storeable
}

class UserDefaultManager: LocalStorageProtocol {
    fileprivate let userDefaults: UserDefaults = .standard

    func value<ValueType>(key: LocalStorageKeysProtocol) -> ValueType? {
        return self.userDefaults.object(forKey: key.rawValue) as? ValueType
    }

    func write<ValueType>(key: LocalStorageKeysProtocol, value: ValueType?) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }

    func remove(key: LocalStorageKeysProtocol) {
        self.userDefaults.set(nil, forKey: key.rawValue)
    }

    func valueStoreable<StoreableType>(key: LocalStorageKeysProtocol) -> StoreableType? where StoreableType: Storeable {
        let data: Data? = self.userDefaults.data(forKey: key.rawValue)
        return StoreableType(storeData: data)
    }

    func writeStoreable<StoreableType>(key: LocalStorageKeysProtocol, value: StoreableType?) where StoreableType: Storeable {
        self.userDefaults.set(value?.storeData, forKey: key.rawValue)
    }
}
