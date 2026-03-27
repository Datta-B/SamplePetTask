//
//  ViewTest.swift
//  Sample_DogProjectTests
//
//  Created by dattaz biradar on 27/03/26.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Sample_DogProject

final class BreedDetailViewTests: XCTestCase {
    
    func test_breedName_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let text = try sut.inspect()
            .find(text: Breed.mock.attributes.name)
            .string()
        
        XCTAssertEqual(text, Breed.mock.attributes.name)
    }
    
    func test_aboutBreedTitle_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let title = try sut.inspect()
            .find(text: BreedStrings.aboutBreed)
            .string()
        
        XCTAssertEqual(title, BreedStrings.aboutBreed)
    }
    
    func test_description_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let description = try sut.inspect()
            .find(text: Breed.mock.attributes.description)
            .string()
        
        XCTAssertEqual(description, Breed.mock.attributes.description)
    }
    
    func test_lifeSpanRow_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let expectedValue = "\(Breed.mock.attributes.life.min) - \(Breed.mock.attributes.life.max) \(BreedStrings.years)"
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: BreedStrings.lifeSpan)
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: expectedValue)
        )
    }
    
    func test_maleWeightRow_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let expectedValue = "\(Breed.mock.attributes.maleWeight.min) - \(Breed.mock.attributes.maleWeight.max) \(BreedStrings.kg)"
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: BreedStrings.maleWeight)
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: expectedValue)
        )
    }
    
    func test_femaleWeightRow_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let expectedValue = "\(Breed.mock.attributes.femaleWeight.min) - \(Breed.mock.attributes.femaleWeight.max) \(BreedStrings.kg)"
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: BreedStrings.femaleWeight)
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: expectedValue)
        )
    }
    
    func test_hypoallergenicRow_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        let expectedValue = Breed.mock.attributes.hypoallergenic ? BreedStrings.yes : BreedStrings.no
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: BreedStrings.hypoallergenic)
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: expectedValue)
        )
    }
    
    func test_groupIdRow_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: BreedStrings.groupId)
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(text: Breed.mock.relationships.group.data.id)
        )
    }
    
    func test_image_isDisplayed() throws {
        let sut = BreedDetailView(breed: .mock)
        
        XCTAssertNoThrow(
            try sut.inspect().find(ViewType.Image.self)
        )
    }
    
}

final class ProfileMenuItemViewTests: XCTestCase {
    
    func test_title_isDisplayed() throws {
        let sut = ProfileMenuItemView(
            icon: "gearshape",
            title: "Settings",
            action: {}
        )
        
        let text = try sut.inspect()
            .find(text: "Settings")
            .string()
        
        XCTAssertEqual(text, "Settings")
    }
    
    func test_leadingIcon_isDisplayed() throws {
        let sut = ProfileMenuItemView(
            icon: "gearshape",
            title: "Settings",
            action: {}
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(
                ViewType.Image.self,
                where: { image in
                    try image.actualImage().name() == "gearshape"
                }
            )
        )
    }
    
    func test_chevronIcon_isDisplayed() throws {
        let sut = ProfileMenuItemView(
            icon: "gearshape",
            title: "Settings",
            action: {}
        )
        
        XCTAssertNoThrow(
            try sut.inspect().find(
                ViewType.Image.self,
                where: { image in
                    try image.actualImage().name() == AppImages.chevronImage
                }
            )
        )
    }
    
    func test_buttonTap_triggersAction() throws {
        var didTap = false
        
        let sut = ProfileMenuItemView(
            icon: "gearshape",
            title: "Settings"
        ) {
            didTap = true
        }
        
        try sut.inspect().button().tap()
        
        XCTAssertTrue(didTap)
    }
}

final class RowViewTest : XCTestCase {
    func test_Row() throws {
        let sut = RowView(name: "hello", image: Image(AppImages.dogImage))
        
        let text = try sut.inspect()
            .find(text: "hello")
            .string()
        
        XCTAssertEqual(text, "hello")
        
    }
}


