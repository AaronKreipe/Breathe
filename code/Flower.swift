import SwiftUI

struct Flower: View{
    @State
    var petals: Int = 6
    @State
    var diameter: CGFloat = 50
    @State
    var color: Color = Color(UIColor.cyan)
    @State
    var breatheDuration: TimeInterval = 7
    @State
    private var offset: CGFloat = 0
    @State
    private var angle: Angle = .zero
    private func flipOffset(){
        if self.offset == 0{
            self.offset = (diameter * 0.5) - 1
        }else{
            self.offset = 0
        }
    }
    private func flipAngle(){
        if angle == .zero{
            angle = Angle(degrees: 45)
        }else{
            angle = .zero
        }
    }
    
    var body: some View{
        ZStack{
            Group{
                ForEach(0..<self.petals){i in
                    Circle()
                        .fill(self.color.opacity(1/Double(self.petals)))
                        .hueRotation(Angle(degrees: (Double(i) * 5)))
                        .offset(x: self.offset, y: 0)
                        .rotationEffect(Angle(degrees: (360/Double(self.petals)) * Double(i)))
                }
            }
            .rotationEffect(self.angle)
            .animation(.easeInOut(duration: self.breatheDuration))
        }
        .frame(width: diameter, height: diameter)
        .onAppear{
            self.flipAngle()
            self.flipOffset()
            Timer.scheduledTimer(withTimeInterval: self.breatheDuration, repeats: true){_ in
                self.flipAngle()
                self.flipOffset()
            }
        }
    }
}

