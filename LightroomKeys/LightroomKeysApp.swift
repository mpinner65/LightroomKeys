import SwiftUI

@main
struct LightroomKeysApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .preferredColorScheme(.dark)
        }
    }
}

private struct AppRootView: View {
    @State private var isShowingLaunch = true

    var body: some View {
        ZStack {
            ContentView()

            if isShowingLaunch {
                LaunchHandoffView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .task {
            guard isShowingLaunch else { return }
            try? await Task.sleep(for: .seconds(1.25))
            guard !Task.isCancelled else { return }

            withAnimation(.easeOut(duration: 0.3)) {
                isShowingLaunch = false
            }
        }
    }
}

private struct LaunchHandoffView: View {
    var body: some View {
        ZStack {
            Color(red: 0.031, green: 0.067, blue: 0.114)
                .ignoresSafeArea()

            Image("LaunchScreenIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 260, height: 260)
                .accessibilityHidden(true)
        }
    }
}