final class PrimaryButtonTest  : XCTestCase {
    func test_PrimaryButton_text() throws {
        let sut = PrimaryButton(title: "Login", radius: 2.0, backgroundColor: .red, textColor: .white, action: {})
        
        let text = try sut.inspect().find(text: "Login").string()
        XCTAssertEqual(text, "Login")
        
    }
    
    func test_PrimaryButton_foregroundColor() throws {
        let sut = PrimaryButton(title: "Login", radius: 2.0, backgroundColor: .red, textColor: .white, action: {})
        
        let text = try sut.inspect().find(ViewType.Text.self)
        let color = try text.attributes().foregroundColor()

        XCTAssertEqual(color, .white)
        
    }
    
    func test_PrimaryButton_backgroundColor() throws {
        let sut = PrimaryButton(title: "Login", radius: 2.0, backgroundColor: .red, textColor: .white, action: {})
        
        let button = try sut.inspect().find(ViewType.Button.self)
        let bgColor = try button.background().color().value()
        
        XCTAssertEqual(bgColor, .red)
        
    }
    
    func test_PrimaryButton_Tap() throws {
        var didTap = false
        
        let sut = PrimaryButton(
            title: "Login",
            radius: 8,
            backgroundColor: .red,
            textColor: .white,
            action: {
                didTap = true
            }
        )
        
        try sut.inspect().find(ViewType.Button.self).tap()
        
        XCTAssertTrue(didTap)
    }
}

final class LogoutButtonTest  : XCTestCase {
    func test_logoutButton_text() throws {
        let sut = LogOutButton(action: {}, title: "Logout")
        let text = try sut.inspect().find(text: "Logout").string()
        XCTAssertEqual(text, "Logout")
    }
    
    func test_logoutButton_Tap() throws {
        var didTap = false
        let sut = LogOutButton(action: {
            didTap = true
        }, title: "Logout")
        
        try sut.inspect().find(ViewType.Button.self).tap()
        XCTAssertTrue(didTap)
    }
}

final class CustomAlertViewText : XCTestCase {
    
    func test_customAlert_titleAndMesageText() throws {
        
        let sut = CustomAlertView(isPresented: .constant(true),title: "welcome",message: "Sign in", primaryButtonLabel: "Ok", primaryButtonAction: {}, color: .appPrimary)
        
        XCTAssertNoThrow(try sut.inspect().find(text: "welcome"))
        XCTAssertNoThrow(try sut.inspect().find(text: "Sign in"))
    }
    
    func test_customAlert_showsButtonLabel() throws {
        
        let sut = CustomAlertView(isPresented: .constant(true),title: "welcome",message: "Sign in", primaryButtonLabel: "Ok", primaryButtonAction: {}, color: .appPrimary)
        
        XCTAssertNoThrow(try sut.inspect().find(text: "Ok"))
    }
    
    func test_CustomAlertView_ButtonTap() throws {
        var didTapButton = false
        
        let sut = CustomAlertView(
            isPresented: .constant(true),
            title: "Welcome",
            message: "Sign in",
            primaryButtonLabel: "Ok",
            primaryButtonAction: {
                didTapButton = true
            },
            color: .appPrimary
        )
        
        try sut.inspect().find(ViewType.Button.self).tap()
        
        XCTAssertTrue(didTapButton)
    }
    
}

final class TextFieldTest : XCTestCase {
    
    func test_textField_withOutSecure() throws {
        let sut = TextFieldsViews(placeHolder: "", isSecureField: false, label: "", text: .constant(""))
        XCTAssertNoThrow(try sut.inspect().find(ViewType.TextField.self))
    }
    
    func test_textField_WithSecure() throws {
        let sut = TextFieldsViews(placeHolder: "", isSecureField: true, label: "", text: .constant(""))
        XCTAssertNoThrow(try sut.inspect().find(ViewType.SecureField.self))
    }
}
