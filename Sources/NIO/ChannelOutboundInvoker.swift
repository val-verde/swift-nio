//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2017-2018 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
import Future

public protocol ChannelOutboundInvoker {
    
    func write(data: Any) -> Future<Void>
    func write(data: Any, promise: Promise<Void>) -> Future<Void>

    func flush()
    func read()
    
    func writeAndFlush(data: Any) -> Future<Void>
    func writeAndFlush(data: Any, promise: Promise<Void>) -> Future<Void>

    func close() -> Future<Void>
    func close(promise: Promise<Void>) -> Future<Void>
    
    var eventLoop: EventLoop { get }
}

public extension ChannelOutboundInvoker {
    public func write(data: Any) -> Future<Void> {
        return write(data: data, promise: eventLoop.newPromise(type: Void.self))
    }
    
    public func writeAndFlush(data: Any) -> Future<Void> {
        return writeAndFlush(data: data, promise: eventLoop.newPromise(type: Void.self))
    }
    
    public func close() -> Future<Void> {
        return close(promise: eventLoop.newPromise(type: Void.self))
    }
}
