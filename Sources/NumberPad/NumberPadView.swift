//
//  CalculatorView.swift
//  CalculatorView
//  
//  Created by keeki-fami on 2026/09/02
//  
//
import SwiftUI

public struct NumberPadView: View {
    var label: String
    var isHapnic: Bool
    @Binding var typedNumbers: String
    @State private var selection = false
    let submitAction: () -> Void
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
    
    public init(_ label: String, text: Binding<String>, isHapnic: Bool = true, action: @escaping () -> Void) {
        self.label = label
        self._typedNumbers = text
        self.submitAction = action
        self.isHapnic = isHapnic
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
                    Text(self.label)
                        .foregroundStyle(.white)
                }
            })
            .buttonStyle(NumberButtonStyle(onTouchDown: {
                submitAction()
            }, onTouchUp: {
                
            }))
        }
        .padding()
        .background(Color(red: 236/255, green: 236/255, blue: 236/255))
    }
    
    // submit以外のボタン
    @ViewBuilder
    func keyView(key: KeyType) -> some View {
        if key == .empty {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
        } else {
            Button(action: {
//                handleKeyPress(key)
//                if isHapnic {
//                    // TODO: 触覚フィードバックの実装
//                    selection.toggle()
//                }
            } ,label: {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 217/255, green: 217/255, blue: 217/255))
                    Text(key.title)
                }
            })
            .sensoryFeedback(.selection, trigger: selection)
            .buttonStyle(NumberButtonStyle(onTouchDown: {
                handleKeyPress(key)
                if isHapnic {
                    // TODO: 触覚フィードバックの実装
                    selection.toggle()
                }
            }, onTouchUp: {
                
            })
            )
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
    let onTouchDown: () -> Void
    let onTouchUp: () -> Void
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
            .foregroundColor(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            .shadow(color: .black.opacity( configuration.isPressed ? 0 : 0.5 ), radius: 1, x: 0, y: 2)
            .onChange(of: configuration.isPressed) {
                $1 ? onTouchDown() : onTouchUp()
            }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    VStack {
        Rectangle()
        NumberPadView("submit", text: $text, action: {
            print("text: \(text)")
        })
    }
}
