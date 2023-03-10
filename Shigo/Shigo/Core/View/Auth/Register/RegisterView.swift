//
//  RegisterView.swift
//  Shigo
//
//  Created by NomoteteS on 5.03.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel: RegisterViewModel = .init()
    @EnvironmentObject var coordinator : AuthCoordinator
    
    var body: some View {
        NavigationView {
            ZStack {
                PrimaryBackground()
                VStack {
                    VStack {
                        if let image = viewModel.image {
                            image
                                .resizable()
                        }else {
                            Button {
                                viewModel.isImagePickerSelected.toggle()
                            } label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.shigoPurple)
                                    .frame(width: 96,height: 96)
                                    
                                    Text("+")
                                        .font(.system(size: 100))
                                        .foregroundColor(.white)
                                        .padding(.bottom)
                                }
                            }
                        }
                    }
                    .frame(width: 126,height: 126)
                    .clipShape(Circle())
                    .padding(.top,50)
                    
                    .sheet(isPresented: $viewModel.isImagePickerSelected,
                           onDismiss: viewModel.loadedImage) {
                        ImagePicker(image: $viewModel.uiImager)
                    }

                    //MARK: RegisterView - Textfield space
                    ZStack {
                        Rectangle()
                            
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .padding()
                        //MARK: RegisterView - TextFields
                        VStack {
                            VStack(spacing: 25) {
                                CustomTextField(text: "E-Mail",
                                                textField: $viewModel.email)
                                .keyboardType(.emailAddress)
                                CustomTextField(text: "??sminiz",
                                                textField: $viewModel.name)
                                .keyboardType(.default)
                                SecureCustomTextField(text: "??ifreniz",
                                                textField: $viewModel.password)
                                SecureCustomTextField(text: "Tekrar ??ifreniz",
                                                textField: $viewModel.againPassword)
                            }
                            .padding(.all)
                            let status = (viewModel.password.count == viewModel.againPassword.count)
                            AuthChangeButton(text: "??YE OL",
                                              color: .shigoPurple,
                                              textColor: .white) {
                                if status {
                                   
                                    AuthManager.shared.regitser(email: viewModel.email, password: viewModel.password, name: viewModel.name,image: (viewModel.uiImager ?? UIImage(named: "unknownImage"))!)
                                    
                                    if AuthManager.shared.correctAuth {
                                        viewModel.isSkiptoPage.toggle()
                                    }
                                }
                            }
                                              .padding(.horizontal)
                                              .padding(.all)
                        }
                        
                    }
                    .padding(EdgeInsets.init(top: 30, leading: 20, bottom: 90, trailing: 20))
                    AuthChangeButton(text: "G??R???? YAP") {
                        coordinator.push(.loginView)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isSkiptoPage) {
            MainTabBar()
                .navigationBarBackButtonHidden()
        }
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
