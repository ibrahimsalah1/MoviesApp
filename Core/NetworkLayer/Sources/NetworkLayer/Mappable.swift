//
//  Mappable.swift
//  
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import Foundation

public protocol Mappable {
    associatedtype Input: Decodable
    associatedtype Output

    func map(_ input: Input) throws -> Output
}
