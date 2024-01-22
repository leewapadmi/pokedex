//
//  BaseApi.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation

class BaseApi {
    let session: CommsSession

    init(session: CommsSession) {
        self.session = session
    }
}
