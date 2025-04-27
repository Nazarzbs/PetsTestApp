import SwiftUI
import StoreKit

struct ClickerView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        Color(red: 243/255, green: 245/255, blue: 246/255),
                        Color(red: 201/255, green: 255/255, blue: 224/255)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                VStack(spacing: 24) { // Space between title and buttons
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.top, 40)
                    
                    VStack(spacing: 12) { // Gap between buttons
                        SettingRow(title: "Rate Us")
                        SettingRow(title: "Share App")
                        SettingRow(title: "Contact Us")
                        SettingRow(title: "Restore Purchases")
                        SettingRow(title: "Privacy Policy")
                        SettingRow(title: "Terms of Use")
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
    }
}

extension ClickerView {
    struct SettingRow: View {
        var title: String
        
        var body: some View {
            NavigationLink(destination: SettingDetailView(title: title)) {
                HStack {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.9, green: 0.9, blue: 1)) // Light purple
                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
    
    struct SettingDetailView: View {
        var title: String
        
        var body: some View {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        Color(red: 243/255, green: 245/255, blue: 246/255),
                        Color(red: 201/255, green: 255/255, blue: 224/255)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ClickerView()
}
