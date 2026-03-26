//
//  CustomeAlert.swift
//  Sample_DogProject
//
//  Created by dattaz biradar on 25/03/26.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Binding var isPresented: Bool

    var title: String?
    var message: String?
    var primaryButtonLabel: String
    var primaryButtonAction: () -> Void
    var secondaryButtonLabel: String?
    var secondaryButtonAction: (() -> Void)?
    var color : Color
    var image: Image?
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else if let title = title{
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            if let message = message {
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            HStack(spacing: 16) {
                Button(action: {
                    self.primaryButtonAction()
                    isPresented = false
                }, label: {
                    Text(primaryButtonLabel)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(color)
                        .cornerRadius(12)
                })
                if let secondaryButtonLabel = secondaryButtonLabel {
                    Button(action: {
                        self.secondaryButtonAction?()
                        isPresented = false
                    }, label: {
                        Text(secondaryButtonLabel)
                            .font(.headline)
                            .foregroundColor(color)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(color, lineWidth: 2)
                            )
                    })
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}



struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresented: .constant(true), title: "Success!", message: "Your profile was updated successfully.", primaryButtonLabel: "OK", primaryButtonAction: {}, color: .appPrimary)
                .previewLayout(.sizeThatFits)
                .padding()
            
    }
}
