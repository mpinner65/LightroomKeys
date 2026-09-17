import SwiftUI

struct PracticeView: View {
    let shortcuts: [LightroomShortcut]
    let platform: ShortcutPlatform
    var applicationName = "Lightroom Classic"
    @Environment(\.dismiss) private var dismiss
    @State private var index = 0
    @State private var isRevealed = false

    private var shortcut: LightroomShortcut { shortcuts[index] }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                ScrollView {
                VStack(spacing: 24) {
                    progress
                    Spacer(minLength: 10)
                    quizCard
                    Spacer(minLength: 10)
                    controls
                }
                .padding(20)
                .frame(maxWidth: 760)
                .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("\(applicationName) Practice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.large])
    }

    private var progress: some View {
        VStack(spacing: 10) {
            HStack {
                Text("CARD \(index + 1) OF \(shortcuts.count)")
                Spacer()
                Text(shortcut.category.rawValue.uppercased())
                    .foregroundStyle(shortcut.category.tint)
            }
            .font(.caption2.monospaced().bold())
            ProgressView(value: Double(index + 1), total: Double(shortcuts.count))
                .tint(.cyan)
        }
    }

    private var quizCard: some View {
        VStack(spacing: 24) {
            Image(systemName: shortcut.category.symbol)
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(shortcut.category.tint)
                .frame(width: 58, height: 58)
                .background(shortcut.category.tint.opacity(0.12), in: .rect(cornerRadius: 16))
            VStack(spacing: 9) {
                Text("WHAT’S THE SHORTCUT FOR…")
                    .font(.caption2.monospaced().bold())
                    .tracking(1.2)
                    .foregroundStyle(.secondary)
                Text(shortcut.action)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
            }
            Group {
                if isRevealed {
                    VStack(spacing: 10) {
                        KeyRow(keys: shortcut.displayKeys(for: platform))
                        if let note = shortcut.note {
                            Text(note).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                        .transition(.scale.combined(with: .opacity))
                } else {
                    Button("Reveal shortcut") {
                        withAnimation(.snappy) { isRevealed = true }
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }
            }
            .frame(minHeight: 42)
        }
        .frame(maxWidth: .infinity)
        .padding(28)
        .background(Color.cardBackground, in: .rect(cornerRadius: 20))
        .overlay { RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.09)) }
    }

    private var controls: some View {
        HStack(spacing: 12) {
            Button {
                index = (index - 1 + shortcuts.count) % shortcuts.count
                isRevealed = false
            } label: {
                Label("Previous", systemImage: "arrow.left")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)

            Button {
                index = (index + 1) % shortcuts.count
                isRevealed = false
            } label: {
                Label("Next", systemImage: "arrow.right")
                    .labelStyle(.titleAndIcon)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .controlSize(.large)
    }
}

#Preview {
    PracticeView(shortcuts: LightroomShortcut.all, platform: .macOS)
}
