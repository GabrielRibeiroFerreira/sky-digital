//
//  DetailsPresenter.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 09/02/21.
//

import Foundation


public class DetailsPresenter {
    typealias DataListCallBack = (_ dataList: [Movie]?, _ status: Bool, _ message: String) -> Void
    typealias ImageCallBack = (_ imageData: Data?, _ status: Bool, _ message: String) -> Void
    
    init(service: ServiceProtocol = Service()) {
//        self.service = service
    }
}
