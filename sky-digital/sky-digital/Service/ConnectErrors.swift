//
//  ConnectErrors.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

enum ConnectErrors: Error {
    case receivedFailure
}

struct ErrorMessage : Codable {
    let code : Int
    let status : String
}
