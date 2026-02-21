import SwiftUI


struct QuickAddButtonView: View {
    
    let icon: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
            Text(label)
                .font(.system(size: 16))
        }
        .foregroundColor(color)
        .frame(width: 70, height: 50)
        .background(color.opacity(0.2))
        cornerRadius(12)
    }
}

#Preview {
    QuickAddButtonView(icon: "plus", label: "Water", color: .cyan)
}
