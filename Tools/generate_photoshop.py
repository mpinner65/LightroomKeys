"""Regenerate PhotoshopShortcuts.swift from the audited JSON; no UI edits.
Run from any directory with Python 3. Only the standard library is required.
Add new categories to Shortcut.swift before generating new contexts.
"""
from pathlib import Path
import json, re
root=Path(__file__).resolve().parents[1]
rows=json.loads((root/'Tools/photoshop-catalog.json').read_text())
contexts=list(dict.fromkeys(r['context'] for r in rows))
def ident(s):return 'ps'+re.sub('[^a-zA-Z]','',s)
def quote(s):return json.dumps(s,ensure_ascii=False)
def keys(text,mac):
    text=text.replace('Command','⌘').replace('Control','⌃' if mac else 'Ctrl').replace('Ctrl','⌃' if mac else 'Ctrl').replace('Option','⌥')
    text=re.sub(r'\s*\+\s*',' + ',text).strip()
    if len(text)<=45 and not re.search(r'\b(or|tool|click|drag|when)\b',text,re.I):
        parts=text.split(' + ')
        if all(parts):return parts
    return [text]
model=(root/'LightroomKeys/Shortcut.swift').read_text()
for context in contexts:
    assert 'case '+ident(context)+' =' in model, 'Missing category: '+context
for row in rows:
    assert row['action'] and row['macOS'] and row['windows'] and row['source'],row
s='// Generated from Tools/photoshop-catalog.json. See PHOTOSHOP-SOURCES.md for coverage.\nimport Foundation\n\nextension LightroomShortcut {\n    static let photoshop: [LightroomShortcut] = [\n'
s+='\n'.join('        '+ident(c)+'Entries,' for c in contexts)
s+='\n    ].flatMap { $0 }\n}\n\nprivate extension LightroomShortcut {\n'
for context in contexts:
    s+='    static let '+ident(context)+'Entries: [LightroomShortcut] = [\n'
    for row in rows:
        if row['context']!=context:continue
        s+='        .init(macOS: '+quote(keys(row['macOS'],True))+', windows: '+quote(keys(row['windows'],False))+', action: '+quote(row['action'])+', category: .'+ident(context)
        if row['note']:s+=', note: '+quote(row['note'])
        s+='),\n'
    s+='    ]\n'
s+='}\n'
(root/'LightroomKeys/PhotoshopShortcuts.swift').write_text(s)
print(f'Generated {len(rows)} entries in {len(contexts)} categories.')
