//
//  OnboardingScren.swift
//  MobilerOnboarding
//
//  Created by Doğancan Mavideniz on 11.06.2022.
//

import SwiftUI
var totalPages = 3
struct OnboardingScreen: View {

    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        ZStack {

            if currentPage == 1 {
                ScreenView(image: "one", title: "Step1", detail: "Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet", bgColor: Color("colorOne"))
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "two", title: "Step2", detail: "Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet", bgColor: Color("colorTwo"))
                    .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(image: "one", title: "Step3", detail: "Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet", bgColor: Color("colorThree"))
                    .transition(.scale)
            }
        }
            .overlay(
            Button(action: {
                withAnimation(.easeInOut) {
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                .padding(-15)

                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }.padding(-15)
                    )
                })
                .padding(.bottom, 20)
            , alignment: .bottom
        )
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}

struct ScreenView: View {

    var image: String
    var title: String
    var detail: String
    var bgColor: Color

    @AppStorage("currentPage") var currentPage = 1

    var body: some View {
        VStack(spacing: 20) {
            HStack {

                if currentPage == 1 {
                    Text("Welcome to App!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.5)
                } else {
                    Button {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }

                }
                Spacer()

                Button {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                }

            }
                .foregroundColor(.black)
                .padding()

            Spacer(minLength: 0)

            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)

            Text(detail)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Spacer(minLength: 140)
        }
            .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}
