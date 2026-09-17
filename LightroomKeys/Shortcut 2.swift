import SwiftUI

enum ShortcutPlatform: String, CaseIterable, Identifiable {
    case macOS = "macOS"
    case windows = "Windows"

    var id: Self { self }
    var commandKey: String { self == .macOS ? "⌘" : "Ctrl" }
    var optionKey: String { self == .macOS ? "⌥" : "Alt" }
}

enum ShortcutCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case panels = "Panels"
    case modules = "Modules"
    case views = "Views"
    case library = "Library"
    case rating = "Rating"
    case collections = "Collections"
    case metadata = "Metadata"
    case develop = "Develop"
    case workflow = "Workflow"
    case book = "Book"
    case slideshow = "Slideshow"
    case print = "Print"
    case map = "Map"
    case web = "Web"
    case help = "Help"
    case psGeneral = "General"
    case psFunctionkeys = "Function keys"
    case psTools = "Tools"
    case psNavigation = "Navigation"
    case psPuppetWarp = "Puppet Warp"
    case psFilterGallery = "Filter Gallery"
    case psLiquify = "Liquify"
    case psVanishingPoint = "Vanishing Point"
    case psBlackWhite = "Black & White"
    case psCurves = "Curves"
    case psSelections = "Selections"
    case psTransform = "Transform"
    case psPaths = "Paths"
    case psPainting = "Painting"
    case psBlending = "Blending"
    case psText = "Text"
    case psTypography = "Typography"
    case psSlices = "Slices"
    case psPanels = "Workspace panels"
    case psActions = "Actions"
    case psAdjustments = "Adjustments"
    case psAnimation = "Animation"
    case psBrushsettings = "Brush settings"
    case psChannels = "Channels"
    case psClonesource = "Clone source"
    case psColor = "Color"
    case psHistory = "History"
    case psInfo = "Info"
    case psLayers = "Layers"
    case psLayercomps = "Layer comps"
    case psPathspanel = "Paths panel"
    case psSwatches = "Swatches"
    case psCameraRaw = "Camera Raw"
    case psSelectandMask = "Select and Mask"
    case psCrop = "Crop"
    case psContentAwareFill = "Content-Aware Fill"


    var id: Self { self }

    var symbol: String {
        switch self {
        case .all: "command"
        case .panels: "sidebar.left"
        case .modules: "square.grid.3x3"
        case .views: "rectangle.3.group"
        case .library: "photo.on.rectangle.angled"
        case .rating: "star"
        case .collections: "rectangle.stack"
        case .metadata: "tag"
        case .develop: "slider.horizontal.3"
        case .workflow: "arrow.triangle.2.circlepath"
        case .book: "book.closed"
        case .slideshow: "play.rectangle"
        case .print: "printer"
        case .map: "map"
        case .web: "globe"
        case .help: "questionmark.circle"
        case .psSelectandMask: "person.crop.rectangle"
        case .psCrop: "crop"
        case .psContentAwareFill: "paintbrush"
        case .psGeneral, .psFunctionkeys, .psTools, .psNavigation, .psPuppetWarp, .psFilterGallery, .psLiquify, .psVanishingPoint, .psBlackWhite, .psCurves, .psSelections, .psTransform, .psPaths, .psPainting, .psBlending, .psText, .psTypography, .psSlices, .psPanels, .psActions, .psAdjustments, .psAnimation, .psBrushsettings, .psChannels, .psClonesource, .psColor, .psHistory, .psInfo, .psLayers, .psLayercomps, .psPathspanel, .psSwatches, .psCameraRaw: "keyboard"
        }
    }

    var tint: Color {
        switch self {
        case .all: .cyan
        case .panels: .teal
        case .modules: .indigo
        case .views: .blue
        case .library: .green
        case .rating: .yellow
        case .collections: .mint
        case .metadata: .brown
        case .develop: .purple
        case .workflow: .orange
        case .book: .pink
        case .slideshow: .red
        case .print: .gray
        case .map: .cyan
        case .web: .blue
        case .help: .secondary
        case .psSelectandMask, .psCrop, .psContentAwareFill: .blue
        case .psGeneral, .psFunctionkeys, .psTools, .psNavigation, .psPuppetWarp, .psFilterGallery, .psLiquify, .psVanishingPoint, .psBlackWhite, .psCurves, .psSelections, .psTransform, .psPaths, .psPainting, .psBlending, .psText, .psTypography, .psSlices, .psPanels, .psActions, .psAdjustments, .psAnimation, .psBrushsettings, .psChannels, .psClonesource, .psColor, .psHistory, .psInfo, .psLayers, .psLayercomps, .psPathspanel, .psSwatches, .psCameraRaw: .blue
        }
    }
}

struct LightroomShortcut: Identifiable, Hashable {
    let id = UUID()
    private let macOSKeys: [String]
    private let windowsKeys: [String]
    let action: String
    let category: ShortcutCategory
    var note: String?

    var keys: [String] { macOSKeys + windowsKeys }

    init(keys: [String], action: String, category: ShortcutCategory, note: String? = nil) {
        macOSKeys = keys
        windowsKeys = keys
        self.action = action
        self.category = category
        self.note = note
    }

