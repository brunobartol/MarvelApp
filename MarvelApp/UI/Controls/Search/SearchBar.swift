import SwiftUI
import Combine

struct SearchBar: View {
    @Binding var show: Bool
    @Binding var text: String
    
    var body: some View {
        HStack {
            
            if self.show {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.show.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color(UIColor.label))
                                    .padding(10)
                                
                                Text("Back")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor.label))
                            }
                        }.background(Color(UIColor.systemBackground))
                            .animation(.easeOut(duration: 5)).transition(AnyTransition.opacity.animation(.default))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(UIColor.label))
                            .background(Color(UIColor.systemBackground))
                            
                        
                        ZStack {
                            
                            TextField("Search here", text: self.$text)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .animation(.easeOut(duration: 3)).transition(AnyTransition.opacity.animation(.default))
                            
                        }.background(
                            Ellipse()
                                .fill(Color(UIColor.systemBackground))
                                .padding(.horizontal)
                                .shadow(color: Color(UIColor.lightGray).opacity(0.4), radius: 30, x: -10, y: 32)
                        )
                    }.padding()
                        .background(Color(UIColor.systemBackground))
                }
            } else {
                HStack {
                    Text("MARVEL")
                        .font(.custom("Marvel", size: 60))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.show.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(UIColor.label))
                            .padding(10)
                    }.background(Color(UIColor.systemBackground))
                }.animation(.easeOut(duration: 3)).transition(AnyTransition.opacity.animation(.default))
            }
        }.padding(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchBar(show: .constant(true), text: .constant("Test true")).environment(\.colorScheme, .light)
            SearchBar(show: .constant(false), text: .constant("Test false")).environment(\.colorScheme, .light)
        }
        
    }
}
