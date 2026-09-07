import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var query = ""
    @State private var selectedCategory: ShortcutCategory = .all
    @State private var platform: ShortcutPlatform = .macOS
    @State private var isPractising = false

    private var filteredShortcuts: [LightroomShortcut] {
        LightroomShortcut.all.filter { shortcut in
            let matchesCategory = selectedCategory == .all || shortcut.category == selectedCategory
            let matchesQuery = query.isEmpty || shortcut.action.localizedCaseInsensitiveContains(query)
                || shortcut.keys.joined(separator: " ").localizedCaseInsensitiveContains(query)
            return matchesCategory && matchesQuery
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: 18, pinnedViews: []) {
                        HeroView(shortcutCount: LightroomShortcut.all.count)
                        CategoryStrip(selection: $selectedCategory)
                        resultHeader
                        shortcutList
                    }
                    .frame(maxWidth: horizontalSizeClass == .regular ? 1240 : .infinity)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationTitle("Lightroom Keys")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $query, prompt: "Search actions or keys")
            .toolbar { toolbarContent }
            .sheet(isPresented: $isPractising) {
                PracticeView(shortcuts: LightroomShortcut.all, platform: platform)
            }
        }
        .tint(.cyan)
    }

    private var resultHeader: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text(selectedCategory == .all ? "All shortcuts" : selectedCategory.rawValue)
                    .font(.title3.bold())
                Text("\(filteredShortcuts.count) SHORTCUTS · \(platform.rawValue.uppercased())")
                    .font(.caption2.monospaced().weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                isPractising = true
            } label: {
                Label("Practice", systemImage: "play.fill")
                    .font(.subheadline.bold())
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private var shortcutList: some View {
        if filteredShortcuts.isEmpty {
            ContentUnavailableView.search(text: query)
                .padding(.top, 48)
        } else {
            LazyVGrid(columns: shortcutColumns, spacing: 12) {
                ForEach(filteredShortcuts) { shortcut in
                    ShortcutCard(shortcut: shortcut, platform: platform)
                }
            }
            .padding(.horizontal, horizontalSizeClass == .regular ? 24 : 16)
        }
    }

    private var shortcutColumns: [GridItem] {
        if horizontalSizeClass == .regular {
            return [
                GridItem(.flexible(), spacing: 12, alignment: .top),
                GridItem(.flexible(), spacing: 12, alignment: .top)
            ]
        }

        return [GridItem(.flexible())]
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            LightroomMark()
        }
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Picker("Keyboard", selection: $platform) {
                    ForEach(ShortcutPlatform.allCases) { platform in
                        Text(platform.rawValue).tag(platform)
                    }
                }
                Divider()
                Link("Support", destination: URL(string: "https://mattpinner.com/lightroom-keys-support")!)
                Link("Privacy Policy", destination: URL(string: "https://mattpinner.com/lightroom-keys-privacy")!)
            } label: {
                Label(platform.rawValue, systemImage: platform == .macOS ? "command" : "keyboard")
                    .labelStyle(.iconOnly)
            }
            .accessibilityLabel("Keyboard platform: \(platform.rawValue)")
        }
    }
}

private struct HeroView: View {
    let shortcutCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("LIGHTROOM CLASSIC · SHORTCUT LIBRARY")
                .font(.caption2.monospaced().bold())
                .tracking(1.3)
                .foregroundStyle(.secondary)
            Text("Edit at the speed\nof **thought.**")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .tracking(-1.8)
                .foregroundStyle(.white)
            Text("Master the keys that keep your hands on the keyboard and your eyes on the image.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
            HStack(spacing: 10) {
                StatPill(value: "\(shortcutCount)", label: "SHORTCUTS")
                StatPill(value: "\(ShortcutCategory.allCases.count - 1)", label: "CATEGORIES")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background {
            LinearGradient(colors: [Color.cyan.opacity(0.12), .clear], startPoint: .topTrailing, endPoint: .bottomLeading)
        }
    }
}

private struct StatPill: View {
    let value: String
    let label: String

    var body: some View {
        HStack(spacing: 8) {
            Text(value).font(.headline.monospaced().bold())
            Text(label).font(.caption2.monospaced().bold()).foregroundStyle(.secondary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.white.opacity(0.05), in: .rect(cornerRadius: 10))
        .overlay { RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.08)) }
    }
}

private struct CategoryStrip: View {
    @Binding var selection: ShortcutCategory

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ShortcutCategory.allCases) { category in
                    Button {
                        withAnimation(.snappy) { selection = category }
                    } label: {
                        Label(category.rawValue, systemImage: category.symbol)
                            .font(.caption.bold())
                            .padding(.horizontal, 13)
                            .padding(.vertical, 9)
                            .foregroundStyle(selection == category ? Color.black : Color.secondary)
                            .background(selection == category ? category.tint : Color.cardBackground, in: .capsule)
                    }
                    .buttonStyle(.plain)
                    .accessibilityAddTraits(selection == category ? .isSelected : [])
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct LightroomMark: View {
    var body: some View {
        Text("Lr")
            .font(.caption.bold())
            .foregroundStyle(.cyan)
            .frame(width: 30, height: 30)
            .overlay { RoundedRectangle(cornerRadius: 7).stroke(.cyan, lineWidth: 1.5) }
            .accessibilityHidden(true)
    }
}

extension Color {
    static let appBackground = Color(red: 0.035, green: 0.039, blue: 0.047)
    static let cardBackground = Color(red: 0.075, green: 0.084, blue: 0.102)
}

#Preview {
    ContentView()
}