    init(macOS: [String], windows: [String], action: String, category: ShortcutCategory, note: String? = nil) {
        macOSKeys = macOS
        windowsKeys = windows
        self.action = action
        self.category = category
        self.note = note
    }

    func displayKeys(for platform: ShortcutPlatform) -> [String] {
        let keys = platform == .macOS ? macOSKeys : windowsKeys
        return keys.map { key in
            var result = key
            let replacements = [
                ("Right Arrow", "→"), ("Left Arrow", "←"),
                ("Up Arrow", "↑"), ("Down Arrow", "↓"),
                ("Spacebar", "Space"), ("Return", "↩"),
                ("Control", "⌃"), ("Option", "⌥"), ("Cmd", "⌘"),
                ("Mod", platform.commandKey), ("Alt", platform.optionKey)
            ]
            for replacement in replacements {
                result = result.replacingOccurrences(of: replacement.0, with: replacement.1)
            }
            return result
        }
    }
}

extension LightroomShortcut {
    static let all = panels + modules + book + views + secondaryWindow + workflow
        + libraryComparison + rating + collections + metadata + develop
        + slideshow + printShortcuts + mapShortcuts + web + help
}

private extension LightroomShortcut {
    static let panels: [LightroomShortcut] = [
        .init(keys: ["Tab"], action: "Show or hide side panels", category: .panels),
        .init(keys: ["Shift", "Tab"], action: "Show or hide all panels", category: .panels),
        .init(keys: ["T"], action: "Show or hide toolbar", category: .panels),
        .init(keys: ["F5"], action: "Show or hide Module Picker", category: .panels),
        .init(keys: ["F6"], action: "Show or hide Filmstrip", category: .panels),
        .init(keys: ["F7"], action: "Show or hide left panels", category: .panels),
        .init(keys: ["F8"], action: "Show or hide right panels", category: .panels),
        .init(keys: ["Alt-click"], action: "Toggle solo mode", category: .panels),
        .init(keys: ["Shift-click"], action: "Open panel without closing soloed panel", category: .panels),
        .init(keys: ["Mod-click"], action: "Open or close all panels", category: .panels),
        .init(macOS: ["Cmd", "Control", "0–5"], windows: ["Ctrl", "Shift", "0–5"], action: "Open or close left panels", category: .panels),
        .init(keys: ["Mod", "0–9"], action: "Open or close Library and Develop right panels", category: .panels),
        .init(keys: ["Mod", "1–7"], action: "Open or close Slideshow, Print, and Web right panels", category: .panels),
        .init(keys: ["Mod", "Z"], action: "Undo", category: .panels),
        .init(keys: ["Mod", "Shift", "Z"], action: "Redo", category: .panels),
        .init(macOS: ["—"], windows: ["Ctrl", "Y"], action: "Redo (alternate)", category: .panels, note: "Windows only")
    ]

    static let modules: [LightroomShortcut] = [
        .init(keys: ["Mod", "Alt", "1"], action: "Go to Library module", category: .modules),
        .init(keys: ["Mod", "Alt", "2"], action: "Go to Develop module", category: .modules),
        .init(keys: ["Mod", "Alt", "3"], action: "Go to Map module", category: .modules),
        .init(keys: ["Mod", "Alt", "4"], action: "Go to Book module", category: .modules),
        .init(keys: ["Mod", "Alt", "5"], action: "Go to Slideshow module", category: .modules),
        .init(keys: ["Mod", "Alt", "6"], action: "Go to Print module", category: .modules),
        .init(keys: ["Mod", "Alt", "7"], action: "Go to Web module", category: .modules),
        .init(keys: ["Mod", "Alt", "← / →"], action: "Go back or forward", category: .modules),
        .init(keys: ["Mod", "Alt", "Up Arrow"], action: "Go back to previous module", category: .modules)
    ]

    static let book: [LightroomShortcut] = [
        .init(keys: ["Mod", "R"], action: "Double-page view", category: .book),
        .init(keys: ["Mod", "E"], action: "Multi-page view", category: .book),
        .init(keys: ["Mod", "="], action: "Next Book view mode", category: .book),
        .init(keys: ["Mod", "−"], action: "Previous Book view mode", category: .book),
        .init(keys: ["Mod", "T"], action: "Single-page view", category: .book),
        .init(keys: ["Mod", "U"], action: "Zoomed single-page view", category: .book),
        .init(keys: ["Mod", "S"], action: "Create Saved Book", category: .book),
        .init(keys: ["Mod", "M"], action: "Update metadata captions", category: .book),
        .init(keys: ["Mod", "Shift", "C"], action: "Copy Book layout", category: .book),
        .init(keys: ["Mod", "Shift", "V"], action: "Paste Book layout", category: .book),
        .init(keys: ["Mod", "Shift", "Backspace"], action: "Remove Book page", category: .book),
        .init(keys: ["Mod", "Shift", "Alt", "A"], action: "Select photo cells", category: .book),
        .init(keys: ["Mod", "Alt", "A"], action: "Select text cells", category: .book),
        .init(keys: ["Mod", "Shift", "H"], action: "Show or hide Book filter text", category: .book),
        .init(keys: ["Mod", "Shift", "U"], action: "Show or hide text safe area", category: .book)
    ]

