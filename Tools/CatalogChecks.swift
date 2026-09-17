import Foundation

@main
struct CatalogChecks {
    static func main() {
        let lr = ShortcutApplication.lightroom.shortcuts
        let ps = ShortcutApplication.photoshop.shortcuts
        precondition(lr.count == 332, "Existing Lightroom catalog changed")
        precondition(ps.count == 712, "Photoshop catalog unexpectedly changed")
        precondition(ShortcutApplication.photoshop.categories.count == 37)
        precondition(!ShortcutApplication.lightroom.categories.contains(.psTools))
        precondition(!ShortcutApplication.photoshop.categories.contains(.develop))
        for application in ShortcutApplication.allCases {
            let shortcuts = application.shortcuts
            precondition(Set(shortcuts.map(\.id)).count == shortcuts.count)
            for shortcut in shortcuts {
                precondition(!shortcut.action.isEmpty)
                precondition(application.categories.contains(shortcut.category))
                for platform in ShortcutPlatform.allCases {
                    let keys = shortcut.displayKeys(for: platform)
                    precondition(!keys.isEmpty && keys.allSatisfy { !$0.isEmpty })
                    precondition(!keys.joined().contains("†") && !keys.joined().contains("‡"))
                }
            }
        }
        let filter = ps.first { $0.action == "Reapply last-used filter" }!
        precondition(filter.displayKeys(for: .macOS).joined().contains("⌃"))
        precondition(filter.displayKeys(for: .macOS).joined().contains("⌘"))
        precondition(filter.displayKeys(for: .windows).joined().contains("Alt"))
        let brush = ps.first { $0.action == "Change brush size" }!
        precondition(brush.displayKeys(for: .macOS).joined().contains("⌃"))
        precondition(!brush.displayKeys(for: .macOS).joined().contains("⌘"))
        let undo = ps.first { $0.action == "Undo" }!
        precondition(undo.displayKeys(for: .macOS) == ["⌘", "Z"])
        precondition(undo.displayKeys(for: .windows) == ["Ctrl", "Z"])
        precondition(ps.contains { $0.action == "Pick Light panel" && $0.category == .psCameraRaw })
        precondition(ps.contains { $0.action == "Rectangle tool" })
        precondition(!ps.contains { $0.action.contains("Rounded Rectangle") || $0.action == "Turbulence tool" })
        let mask = ps.filter { $0.category == .psSelectandMask }
        precondition(mask.count == 27)
        let whitePreview = mask.first { $0.action == "View: On White" }!
        precondition(whitePreview.displayKeys(for: .macOS) == ["T"])
        let fillMode = ps.first { $0.category == .psContentAwareFill && $0.action == "Cycle selection add/subtract" }!
        precondition(fillMode.displayKeys(for: .windows) == ["E"])
        let straighten = ps.first { $0.category == .psCrop && $0.action == "Temporarily straighten crop" }!
        precondition(straighten.displayKeys(for: .macOS).joined().contains("⌘"))
        precondition(straighten.displayKeys(for: .windows).joined().contains("Ctrl"))
        precondition(!ShortcutApplication.lightroom.categories.contains(.psSelectandMask))
        precondition(Set(ps.map { "\($0.category.rawValue)|\($0.action)|\($0.keys)" }).count == ps.count)
        print("PASS: 332 Lightroom entries, 712 Photoshop entries, scoped categories, unique identities, valid keys, current Camera Raw and Mac modifier exceptions.")
    }
}
