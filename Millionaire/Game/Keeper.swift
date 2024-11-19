//
//  Keeper.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 09.06.2024.
//

import Foundation

class Keeper <T: Codable> {
    private let caretaker = Caretaker<T>()
    
    private let key = String(describing: T.self)
    
    func save(_ items: [T]) {
        caretaker.save(items, key: key)
    }
    
    func load() -> [T] {
        caretaker.load(key: key)
    }
    
    func erase() {
        caretaker.save([], key: key)
    }
}