    static let views: [LightroomShortcut] = [
        .init(keys: ["E"], action: "Enter Library Loupe view", category: .views),
        .init(keys: ["G"], action: "Enter Library Grid view", category: .views),
        .init(keys: ["C"], action: "Enter Library Compare view", category: .views),
        .init(keys: ["N"], action: "Enter Library Survey view", category: .views),
        .init(keys: ["D"], action: "Open selected photo in Develop", category: .views),
        .init(keys: ["L"], action: "Cycle forward through Lights Out modes", category: .views),
        .init(keys: ["Shift", "L"], action: "Cycle backward through Lights Out modes", category: .views),
        .init(keys: ["Mod", "Shift", "L"], action: "Toggle Lights Dim mode", category: .views),
        .init(keys: ["F"], action: "Cycle screen modes", category: .views),
        .init(macOS: ["Shift", "F"], windows: ["—"], action: "Previous screen mode", category: .views, note: "macOS only"),
        .init(keys: ["Mod", "Shift", "F"], action: "Toggle Normal and full screen with panels hidden", category: .views),
        .init(keys: ["Mod", "Alt", "F"], action: "Go to Normal screen mode", category: .views),
        .init(keys: ["I"], action: "Cycle info overlay", category: .views),
        .init(keys: ["Mod", "I"], action: "Show or hide info overlay", category: .views),
        .init(keys: ["Shift", "R"], action: "Open Reference view", category: .views),
        .init(keys: ["Mod", "Alt", "O"], action: "Enable Loupe overlay in Library", category: .views),
        .init(keys: ["Mod", "Shift", "Alt", "O"], action: "Enable and choose Loupe overlay", category: .views),
        .init(keys: ["Mod", "Shift", "X"], action: "Show Grid view styles", category: .views),
        .init(keys: ["Mod", "Alt", "0"], action: "Zoom to 100%", category: .views),
        .init(keys: ["O"], action: "Open People view in Library", category: .views),
        .init(keys: ["Shift", "H"], action: "Toggle HDR view", category: .views)
    ]

    static let secondaryWindow: [LightroomShortcut] = [
        .init(macOS: ["Cmd", "F11"], windows: ["F11"], action: "Open secondary window", category: .views),
        .init(keys: ["Shift", "G"], action: "Secondary window: Grid view", category: .views),
        .init(keys: ["Shift", "E"], action: "Secondary window: Normal Loupe view", category: .views),
        .init(macOS: ["Cmd", "Shift", "Return"], windows: ["Ctrl", "Shift", "Enter"], action: "Secondary window: Locked Loupe view", category: .views),
        .init(keys: ["Shift", "C"], action: "Secondary window: Compare view", category: .views),
        .init(keys: ["Shift", "N"], action: "Secondary window: Survey view", category: .views),
        .init(macOS: ["Cmd", "Option", "Shift", "Return"], windows: ["Ctrl", "Alt", "Shift", "Enter"], action: "Secondary window: Slideshow view", category: .views),
        .init(macOS: ["Cmd", "Shift", "F11"], windows: ["Shift", "F11"], action: "Secondary window: Full-screen mode", category: .views),
        .init(keys: ["Shift", "\\"], action: "Secondary window: Show or hide Filter bar", category: .views),
        .init(keys: ["Mod", "Shift", "= / −"], action: "Secondary window: Zoom in or out", category: .views)
    ]

