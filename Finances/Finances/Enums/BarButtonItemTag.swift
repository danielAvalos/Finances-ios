//
//  BarButtonItemTag.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

enum BarButtonItemTag: Int {
    case logout

    var title: String {
        switch self {
        case .logout:
            return "Cerrar Sessión"
        }
    }
}
