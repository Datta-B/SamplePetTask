//
//  AppCordinator.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Combine
import SwiftUI

enum AppRoute: Hashable {

    case breedDetail(Breed)
}

class Router: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
