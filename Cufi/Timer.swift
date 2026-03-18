//
//  Timer.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI

struct TimerView: View {
    @State var timer: Timer? = nil
    let recipe: Recipe
    @State var duration: Double = 0
    @State var remaining: Double = 0
    @State var step: Int = 0
    @State var targetWater: Int = 0
    @State var done = false
    var body: some View {
        let steps = recipe.steps
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 0, to: (remaining/duration))
                .stroke(
                    done ? .green : .blue,
                    lineWidth: 20
                )
                .rotationEffect(.degrees(-90))
            if !done {
                VStack {
                    HStack(alignment: .center) {
                        Text("\(steps[step].what)")
                            .font(.title3.bold())
                    }
                    Text("\(Int(remaining))s")
                        .font(.largeTitle.bold())
                    Text("Water Target: \(targetWater)ml")
                    Text("Water to Pour: \(steps[step].qty)ml")
                    Button("\(timer == nil ? "Start" : "Pause")", action: {
                        if timer == nil {
                            timerStart()
                        } else {
                            timerEnd()
                        }
                    })
                    .buttonStyle(.glass)
                    .tint(timer == nil ? .blue : .red)
                }
            } else {
                Text("Enjoy your Cufi!")
                    .font(.title.bold())
            }
        }
        .onChange(of: step, initial: true) { oV, nV in
                withAnimation {
                    duration = Double(recipe.steps[nV].duration)
                    remaining = duration
                    targetWater = targetWater + steps[nV].qty
                }
        }
    }
    func timerStart() {
        withAnimation {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                withAnimation {
                    remaining -= 1
                    if remaining == 0 {
                        if step == recipe.steps.count - 1 {
                            withAnimation {
                                done = true
                                duration = 1
                                remaining = 1
                                timer = nil
                            }
                        } else {
                            step += 1
                        }
                    }
                }
            }
        }
    }
    func timerEnd() {
        withAnimation {
            timer!.invalidate()
            timer = nil
        }
    }
}
