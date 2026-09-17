# Photoshop catalog coverage

Prepared 11 September 2026 for the next Lightroom Keys update. Target: Photoshop desktop on Mac and Windows.

The catalog contains 712 reference entries in 36 categories, including Camera Raw. Entries include tool shortcuts, menu commands and modifier/mouse gestures. Several entries can share a key because they operate in different contexts. The count is not a count of unique key combinations.

## Latest additions

46 additional entries: 27 for Select and Mask, eight for Liquify, six for Crop, three for Content-Aware Fill, one luminosity-selection command and one pending Remove-stroke command. Existing entries are preserved. New workspace keys carry context notes.

## References

- Adobe Photoshop reference, printed pages 174–195: https://helpx.adobe.com/content/dam/help/en/pdf/photoshop_reference.pdf
- Adobe shortcut PDF: https://helpx.adobe.com/content/dam/help/en/photoshop/using/default-keyboard-shortcuts/photoshop-keyboard-shortcuts.pdf
- Adobe Education Exchange menu reference (Tarek Bahaa El Deen, referencing Adobe Press's Photoshop 2020 manual): https://cdn.edex.adobe.com/v3/uploads/resourceFile/2023/c0c1aaee-43e8-4c03-9b2c-aaec2c3d9285/08d7c4a0-c2ba-4d6a-8fa2-396d2d99c346.pdf
- Current Adobe Camera Raw table, imported with explicit Windows and Mac columns: https://helpx.adobe.com/au/camera-raw/desktop/get-started/overview-and-setup/default-keyboard-shortcuts.html
- Current Photoshop shortcut settings: https://helpx.adobe.com/photoshop/desktop/get-started/settings-and-preferences/view-keyboard-shortcuts.html
- Modern Undo/Redo: https://helpx.adobe.com/photoshop/desktop/get-started/set-up-toolbars-panels/use-undo-redo-commands.html
- Object Selection: https://helpx.adobe.com/photoshop/using/tool-techniques/object-selection-tool.html
- Frame tool: https://helpx.adobe.com/photoshop/using/tool-techniques/frame-tool.html

Additional references checked for this batch:

- Select and Mask tools and views, firsthand instruction by Adobe's Julieanne Kost: https://jkost.com/blog/2021/07/25-shortcuts-and-tips-for-creating-better-selections-in-photoshop.html
- Current Select and Mask view modes: https://helpx.adobe.com/photoshop/desktop/make-selections/refine-modify-selections/refine-your-selection-and-mask.html
- Liquify gestures: https://jkost.com/blog/2014/07/using-liquify-in-photoshop.html
- Crop controls: https://jkost.com/blog/2017/05/essential-tips-for-cropping-in-photoshop-cc.html
- Current Content-Aware Fill controls: https://helpx.adobe.com/photoshop/desktop/repair-retouch/remove-objects-fill-space/tools-to-fine-tune-sampling-and-fill-areas.html
- Applying pending Remove strokes, Adobe MAX demonstration: https://www.adobe.com/max/2024/sessions/master-photoshop-2025-exploring-features-s6703.html

## Scope and remaining verification

The full Photoshop PDF is internally dated 2019, despite its recent search indexing. The catalog therefore must not be advertised as an independently verified, exhaustive list for the latest Photoshop release. Known outdated sections (old Camera Raw, Refine Edge, Extract/Pattern Maker, obsolete Liquify tools) were excluded or replaced. Modern Undo/Redo entries and current Camera Raw defaults were used. The old standalone Rounded Rectangle tool was excluded while retaining the current shape tools.

The 712 entries have been structurally checked, but not individually executed in Photoshop. To substantiate “every current Photoshop shortcut,” compare against a default-shortcut summary exported from the exact current Photoshop version on both platforms. Commands without a default shortcut, user customizations, beta-only commands and plug-in-specific commands are outside this catalog. Some newer tools and workspace commands may still be absent.

Tools/photoshop-catalog.json records each entry's reference and context; Tools/photoshop-exclusions.json records excluded rows from inspected tables. The exclusion file is not a complete catalog of all retired features.

The app identifies these as desktop defaults, supplies context notes and links to Adobe's shortcut settings page. The submitted App Store binary is not modified by these source changes.

## Validation

- Full iOS Swift type check passed, including previews.
- Catalog checks cover unchanged Lightroom count, category separation, IDs, nonempty keys, removed footnote markers, current Camera Raw entries and Mac Control/Command exceptions.
- Full Xcode build and simulator UI verification remain blocked by the unavailable iOS platform/runtime in the installed Xcode setup. Complete these before uploading a new build.

## Maintaining the catalog

Edit Tools/photoshop-catalog.json, then run `python3 Tools/generate_photoshop.py` from the project directory. The generator only rebuilds the Photoshop Swift data file. Add new category cases to Shortcut.swift when introducing new contexts. Tools/photoshop-workspace-additions.json records this batch; Tools/CatalogChecks.swift verifies catalog invariants and important platform differences.

For this batch, the changed data/model files passed the iOS-targeted Swift type check. The executable catalog checks passed with 332 Lightroom entries and 712 Photoshop entries. An additional comparison verified that every pre-existing initializer was retained and exactly 46 were added. These checks do not replace running the shortcuts in Photoshop or testing the iPhone UI.
