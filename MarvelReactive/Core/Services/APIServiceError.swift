//
//  APIServiceError.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/14/20.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