    static let workflow: [LightroomShortcut] = [
        .init(keys: ["Mod", "Shift", "I"], action: "Import photos from disk", category: .workflow),
        .init(macOS: ["Cmd", "Shift", "O"], windows: ["Ctrl", "O"], action: "Open catalog", category: .workflow),
        .init(keys: ["Mod", ","], action: "Open Preferences", category: .workflow),
        .init(keys: ["Mod", "Alt", ","], action: "Open Catalog Settings", category: .workflow),
        .init(keys: ["Mod", "Shift", "T"], action: "Create tethered-capture subfolder", category: .workflow),
        .init(keys: ["Mod", "T"], action: "Show or hide tether capture bar", category: .workflow),
        .init(keys: ["Mod", "Shift", "N"], action: "Create a new Library folder", category: .workflow),
        .init(keys: ["Mod", "'"], action: "Create virtual copy", category: .workflow, note: "Library and Develop"),
        .init(keys: ["Mod", "R"], action: "Show in Explorer or Finder", category: .workflow, note: "Library and Develop"),
        .init(keys: ["Right Arrow / Left Arrow"], action: "Next or previous photo in Filmstrip", category: .workflow),
        .init(macOS: ["Shift-click / Cmd-click"], windows: ["Shift-click / Ctrl-click"], action: "Select multiple folders or collections", category: .workflow),
        .init(keys: ["F2"], action: "Rename photo", category: .workflow),
        .init(macOS: ["Delete"], windows: ["Delete / Backspace"], action: "Delete selected photo", category: .workflow),
        .init(macOS: ["Option", "Delete"], windows: ["Alt", "Backspace"], action: "Remove selected photo from catalog", category: .workflow),
        .init(macOS: ["Cmd", "Option", "Shift", "Delete"], windows: ["Ctrl", "Alt", "Shift", "Backspace"], action: "Delete selected photo and move it to Trash", category: .workflow),
        .init(macOS: ["Cmd", "Delete"], windows: ["Ctrl", "Backspace"], action: "Delete rejected photos", category: .workflow),
        .init(keys: ["Mod", "E"], action: "Edit in Photoshop", category: .workflow),
        .init(keys: ["Mod", "Alt", "E"], action: "Open in other editor", category: .workflow),
        .init(keys: ["Mod", "Shift", "E"], action: "Export selected photos", category: .workflow),
        .init(keys: ["Mod", "Alt", "Shift", "E"], action: "Export with previous settings", category: .workflow),
        .init(keys: ["Mod", "Alt", "Shift", ","], action: "Open Plug-in Manager", category: .workflow),
        .init(keys: ["Mod", "P"], action: "Print selected photo", category: .workflow),
        .init(keys: ["Mod", "Shift", "P"], action: "Open Page Setup", category: .workflow),
        .init(keys: ["Mod", "Right Arrow"], action: "Go to next image", category: .workflow),
        .init(keys: ["Mod", "Left Arrow"], action: "Go to previous image", category: .workflow),
        .init(keys: ["F12"], action: "Start tethered capture", category: .workflow),
        .init(macOS: ["Control", "Option", "Shift", "I"], windows: ["Ctrl", "Alt", "Shift", "I"], action: "Headless Enhance", category: .workflow),
        .init(macOS: ["Control", "Option", "I"], windows: ["Ctrl", "Alt", "I"], action: "Open Enhance dialog", category: .workflow),
        .init(macOS: ["Control", "H"], windows: ["Ctrl", "H"], action: "HDR merge", category: .workflow),
        .init(macOS: ["Control", "Shift", "H"], windows: ["Ctrl", "Shift", "H"], action: "Headless HDR merge", category: .workflow),
        .init(macOS: ["Control", "M"], windows: ["Ctrl", "M"], action: "Panorama merge", category: .workflow),
        .init(macOS: ["Control", "Shift", "M"], windows: ["Ctrl", "Shift", "M"], action: "Headless panorama merge", category: .workflow),
        .init(keys: ["Mod", "Alt", "X"], action: "Open as Smart Object in Photoshop", category: .workflow),
        .init(macOS: ["Cmd", "Shift", "M"], windows: ["—"], action: "Email photos", category: .workflow, note: "macOS only")
    ]
}

private extension LightroomShortcut {
    static let slideshow: [LightroomShortcut] = [
        .init(macOS: ["Return"], windows: ["Enter"], action: "Play slideshow", category: .slideshow),
        .init(macOS: ["Cmd", "Return"], windows: ["Ctrl", "Enter"], action: "Play impromptu slideshow", category: .slideshow),
        .init(keys: ["Spacebar"], action: "Pause slideshow", category: .slideshow),
        .init(macOS: ["Option", "Return"], windows: ["Alt", "Enter"], action: "Preview slideshow", category: .slideshow),
        .init(keys: ["Esc"], action: "End slideshow", category: .slideshow),
        .init(keys: ["Right Arrow"], action: "Next slide", category: .slideshow),
        .init(keys: ["Left Arrow"], action: "Previous slide", category: .slideshow),
        .init(keys: ["Mod", "]"], action: "Rotate photo clockwise", category: .slideshow),
        .init(keys: ["Mod", "["], action: "Rotate photo counterclockwise", category: .slideshow),
        .init(keys: ["Mod", "Shift", "H"], action: "Show or hide slideshow guides", category: .slideshow),
        .init(keys: ["Mod", "J"], action: "Export PDF slideshow", category: .slideshow),
        .init(keys: ["Mod", "Shift", "J"], action: "Export JPEG slideshow", category: .slideshow),
        .init(keys: ["Mod", "Alt", "J"], action: "Export video slideshow", category: .slideshow),
        .init(keys: ["Mod", "N"], action: "Create slideshow template", category: .slideshow),
        .init(keys: ["Mod", "Shift", "N"], action: "Create slideshow template folder", category: .slideshow),
        .init(keys: ["Mod", "S"], action: "Save slideshow settings", category: .slideshow),
        .init(macOS: ["Cmd", "Option", "Return"], windows: ["Ctrl", "Alt", "Right Arrow"], action: "Play all", category: .slideshow),
        .init(keys: ["Mod", "Left Arrow"], action: "Previous slideshow menu", category: .slideshow),
        .init(keys: ["Mod", "Right Arrow"], action: "Next slideshow menu", category: .slideshow)
    ]

