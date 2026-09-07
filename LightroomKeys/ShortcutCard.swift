import SwiftUI

struct ShortcutCard: View {
    let shortcut: LightroomShortcut
    let platform: ShortcutPlatform

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                KeyRow(keys: shortcut.displayKeys(for: platform))
                VStack(alignment: .leading, spacing: 4) {
                    Text(shortcut.action)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    HStack(spacing: 6) {
                        Circle().fill(shortcut.category.tint).frame(width: 5, height: 5)
                        Text(metadata)
                            .font(.caption2.monospaced())
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            Spacer(minLength: 4)
            Image(systemName: shortcut.category.symbol)
                .font(.title3)
                .foregroundStyle(shortcut.category.tint.opacity(0.8))
                .frame(width: 36, height: 36)
                .background(shortcut.category.tint.opacity(0.1), in: .rect(cornerRadius: 9))
        }
        .padding(18)
        .background(Color.cardBackground, in: .rect(cornerRadius: 14))
        .overlay(alignment: .leading) {
            Rectangle().fill(shortcut.category.tint).frame(width: 2).padding(.vertical, 14)
        }
        .overlay { RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.07)) }
        .accessibilityElement(children: .combine)
    }

    private var metadata: String {
        [shortcut.category.rawValue.uppercased(), shortcut.note?.uppercased()].compactMap { $0 }.joined(separator: " · ")
    }
}

struct KeyRow: View {
    let keys: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Array(keys.enumerated()), id: \.offset) { _, key in
                    Text(key)
                        .font(.caption.monospaced().bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, key.count > 2 ? 10 : 8)
                        .frame(minWidth: 31, minHeight: 31)
                        .background {
                            LinearGradient(colors: [.white.opacity(0.13), .white.opacity(0.06)], startPoint: .top, endPoint: .bottom)
                        }
                        .clipShape(.rect(cornerRadius: 7))
                        .overlay { RoundedRectangle(cornerRadius: 7).stroke(.white.opacity(0.18)) }
                        .shadow(color: .black.opacity(0.45), radius: 0, y: 2)
                }
            }
        }
    }
}
