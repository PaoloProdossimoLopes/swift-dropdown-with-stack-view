//
//  ExtractSections.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 06/04/22.
//

enum ExtractSections: CaseIterable {
    case `current`
    case future
    case statements
    case costs
    case cashFlux
    
    var sectionName: String {
        switch self {
        case .current: return "atual"
        case .future: return "futuro"
        case .statements: return "demonstrativos"
        case .costs: return "encargos"
        case .cashFlux: return "fluxo de caixa"
        }
    }
}