    static let printShortcuts: [LightroomShortcut] = [
        .init(keys: ["Mod", "P"], action: "Print", category: .print),
        .init(keys: ["Mod", "Alt", "P"], action: "Print one copy", category: .print),
        .init(keys: ["Mod", "Shift", "P"], action: "Open Page Setup", category: .print),
        .init(keys: ["Mod", "Alt", "Shift", "P"], action: "Open Print Settings", category: .print),
        .init(keys: ["Mod", "Shift", "Left Arrow"], action: "Go to first print page", category: .print),
        .init(keys: ["Mod", "Shift", "Right Arrow"], action: "Go to last print page", category: .print),
        .init(keys: ["Mod", "Left Arrow"], action: "Go to previous print page", category: .print),
        .init(keys: ["Mod", "Right Arrow"], action: "Go to next print page", category: .print),
        .init(keys: ["Mod", "Shift", "H"], action: "Show or hide print guides", category: .print),
        .init(keys: ["Mod", "R"], action: "Show or hide rulers", category: .print),
        .init(keys: ["Mod", "Shift", "J"], action: "Show or hide page bleed", category: .print),
        .init(keys: ["Mod", "Shift", "M"], action: "Show or hide margins and gutters", category: .print),
        .init(keys: ["Mod", "Shift", "K"], action: "Show or hide image cells", category: .print),
        .init(keys: ["Mod", "Shift", "U"], action: "Show or hide dimensions", category: .print),
        .init(macOS: ["Cmd", "Return"], windows: ["Ctrl", "Enter"], action: "Play impromptu slideshow", category: .print),
        .init(keys: ["Mod", "]"], action: "Rotate photo clockwise", category: .print),
        .init(keys: ["Mod", "["], action: "Rotate photo counterclockwise", category: .print),
        .init(keys: ["Mod", "N"], action: "Create print template", category: .print),
        .init(keys: ["Mod", "Shift", "N"], action: "Create print template folder", category: .print),
        .init(keys: ["Mod", "S"], action: "Save print settings", category: .print),
        .init(keys: ["Mod", "Shift", "G"], action: "Show Guides", category: .print)
    ]

    static let mapShortcuts: [LightroomShortcut] = [
        .init(keys: ["Mod", "Alt", "T"], action: "Next Track in Tracklog", category: .map),
        .init(keys: ["Mod", "Alt", "Shift", "T"], action: "Previous Track in Tracklog", category: .map),
        .init(keys: ["Mod", "F"], action: "Search Map", category: .map),
        .init(macOS: ["Cmd", "Delete"], windows: ["Ctrl", "Backspace"], action: "Delete all location data", category: .map),
        .init(keys: ["Mod", "6"], action: "Dark Map style", category: .map),
        .init(keys: ["Mod", "1"], action: "Hybrid Map style", category: .map),
        .init(keys: ["Mod", "5"], action: "Light Map style", category: .map),
        .init(keys: ["Mod", "K"], action: "Lock pins on Map", category: .map),
        .init(keys: ["Mod", "2"], action: "Road Map style", category: .map),
        .init(keys: ["Mod", "3"], action: "Satellite Map style", category: .map),
        .init(keys: ["Mod", "4"], action: "Terrain Map style", category: .map),
        .init(keys: ["I"], action: "Show or hide Map info", category: .map),
        .init(keys: ["O"], action: "Show or hide location preset overlay", category: .map)
    ]

    static let web: [LightroomShortcut] = [
        .init(keys: ["Mod", "R"], action: "Reload web gallery", category: .web),
        .init(keys: ["Mod", "Alt", "P"], action: "Preview web gallery in browser", category: .web),
        .init(macOS: ["Cmd", "Return"], windows: ["Ctrl", "Enter"], action: "Play impromptu slideshow", category: .web),
        .init(keys: ["Mod", "J"], action: "Export web gallery", category: .web),
        .init(keys: ["Mod", "N"], action: "Create web gallery template", category: .web),
        .init(keys: ["Mod", "Shift", "N"], action: "Create web gallery template folder", category: .web),
        .init(keys: ["Mod", "S"], action: "Save web gallery settings", category: .web),
        .init(keys: ["Mod", "Shift", "Alt", "/"], action: "Open Web advanced settings panel", category: .web)
    ]

    static let help: [LightroomShortcut] = [
        .init(keys: ["Mod", "/"], action: "Display current module shortcuts", category: .help),
        .init(macOS: ["Cmd", "Option", "Shift", "/"], windows: ["Ctrl", "Alt", "/"], action: "Open current module Help", category: .help),
        .init(keys: ["F1"], action: "Open Community Help", category: .help)
    ]
}

