// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import XCTest
import Combine
import Foundation
@testable import pokedex


// MARK: - AllPokemonUseCase

open class AllPokemonUseCaseMock: AllPokemonUseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getAllPokemon() -> AnyPublisher<[PokemonDetails], Error> {
        addInvocation(.m_getAllPokemon)
		let perform = methodPerformValue(.m_getAllPokemon) as? () -> Void
		perform?()
		var __value: AnyPublisher<[PokemonDetails], Error>
		do {
		    __value = try methodReturnValue(.m_getAllPokemon).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getAllPokemon(). Use given")
			Failure("Stub return value not specified for getAllPokemon(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getAllPokemon

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getAllPokemon, .m_getAllPokemon): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getAllPokemon: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getAllPokemon: return ".getAllPokemon()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getAllPokemon(willReturn: AnyPublisher<[PokemonDetails], Error>...) -> MethodStub {
            return Given(method: .m_getAllPokemon, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getAllPokemon(willProduce: (Stubber<AnyPublisher<[PokemonDetails], Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[PokemonDetails], Error>] = []
			let given: Given = { return Given(method: .m_getAllPokemon, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[PokemonDetails], Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getAllPokemon() -> Verify { return Verify(method: .m_getAllPokemon)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getAllPokemon(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAllPokemon, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ImagePreloader

open class ImagePreloaderMock: ImagePreloader, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func preloadImages(rawUrls: [String], withTimeout timeoutSeconds: Double) -> AnyPublisher<Void, Error> {
        addInvocation(.m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(Parameter<[String]>.value(`rawUrls`), Parameter<Double>.value(`timeoutSeconds`)))
		let perform = methodPerformValue(.m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(Parameter<[String]>.value(`rawUrls`), Parameter<Double>.value(`timeoutSeconds`))) as? ([String], Double) -> Void
		perform?(`rawUrls`, `timeoutSeconds`)
		var __value: AnyPublisher<Void, Error>
		do {
		    __value = try methodReturnValue(.m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(Parameter<[String]>.value(`rawUrls`), Parameter<Double>.value(`timeoutSeconds`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for preloadImages(rawUrls: [String], withTimeout timeoutSeconds: Double). Use given")
			Failure("Stub return value not specified for preloadImages(rawUrls: [String], withTimeout timeoutSeconds: Double). Use given")
		}
		return __value
    }

    open func preloadImages(rawUrls: [String]) -> AnyPublisher<Void, Error> {
        addInvocation(.m_preloadImages__rawUrls_rawUrls(Parameter<[String]>.value(`rawUrls`)))
		let perform = methodPerformValue(.m_preloadImages__rawUrls_rawUrls(Parameter<[String]>.value(`rawUrls`))) as? ([String]) -> Void
		perform?(`rawUrls`)
		var __value: AnyPublisher<Void, Error>
		do {
		    __value = try methodReturnValue(.m_preloadImages__rawUrls_rawUrls(Parameter<[String]>.value(`rawUrls`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for preloadImages(rawUrls: [String]). Use given")
			Failure("Stub return value not specified for preloadImages(rawUrls: [String]). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(Parameter<[String]>, Parameter<Double>)
        case m_preloadImages__rawUrls_rawUrls(Parameter<[String]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(let lhsRawurls, let lhsTimeoutseconds), .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(let rhsRawurls, let rhsTimeoutseconds)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawurls, rhs: rhsRawurls, with: matcher), lhsRawurls, rhsRawurls, "rawUrls"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTimeoutseconds, rhs: rhsTimeoutseconds, with: matcher), lhsTimeoutseconds, rhsTimeoutseconds, "withTimeout timeoutSeconds"))
				return Matcher.ComparisonResult(results)

            case (.m_preloadImages__rawUrls_rawUrls(let lhsRawurls), .m_preloadImages__rawUrls_rawUrls(let rhsRawurls)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawurls, rhs: rhsRawurls, with: matcher), lhsRawurls, rhsRawurls, "rawUrls"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(p0, p1): return p0.intValue + p1.intValue
            case let .m_preloadImages__rawUrls_rawUrls(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds: return ".preloadImages(rawUrls:withTimeout:)"
            case .m_preloadImages__rawUrls_rawUrls: return ".preloadImages(rawUrls:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func preloadImages(rawUrls: Parameter<[String]>, withTimeout timeoutSeconds: Parameter<Double>, willReturn: AnyPublisher<Void, Error>...) -> MethodStub {
            return Given(method: .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(`rawUrls`, `timeoutSeconds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func preloadImages(rawUrls: Parameter<[String]>, willReturn: AnyPublisher<Void, Error>...) -> MethodStub {
            return Given(method: .m_preloadImages__rawUrls_rawUrls(`rawUrls`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func preloadImages(rawUrls: Parameter<[String]>, withTimeout timeoutSeconds: Parameter<Double>, willProduce: (Stubber<AnyPublisher<Void, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Error>] = []
			let given: Given = { return Given(method: .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(`rawUrls`, `timeoutSeconds`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Error>).self)
			willProduce(stubber)
			return given
        }
        public static func preloadImages(rawUrls: Parameter<[String]>, willProduce: (Stubber<AnyPublisher<Void, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Error>] = []
			let given: Given = { return Given(method: .m_preloadImages__rawUrls_rawUrls(`rawUrls`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func preloadImages(rawUrls: Parameter<[String]>, withTimeout timeoutSeconds: Parameter<Double>) -> Verify { return Verify(method: .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(`rawUrls`, `timeoutSeconds`))}
        public static func preloadImages(rawUrls: Parameter<[String]>) -> Verify { return Verify(method: .m_preloadImages__rawUrls_rawUrls(`rawUrls`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func preloadImages(rawUrls: Parameter<[String]>, withTimeout timeoutSeconds: Parameter<Double>, perform: @escaping ([String], Double) -> Void) -> Perform {
            return Perform(method: .m_preloadImages__rawUrls_rawUrlswithTimeout_timeoutSeconds(`rawUrls`, `timeoutSeconds`), performs: perform)
        }
        public static func preloadImages(rawUrls: Parameter<[String]>, perform: @escaping ([String]) -> Void) -> Perform {
            return Perform(method: .m_preloadImages__rawUrls_rawUrls(`rawUrls`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - PokemonApi

open class PokemonApiMock: PokemonApi, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getAllPokemon() -> AnyPublisher<ListAllPokemonResponse, Error> {
        addInvocation(.m_getAllPokemon)
		let perform = methodPerformValue(.m_getAllPokemon) as? () -> Void
		perform?()
		var __value: AnyPublisher<ListAllPokemonResponse, Error>
		do {
		    __value = try methodReturnValue(.m_getAllPokemon).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getAllPokemon(). Use given")
			Failure("Stub return value not specified for getAllPokemon(). Use given")
		}
		return __value
    }

    open func getPokemon(with id: String) -> AnyPublisher<PokemonDetails, Error> {
        addInvocation(.m_getPokemon__with_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_getPokemon__with_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: AnyPublisher<PokemonDetails, Error>
		do {
		    __value = try methodReturnValue(.m_getPokemon__with_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getPokemon(with id: String). Use given")
			Failure("Stub return value not specified for getPokemon(with id: String). Use given")
		}
		return __value
    }

    open func getPokemonSpecies(with id: String) -> AnyPublisher<PokemonSpecies, Error> {
        addInvocation(.m_getPokemonSpecies__with_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_getPokemonSpecies__with_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: AnyPublisher<PokemonSpecies, Error>
		do {
		    __value = try methodReturnValue(.m_getPokemonSpecies__with_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getPokemonSpecies(with id: String). Use given")
			Failure("Stub return value not specified for getPokemonSpecies(with id: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getAllPokemon
        case m_getPokemon__with_id(Parameter<String>)
        case m_getPokemonSpecies__with_id(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getAllPokemon, .m_getAllPokemon): return .match

            case (.m_getPokemon__with_id(let lhsId), .m_getPokemon__with_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "with id"))
				return Matcher.ComparisonResult(results)

            case (.m_getPokemonSpecies__with_id(let lhsId), .m_getPokemonSpecies__with_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "with id"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getAllPokemon: return 0
            case let .m_getPokemon__with_id(p0): return p0.intValue
            case let .m_getPokemonSpecies__with_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getAllPokemon: return ".getAllPokemon()"
            case .m_getPokemon__with_id: return ".getPokemon(with:)"
            case .m_getPokemonSpecies__with_id: return ".getPokemonSpecies(with:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getAllPokemon(willReturn: AnyPublisher<ListAllPokemonResponse, Error>...) -> MethodStub {
            return Given(method: .m_getAllPokemon, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPokemon(with id: Parameter<String>, willReturn: AnyPublisher<PokemonDetails, Error>...) -> MethodStub {
            return Given(method: .m_getPokemon__with_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPokemonSpecies(with id: Parameter<String>, willReturn: AnyPublisher<PokemonSpecies, Error>...) -> MethodStub {
            return Given(method: .m_getPokemonSpecies__with_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getAllPokemon(willProduce: (Stubber<AnyPublisher<ListAllPokemonResponse, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<ListAllPokemonResponse, Error>] = []
			let given: Given = { return Given(method: .m_getAllPokemon, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<ListAllPokemonResponse, Error>).self)
			willProduce(stubber)
			return given
        }
        public static func getPokemon(with id: Parameter<String>, willProduce: (Stubber<AnyPublisher<PokemonDetails, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PokemonDetails, Error>] = []
			let given: Given = { return Given(method: .m_getPokemon__with_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PokemonDetails, Error>).self)
			willProduce(stubber)
			return given
        }
        public static func getPokemonSpecies(with id: Parameter<String>, willProduce: (Stubber<AnyPublisher<PokemonSpecies, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PokemonSpecies, Error>] = []
			let given: Given = { return Given(method: .m_getPokemonSpecies__with_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PokemonSpecies, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getAllPokemon() -> Verify { return Verify(method: .m_getAllPokemon)}
        public static func getPokemon(with id: Parameter<String>) -> Verify { return Verify(method: .m_getPokemon__with_id(`id`))}
        public static func getPokemonSpecies(with id: Parameter<String>) -> Verify { return Verify(method: .m_getPokemonSpecies__with_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getAllPokemon(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAllPokemon, performs: perform)
        }
        public static func getPokemon(with id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getPokemon__with_id(`id`), performs: perform)
        }
        public static func getPokemonSpecies(with id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getPokemonSpecies__with_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - PokemonDetailUseCase

open class PokemonDetailUseCaseMock: PokemonDetailUseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getPokemonDescription(id: String) -> AnyPublisher<String?, Error> {
        addInvocation(.m_getPokemonDescription__id_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_getPokemonDescription__id_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: AnyPublisher<String?, Error>
		do {
		    __value = try methodReturnValue(.m_getPokemonDescription__id_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getPokemonDescription(id: String). Use given")
			Failure("Stub return value not specified for getPokemonDescription(id: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getPokemonDescription__id_id(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getPokemonDescription__id_id(let lhsId), .m_getPokemonDescription__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getPokemonDescription__id_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getPokemonDescription__id_id: return ".getPokemonDescription(id:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getPokemonDescription(id: Parameter<String>, willReturn: AnyPublisher<String?, Error>...) -> MethodStub {
            return Given(method: .m_getPokemonDescription__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getPokemonDescription(id: Parameter<String>, willProduce: (Stubber<AnyPublisher<String?, Error>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<String?, Error>] = []
			let given: Given = { return Given(method: .m_getPokemonDescription__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<String?, Error>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getPokemonDescription(id: Parameter<String>) -> Verify { return Verify(method: .m_getPokemonDescription__id_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getPokemonDescription(id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getPokemonDescription__id_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

