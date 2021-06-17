//
//  Shaking.swift
//  ToDo
//
//  Created by Camille Khubbetdinov on 617..2021.
//

import SwiftUI

struct Shacking: ViewModifier {
    var angle: Double = 2.0
    let timerPublisher = Timer.publish(every: 0.1, tolerance: 0.01, on: .main, in: .common)
        .autoconnect()
        .delay(for: .seconds(
            Double.random(in: 0.0...0.5)
        ), tolerance: 0.01, scheduler: RunLoop.main)
    @Binding var isShacking: Bool
    @State var timerReciever = false
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isShacking ? (timerReciever ? angle : -angle) : 0))
            .onReceive(timerPublisher, perform: { _ in
                withAnimation(.easeOut(duration: 0.1)) { timerReciever.toggle() }
            })
    }
}

extension View {
    func shacking(deflectionAngle angle: Double, isShacking: Binding<Bool>) -> some View {
        self.modifier(Shacking(angle: angle, isShacking: isShacking))
    }
    func shacking(isShacking: Binding<Bool>) -> some View {
        self.modifier(Shacking(isShacking: isShacking))
    }
}

struct ShakingView: View {
    var body: some View {
        Text("Hello, World!")
            .shacking(isShacking: .constant(true))
    }
}

struct Shaking_Previews: PreviewProvider {
    static var previews: some View {
        ShakingView()
    }
}
