//
//  StringUtils.swift
//  pokedex
//
//  Created by Lee Wilson on 26/06/2024.
//

extension Int {
    func formatId() -> String {
        let withLeading = String(format: "%03d", self)
        return "#\(withLeading)"
    }
}
