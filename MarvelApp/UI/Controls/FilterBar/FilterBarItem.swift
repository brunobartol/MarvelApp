import SwiftUI

struct FilterBarItem: View {
    var isSelected: Bool
    var title: String
    
    var body: some View {
        ZStack {
            
            Rectangle()
            .fill(isSelected ? Color(UIColor.systemRed) : Color(UIColor.systemBackground))
            .cornerRadius(17)
            
            ZStack {
                Text(self.title)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? Color(UIColor.systemBackground) : Color(UIColor.label))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
            }
        }.fixedSize()
    }
}
