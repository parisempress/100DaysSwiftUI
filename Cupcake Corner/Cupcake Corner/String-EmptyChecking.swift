//
//  String-EmptyChecking.swift
//  Cupcake Corner
//
//  Created by Rochelle Simone Lawrence on 24.07.24.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
