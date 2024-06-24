//
//  Combine+Expect.swift
//  pokedexTests
//
//  Created by Lee Wilson on 20/06/2024.
//

import Foundation
import XCTest
import Combine

@testable import pokedex

extension XCTestCase {
    
    enum Constants {
        static let defaultTimeout: TimeInterval = 1.0
    }

    func expectPublishedVoid<Failure: Error>(
        from publisher: AnyPublisher<Void, Failure>,
        dropFirst dropCount: Int = 0,
        timeout: TimeInterval = 1.0,
        storeIn cancellables: inout [AnyCancellable],
        when testBlock: () -> Void
    ) {
        let emitted = expectation(description: "emits Void()")
        let onlyOnce = expectation(description: "emits one value only")
        onlyOnce.expectedFulfillmentCount = 1
        onlyOnce.assertForOverFulfill = true

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    onlyOnce.fulfill()
                    emitted.fulfill()
                  })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    
    func expectPublished<Output: Equatable, Failure: Error>(
        output expected: Output,
        from publisher: AnyPublisher<Output, Failure>,
        dropFirst dropCount: Int = 0,
        timeout: TimeInterval = 1.0,
        storeIn cancellables: inout [AnyCancellable],
        when testBlock: () -> Void
    ) {
        let emitted = expectation(description: "emits \(expected)")
        let onlyOnce = expectation(description: "emits one value only")
        onlyOnce.expectedFulfillmentCount = 1
        onlyOnce.assertForOverFulfill = true

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    onlyOnce.fulfill()
                    if value == expected {
                        emitted.fulfill()
                    }
                  })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func expectPublishedTestAfter<Output: Equatable, Failure: Error>(
        output expected: Output,
        from publisher: AnyPublisher<Output, Failure>,
        dropFirst dropCount: Int = 0,
        timeout: TimeInterval = 1.0,
        storeIn cancellables: inout [AnyCancellable],
        after testBlock: () -> Void
    ) {
        let emitted = expectation(description: "emits \(expected)")
        let onlyOnce = expectation(description: "emits one value only")
        onlyOnce.expectedFulfillmentCount = 1
        onlyOnce.assertForOverFulfill = true

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    onlyOnce.fulfill()
                    if value == expected {
                        emitted.fulfill()
                    }
                  })
            .store(in: &cancellables)

        waitForExpectations(timeout: timeout, handler: nil)

        testBlock()
    }

    func expectPublishedSuccess<Output: Equatable, Failure: Error>(
        from publisher: AnyPublisher<Output, Failure>,
        dropFirst dropCount: Int = 0,
        timeout: TimeInterval = 1.0,
        storeIn cancellables: inout [AnyCancellable],
        when testBlock: () -> Void
    ) {
        let onlyOnce = expectation(description: "emits one value only")
        onlyOnce.expectedFulfillmentCount = 1
        onlyOnce.assertForOverFulfill = true

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    onlyOnce.fulfill()
                  })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectNothingPublished<Output: Equatable, Failure: Error>(
        from publisher: AnyPublisher<Output, Failure>,
        dropFirst dropCount: Int = 0,
        storeIn cancellables: inout [AnyCancellable],
        timeout: TimeInterval = 1.0,
        when testBlock: () -> Void
    ) {
        let zeroTimes = expectation(description: "emits no values")
        zeroTimes.isInverted = true

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    zeroTimes.fulfill()
                  })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectPublishedOnMain<Output: Equatable>(
        from publisher: AnyPublisher<Output, Never>,
        dropFirst dropCount: Int = 0,
        storeIn cancellables: inout [AnyCancellable],
        timeout: TimeInterval = 1.0,
        when testBlock: () -> Void
    ){
        let expect = expectation(description: "runs")
        publisher.receive(on: RunLoop.main)
            .sink { _ in
                expect.fulfill()
            }.store(in: &cancellables)
        waitForExpectations(timeout: timeout, handler: nil)
        testBlock()
    }
    


    func expectPublished<Output: Equatable, Failure: Error>(
        outputs expected: [Output],
        from publisher: AnyPublisher<Output, Failure>,
        dropFirst dropCount: Int = 0,
        timeout: TimeInterval = 1.0,
        storeIn cancellables: inout [AnyCancellable],
        when testBlock: () -> Void
    ) {
        let emissions = expected.map {
            expectation(description: "emits \($0)")
        }

        let onlyNTimes = expectation(description: "emits \(expected.count) values only")
        onlyNTimes.expectedFulfillmentCount = expected.count
        onlyNTimes.assertForOverFulfill = true

        var currentExpectedIndex = 0

        publisher
            .dropFirst(dropCount)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    onlyNTimes.fulfill()
                    if value == expected[currentExpectedIndex] {
                        emissions[currentExpectedIndex].fulfill()
                        currentExpectedIndex += 1
                    }
                  })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectPublisherFailure<Output: Any, Failure: Equatable>(
        error expectedError: Failure,
        from publisher: AnyPublisher<Output, Failure>,
        storeIn cancellables: inout [AnyCancellable],
        timeout: TimeInterval = 1.0,
        when testBlock: () -> Void
    ) {
        let fails = expectation(description: "Fails with \(expectedError)")
        publisher
            .sink(receiveCompletion: { completion in
                if case let .failure(compError) = completion {
                    if compError == expectedError {
                        fails.fulfill()
                    }
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectPublisherFailure<Output: Any>(
        from publisher: AnyPublisher<Output, Error>,
        storeIn cancellables: inout [AnyCancellable],
        timeout: TimeInterval = 1.0,
        when testBlock: () -> Void
    ) {
        let fails = expectation(description: "Publisher fails")
        publisher
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    fails.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        testBlock()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectFutureFailure<Output: Any, ErrType>(
        _ future: Future<Output, ErrType>,
        storeIn cancellables: inout [AnyCancellable],
        timeout: TimeInterval = 1.0,
        when testBlock: (() -> Void)? = nil
    ) {
        let fails = expectation(description: "Publisher fails")
        future
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    fails.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        testBlock?()

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expectFuture<T, ErrorType>(_ future: Future<T, ErrorType>,
                                    storeIn cancellables: inout [AnyCancellable],
                                    _ condition: @escaping (T) -> Bool,
                                    _ message: String = "",
                                    _ timeout: TimeInterval = Constants.defaultTimeout,
                                    _ file: StaticString = #filePath,
                                    _ line: UInt = #line) {
        
        let waiter = XCTestExpectation(description: "waiter")
        future.sink(receiveCompletion: { error in
            switch error {
            case .failure(let error):
                XCTFail(message + (message.count > 0 ? " " : "") + error.localizedDescription, file: file, line: line)
                waiter.fulfill()
            case .finished:
                break
            }
        }, receiveValue: { value in
            XCTAssertTrue(condition(value))
            waiter.fulfill()
        }).store(in: &cancellables)
        wait(for: [waiter], timeout: timeout)
    }
}
