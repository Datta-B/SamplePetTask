//
//  AppCordinator.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 16/03/26.
//

import Foundation
import Combine
import SwiftUI

// TO -DO
/// can also added extra functions like sheet,fullsheet(presentation)

enum HomeRoute: Hashable {

    case breedDetail(Breed)
}

class HomeRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ route: HomeRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}


class ProfileRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
//    func push(_ route: AppRoute) {
//        path.append(route)
//    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