private extension LightroomShortcut {
    static let develop: [LightroomShortcut] = [
        .init(keys: ["Alt", "Shift", "G"], action: "Toggle Use Generative AI", category: .develop),
        .init(keys: ["Alt", "Shift", "O"], action: "Toggle Detect Aware", category: .develop),
        .init(keys: ["Alt", "← / →"], action: "Cycle Generative Remove variations", category: .develop),
        .init(keys: ["V"], action: "Convert to grayscale", category: .develop),
        .init(keys: ["Mod", "U"], action: "Auto Tone", category: .develop),
        .init(keys: ["Mod", "Shift", "U"], action: "Auto White Balance", category: .develop),
        .init(keys: ["Mod", "E"], action: "Edit in Photoshop", category: .develop),
        .init(keys: ["Mod", "Shift", "C"], action: "Copy Develop settings", category: .develop),
        .init(keys: ["Mod", "Shift", "V"], action: "Paste Develop settings", category: .develop),
        .init(keys: ["Mod", "Alt", "V"], action: "Paste settings from previous photo", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "Left Arrow"], action: "Copy After settings to Before", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "Right Arrow"], action: "Copy Before settings to After", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "Up Arrow"], action: "Swap Before and After settings", category: .develop),
        .init(keys: ["↑ / ↓ / + / −"], action: "Adjust selected slider in small increments", category: .develop),
        .init(keys: ["Shift", "↑ / ↓ / + / −"], action: "Adjust selected slider in larger increments", category: .develop),
        .init(keys: [". / ,"], action: "Cycle through Basic panel settings", category: .develop),
        .init(keys: ["Double-click name"], action: "Reset a slider", category: .develop),
        .init(keys: ["Alt-click group"], action: "Reset a group of sliders", category: .develop),
        .init(keys: ["Mod", "Shift", "R"], action: "Reset all Develop settings", category: .develop),
        .init(keys: ["Mod", "Shift", "S"], action: "Sync settings", category: .develop),
        .init(keys: ["Mod", "Alt", "S"], action: "Sync settings without dialog", category: .develop),
        .init(keys: ["Mod-click Sync"], action: "Toggle Auto Sync", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "A"], action: "Enable Auto Sync", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "M"], action: "Match total exposures", category: .develop),
        .init(keys: ["W"], action: "Select White Balance tool", category: .develop),
        .init(keys: ["R"], action: "Select Crop tool", category: .develop),
        .init(keys: ["A"], action: "Constrain crop aspect ratio", category: .develop),
        .init(keys: ["Shift", "A"], action: "Use previous crop aspect ratio", category: .develop),
        .init(keys: ["Alt-drag"], action: "Crop from center", category: .develop),
        .init(keys: ["O"], action: "Cycle Crop grid overlay", category: .develop),
        .init(keys: ["Shift", "O"], action: "Cycle Crop grid orientation", category: .develop),
        .init(keys: ["X"], action: "Switch crop portrait or landscape orientation", category: .develop),
        .init(keys: ["Mod", "Alt", "R"], action: "Reset crop", category: .develop),
        .init(keys: ["Shift", "T"], action: "Select Guided Upright tool", category: .develop),
        .init(keys: ["Q"], action: "Select Spot Removal tool", category: .develop),
        .init(keys: ["Shift", "T"], action: "Toggle Spot Removal Clone or Heal", category: .develop, note: "Spot Removal active"),
        .init(keys: ["K"], action: "Select Adjustment Brush", category: .develop),
        .init(keys: ["M"], action: "Select Graduated Filter", category: .develop),
        .init(keys: ["Shift", "M"], action: "Select Radial Filter", category: .develop),
        .init(keys: ["Shift", "T"], action: "Toggle Mask Edit or Brush mode", category: .develop, note: "Filter active"),
        .init(keys: ["] / ["], action: "Increase or decrease brush size", category: .develop),
        .init(keys: ["Shift", "] / ["], action: "Increase or decrease brush feathering", category: .develop),
        .init(keys: ["/"], action: "Switch between adjustment brushes A and B", category: .develop),
        .init(keys: ["Alt-drag"], action: "Temporarily switch brush to Eraser", category: .develop),
        .init(keys: ["Shift-drag"], action: "Paint a horizontal or vertical line", category: .develop),
        .init(keys: ["Drag pin left/right"], action: "Adjust local Amount", category: .develop),
        .init(keys: ["H"], action: "Show or hide local adjustment pin", category: .develop),
        .init(keys: ["O"], action: "Show or hide local adjustment mask overlay", category: .develop),
        .init(keys: ["Shift", "O"], action: "Cycle mask overlay colors", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "T"], action: "Targeted Adjustment: Tone Curve", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "H"], action: "Targeted Adjustment: Hue", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "S"], action: "Targeted Adjustment: Saturation", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "L"], action: "Targeted Adjustment: Luminance", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "G"], action: "Targeted Adjustment: Grayscale Mix", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "N"], action: "Deselect Targeted Adjustment tool", category: .develop),
        .init(keys: ["J"], action: "Show clipping warnings", category: .develop),
        .init(keys: ["Mod", "]"], action: "Rotate photo clockwise", category: .develop),
        .init(keys: ["Mod", "["], action: "Rotate photo counterclockwise", category: .develop),
        .init(keys: ["Space / Z"], action: "Toggle Loupe and 1:1 Zoom", category: .develop),
        .init(keys: ["Mod", "= / −"], action: "Zoom in or out", category: .develop),
        .init(macOS: ["Cmd", "Return"], windows: ["Ctrl", "Enter"], action: "Play impromptu slideshow", category: .develop),
        .init(keys: ["Y"], action: "Before and After left or right", category: .develop),
        .init(keys: ["Alt", "Y"], action: "Before and After top or bottom", category: .develop),
        .init(keys: ["Shift", "Y"], action: "Before and After split screen", category: .develop),
        .init(keys: ["\\"], action: "View Before only", category: .develop),
        .init(keys: ["Mod", "N"], action: "Create snapshot", category: .develop),
        .init(keys: ["Mod", "Shift", "N"], action: "Create preset", category: .develop),
        .init(keys: ["Mod", "Alt", "N"], action: "Create preset folder", category: .develop),
        .init(keys: ["Mod", "J"], action: "Open Develop view options", category: .develop),
        .init(keys: ["Shift", "Q"], action: "Create Luminance filter", category: .develop),
        .init(keys: ["Mod", "Alt", "Shift", "R"], action: "Crop to original", category: .develop),
        .init(keys: ["Shift", "J"], action: "Create color range", category: .develop),
        .init(keys: ["Alt", "O"], action: "Cycle overlay mode in Crop or Masking", category: .develop),
        .init(macOS: ["Shift", "Cmd", "="], windows: ["Shift", "Ctrl", "="], action: "Lock Zoom position", category: .develop),
        .init(keys: ["Shift", "W"], action: "Open or close Masking", category: .develop),
        .init(keys: ["Shift", "S"], action: "Toggle gamut destination warning", category: .develop),
        .init(keys: ["S"], action: "Expand or collapse Soft Proofing", category: .develop),
        .init(keys: ["H"], action: "Never show overlay or pins", category: .develop),
        .init(keys: ["Mod", "Shift", "H"], action: "Always show overlay or pins", category: .develop),
        .init(macOS: ["Control", "Tab"], windows: ["Ctrl", "Tab"], action: "Cycle through Transform options", category: .develop),
        .init(keys: ["Mod", "C"], action: "Copy a Mask", category: .develop)
    ]
}

