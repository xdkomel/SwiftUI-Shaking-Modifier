# SwiftUI-Shaking-Modifier
This is a SwiftUI View modifier allowing for any view to shake like the icons on the iOS home screen do while editing their arrangment.

### How to
You can use it for any view (Text here) either by
<code>
Text("Hello, World!").shacking(isShacking: $isShacking)
</code>
or 
<code>
Text("Hello, World!").shacking(deflectionAngle: angle, isShacking: $isShacking)
</code>. Deflection angle here is the angle the view will rotate on while shaking.

### Source code
Just copy and paste it in a separate file in your project:
```Swift
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
