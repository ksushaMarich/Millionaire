//
//  ShuffleMode.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 22.07.2024.
//

import Foundation

class ValueKeeper<T> {
    
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    func save(_ value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func load() -> T? {
        UserDefaults.standard.object(forKey: key) as? T
    }
}
