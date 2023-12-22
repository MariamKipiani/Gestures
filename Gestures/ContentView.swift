//
//  ContentView.swift
//  Gestures
//
//  Created by user on 12/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var opacity: Double = 1.0
    @State private var hue: Double = 0.0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("Image1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(TapGesture(count: 2)
                        .onEnded {
                            opacity = self.opacity == 1.0 ? 0.5 : 1.0
                        }
                    )
                    .opacity(opacity)
                resetButtonStyle {
                    opacity = 1.0
                }

                Image("Image2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(LongPressGesture(minimumDuration: 2)
                        .onEnded { _ in
                            hue = hue == 0.0 ? 0.5 : 0.0
                        }
                    )
                    .hueRotation(Angle(degrees: hue * 360))
                resetButtonStyle {
                    hue = 0.0
                }

                Image("Image3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            scale = value.magnitude
                        }
                    )
                    .scaleEffect(scale)
                resetButtonStyle {
                    scale = 1.0
                }

                Image("Image4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .gesture(RotationGesture()
                        .onChanged { value in
                            rotation = value
                        }
                    )
                    .rotationEffect(rotation)
                resetButtonStyle {
                    rotation = .zero
                }

                Image("Image5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(offset)
                    .gesture(DragGesture()
                        .onChanged { value in
                            offset = CGSize(width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height)
                        }
                        .onEnded { value in
                            lastOffset = offset
                        }
                    )
                resetButtonStyle {
                    offset = .zero
                    lastOffset = .zero
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }

    private func resetButtonStyle(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text("Reset")
                .padding(10)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView()
}