private extension LightroomShortcut {
    static let libraryComparison: [LightroomShortcut] = [
        .init(macOS: ["E / Return"], windows: ["E / Enter"], action: "Switch to Loupe view", category: .library),
        .init(keys: ["G / Esc"], action: "Switch to Grid view", category: .library),
        .init(keys: ["C"], action: "Switch to Compare view", category: .library),
        .init(keys: ["N"], action: "Switch to Survey view", category: .library),
        .init(keys: ["Space / E"], action: "Switch from Grid to Loupe view", category: .library),
        .init(keys: ["Down Arrow"], action: "Swap Select and Candidate photos", category: .library, note: "Compare"),
        .init(keys: ["Up Arrow"], action: "Make next photos Select and Candidate", category: .library, note: "Compare"),
        .init(keys: ["Z"], action: "Toggle Zoom view", category: .library),
        .init(keys: ["Mod", "= / −"], action: "Zoom in or out in Loupe view", category: .library),
        .init(keys: ["Page Up / Page Down"], action: "Scroll a zoomed photo", category: .library),
        .init(keys: ["Home / End"], action: "Go to beginning or end of Grid", category: .library),
        .init(macOS: ["Cmd", "Return"], windows: ["Ctrl", "Enter"], action: "Play impromptu slideshow", category: .library),
        .init(keys: ["Mod", "]"], action: "Rotate photo clockwise", category: .library),
        .init(keys: ["Mod", "["], action: "Rotate photo counterclockwise", category: .library),
        .init(keys: ["= / −"], action: "Increase or decrease Grid thumbnail size", category: .library),
        .init(keys: ["Page Up / Page Down"], action: "Scroll Grid thumbnails", category: .library),
        .init(keys: ["Mod", "Shift", "H"], action: "Toggle cell extras", category: .library),
        .init(keys: ["Mod", "Alt", "Shift", "H"], action: "Show or hide badges", category: .library),
        .init(keys: ["J"], action: "Cycle Grid views", category: .library),
        .init(keys: ["Mod", "J"], action: "Open Library view options", category: .library),
        .init(macOS: ["Cmd-click"], windows: ["Ctrl-click"], action: "Select multiple discrete photos", category: .library),
        .init(keys: ["Shift-click"], action: "Select multiple contiguous photos", category: .library),
        .init(keys: ["Mod", "A"], action: "Select all photos", category: .library),
        .init(keys: ["Mod", "D"], action: "Deselect all photos", category: .library),
        .init(macOS: ["Cmd", "Shift", "A"], windows: ["—"], action: "Deselect all photos (alternate)", category: .library, note: "macOS only"),
        .init(keys: ["Mod", "Shift", "D"], action: "Select only active photo", category: .library),
        .init(keys: ["/"], action: "Deselect active photo", category: .library),
        .init(keys: ["Shift", "← / →"], action: "Add previous or next photo to selection", category: .library),
        .init(keys: ["Mod", "Alt", "A"], action: "Select flagged photos", category: .library),
        .init(keys: ["Mod", "Alt", "Shift", "D"], action: "Deselect unflagged photos", category: .library),
        .init(keys: ["Mod", "G"], action: "Group into stack", category: .library),
        .init(keys: ["Mod", "Shift", "G"], action: "Unstack", category: .library),
        .init(keys: ["S"], action: "Toggle stack", category: .library),
        .init(keys: ["Shift", "S"], action: "Move photo to top of stack", category: .library),
        .init(keys: ["Shift", "["], action: "Move photo up in stack", category: .library),
        .init(keys: ["Shift", "]"], action: "Move photo down in stack", category: .library)
    ]

