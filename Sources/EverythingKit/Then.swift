//
//  Then
//  Then.swift
//  EverythingKitMaster
//
//  Created by Jonathan Pappas on 1/27/22.
//

import Foundation

public protocol Then {}

extension Then where Self: Any {
  @inlinable
  public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
    var copy = self
    try block(&copy)
    return copy
  }
  @inlinable
  public func `do`(_ block: (Self) throws -> Void) rethrows {
    try block(self)
  }

}

extension Then where Self: AnyObject {
  @inlinable @discardableResult
  public func then(_ block: (Self) throws -> Void) rethrows -> Self {
    try block(self)
    return self
  }
}

extension Then where Self: NSObject {
    @inlinable
    public var copied: Self {
        return self.copy() as! Self
    }
}

extension NSObject: Then {
}



