//
//  CalculatorView.swift
//  CalculatorView
//  
//  Created by keeki-fami on 2026/09/02
//  
//
import SwiftUI

public struct NumberPadView: View {
    @Binding var typedNumbers: String
    enum KeyType: Hashable {
        case number(String)
        case minus
        case backspace
        case empty
        
        var title: String {
            switch self {
            case .number(let text): return text
            case .minus: return "-"
            case .backspace: return "<"
            case .empty: return ""
            }
        }
    }
    
    public init(_ text: Binding<String>) {
        self._typedNumbers = text
    }
    
    let grid: [[KeyType]] = [
        [.number("1"), .number("2"), .number("3"), .backspace,],
        [.number("4"), .number("5"), .number("6"), .minus],
        [.number("7"), .number("8"), .number("9"), .empty],
        [.empty, .number("0"), .empty, .empty]
    ]
    public var body: some View {
        VStack {
            ForEach(0..<grid.count, id: \.self) { row in
                HStack (spacing: 8) {
                    ForEach(grid[row], id: \.self) { key in
                        keyView(key: key)
                    }
                }
            }
            Button(action: {
                // TODO: 回答処理
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                    Text("submit")
                        .foregroundStyle(.white)
                }
            })
            .buttonStyle(NumberButtonStyle())
        }
        .padding()
        .background(Color(red: 236/255, green: 236/255, blue: 236/255))
    }
    
    @ViewBuilder
    func keyView(key: KeyType) -> some View {
        if key == .empty {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
        } else {
            Button(action: {
                handleKeyPress(key)
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                    Text(key.title)
                }
            })
            .buttonStyle(NumberButtonStyle())
        }
    }
    
    func handleKeyPress(_ key: KeyType) {
        switch key {
        case .number(let title):
            if typedNumbers == "0" {
                typedNumbers = title
            } else {
                typedNumbers.append(title)
            }
        case .minus:
            if typedNumbers.isEmpty {
                typedNumbers.append("-")
            }
        case .backspace:
            if !typedNumbers.isEmpty {
                typedNumbers.removeLast()
            }
        default:
            break
        }
    }
}

struct NumberButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
            .foregroundColor(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            .shadow(color: .black.opacity( configuration.isPressed ? 0 : 0.5 ), radius: 1, x: 0, y: 2)
    }
}