    static let rating: [LightroomShortcut] = [
        .init(keys: ["1–5"], action: "Set star rating", category: .rating),
        .init(keys: ["Shift", "1–5"], action: "Set star rating and advance", category: .rating),
        .init(keys: ["0"], action: "Remove star rating", category: .rating),
        .init(keys: ["Shift", "0"], action: "Remove star rating and advance", category: .rating),
        .init(keys: ["] / ["], action: "Increase or decrease rating", category: .rating),
        .init(keys: ["6"], action: "Assign red label", category: .rating),
        .init(keys: ["7"], action: "Assign yellow label", category: .rating),
        .init(keys: ["8"], action: "Assign green label", category: .rating),
        .init(keys: ["9"], action: "Assign blue label", category: .rating),
        .init(keys: ["Shift", "6–9"], action: "Assign color label and advance", category: .rating),
        .init(keys: ["P"], action: "Flag photo as Pick", category: .rating),
        .init(keys: ["Shift", "P"], action: "Flag as Pick and advance", category: .rating),
        .init(keys: ["X"], action: "Flag photo as Reject", category: .rating),
        .init(keys: ["Shift", "X"], action: "Flag as Reject and advance", category: .rating),
        .init(keys: ["U"], action: "Unflag photo", category: .rating),
        .init(keys: ["Shift", "U"], action: "Unflag photo and advance", category: .rating),
        .init(keys: ["Mod", "↑ / ↓"], action: "Increase or decrease flag status", category: .rating),
        .init(keys: ["`"], action: "Cycle flag settings", category: .rating),
        .init(keys: ["Mod", "Alt", "R"], action: "Refine photos", category: .rating),
        .init(keys: ["\\"], action: "Show or hide Library Filter bar", category: .rating),
        .init(keys: ["Shift-click filters"], action: "Open multiple filters", category: .rating),
        .init(keys: ["Mod", "L"], action: "Toggle filters on or off", category: .rating),
        .init(keys: ["Mod", "F"], action: "Find photo in Library", category: .rating)
    ]

    static let collections: [LightroomShortcut] = [
        .init(keys: ["Mod", "N"], action: "Create a new collection", category: .collections),
        .init(keys: ["B"], action: "Add to Quick Collection", category: .collections),
        .init(keys: ["Shift", "B"], action: "Add to Quick Collection and advance", category: .collections),
        .init(keys: ["Mod", "B"], action: "Show Quick Collection", category: .collections),
        .init(keys: ["Mod", "Alt", "B"], action: "Save Quick Collection", category: .collections),
        .init(keys: ["Mod", "Shift", "B"], action: "Clear Quick Collection", category: .collections),
        .init(keys: ["Mod", "Alt", "Shift", "B"], action: "Set as target collection", category: .collections)
    ]

    static let metadata: [LightroomShortcut] = [
        .init(keys: ["Mod", "K"], action: "Add keywords", category: .metadata),
        .init(keys: ["Mod", "Shift", "K"], action: "Edit keywords", category: .metadata),
        .init(keys: ["Mod", "Alt", "Shift", "K"], action: "Set a keyword shortcut", category: .metadata),
        .init(keys: ["Shift", "K"], action: "Add or remove keyword shortcut", category: .metadata),
        .init(keys: ["Mod", "Alt", "K"], action: "Enable keyword painting", category: .metadata),
        .init(keys: ["Alt", "1–9"], action: "Add keyword from keyword set", category: .metadata),
        .init(keys: ["Alt", "0"], action: "Cycle forward through keyword sets", category: .metadata),
        .init(keys: ["Alt", "Shift", "0"], action: "Cycle backward through keyword sets", category: .metadata),
        .init(keys: ["Mod", "Alt", "Shift", "C"], action: "Copy metadata", category: .metadata),
        .init(keys: ["Mod", "Alt", "Shift", "V"], action: "Paste metadata", category: .metadata),
        .init(keys: ["Mod", "S"], action: "Save metadata to file", category: .metadata),
        .init(macOS: ["Cmd", ":"], windows: ["—"], action: "Open Spelling dialog", category: .metadata, note: "macOS only"),
        .init(macOS: ["Cmd", ";"], windows: ["—"], action: "Check spelling", category: .metadata, note: "macOS only"),
        .init(macOS: ["Cmd", "Option", "T"], windows: ["—"], action: "Open Character palette", category: .metadata, note: "macOS only"),
        .init(keys: ["Mod", "Alt", "Shift", "F"], action: "Visual Search", category: .metadata),
        .init(keys: ["Shift", "O"], action: "Edit face name", category: .metadata)
    ]
}

// Catalogs remain separate so Lightroom searches and practice never mix apps.
enum ShortcutApplication: String, CaseIterable, Identifiable {
    case lightroom = "Lightroom Classic"
    case photoshop = "Photoshop"
    var id: Self { self }
    var shortcuts: [LightroomShortcut] {
        switch self {
        case .lightroom: LightroomShortcut.all
        case .photoshop: LightroomShortcut.photoshop
        }
    }
    var categories: [ShortcutCategory] {
        [.all] + ShortcutCategory.allCases.filter { category in
            category != .all && shortcuts.contains { $0.category == category }
        }
    }
}
