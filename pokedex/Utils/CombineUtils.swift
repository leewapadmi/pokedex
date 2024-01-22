//
//  CombineUtils.swift
//  pokedex
//
//  Created by Lee Wilson on 19/01/2024.
//

import Foundation
import Combine

extension Publisher {
    /// Convenience method when you don't care about completion (e.g. Failure is Never)
    func sinkMain(receiveValue: @escaping (Output) -> Void) -> AnyCancellable {
        return receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in /* empty implementation */ }, receiveValue: receiveValue)
    }

    /// Convenience method to subscribe on the main thread
    func sinkMain(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
                  receiveValue: @escaping (Output) -> Void) -> AnyCancellable {
        return receive(on: RunLoop.main)
                .sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
    }

    /// Convenience method when you don't care about return value
    func sinkMain(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void) -> AnyCancellable {
        return receive(on: RunLoop.main)
            .sink(receiveCompletion: receiveCompletion, receiveValue: { _ in /* empty implementation */ })
    }

    func assignMain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
                          on object: Root,
                          store: inout Set<AnyCancellable>) where Self.Failure == Never {
        self.receive(on: RunLoop.main)
            .assign(to: keyPath, on: object)
            .store(in: &store)
    }
    
    func noop(store: inout Set<AnyCancellable>) {
        self.receive(on: RunLoop.main).sink(
            receiveCompletion: { debugPrint("\(#function): receiveCompletion: \($0)") },
            receiveValue: { _ in /* empty implementation */  }
        ).store(in: &store)
    }
}
