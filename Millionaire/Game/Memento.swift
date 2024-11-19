//
//  Memento.swift
//  Millionaire
//
//  Created by Ksenia Maricheva on 28.05.2024.
//

import Foundation

// Memento
typealias Memento = Data

// Oригинатор
struct RecordsOriginator: Codable {
    let score: Int
    let date: String
}

// Xранитель
class Caretaker <T: Codable>{
    
    func save(_ items: [T], key: String) {
        do {
            let data: Memento = try JSONEncoder().encode(items)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch { print(error) }
    }
    
    func load(key: String) -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }
}





