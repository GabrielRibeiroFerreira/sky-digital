//
//  ServiceProtocol.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//


import Foundation

protocol ServiceProtocol {
    typealias CallBack = (_ data: Data?, _ status: Bool, _ message:String) -> Void
    
    func getData(from url: String, parameters: [String: Any]?, callBack: @escaping CallBack) throws
}
