//
//  Observable.swift
//  Millionaire
//
//  Created by Ксения Маричева on 25.08.2024.
//

import Foundation

class Observable<T> {
    
    typealias ObserverBlock = (T) -> Void
    
    var value: T {
        didSet {
            observers.forEach { $0(value) }
        }
    }
    
    private var observers: [ObserverBlock] = []
    
    init(value: T) {
        self.value = value
    }
    
    // @escaping - сбигающие замыкание(swift подскажет)
    func bind(observer: @escaping ObserverBlock) {
        observers.append(observer)
    }
}
