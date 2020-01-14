## Compiler errors E*XXX*
Note that errors, especially "Expected (something)" kind, are often caused by _preceding_ code. 

For example, the code
```
Encounter "magic" [
    pool = "forest" 
    ] scene = "magic"
]
```
will crash on word `scene`, because `]`, though _semantically_ incorrect, is _syntaxically_ correct end-of-encounter and the compiler will continue processing the file as if the encounter declaration is finished and there will be next top-level game object.

"EOL" means "End of line" and "EOF" - "End of file". 
### Generic errors (E000-E099)
#### E001 Internal error
Should not happen; report to devs.
#### E002 Bad character
Encountered unexpected character that is not a start of number, word, or supported control symbol. 

Probably you closed a comment or string too early and its contents poped out.
#### E003 Feature not implemented yet
What it says on the box &mdash; whatever you're trying to do, it's supposed to work in future.
### Top-level and generic game object errors (E100-E199)
#### E100 Expected language version
Incorrect first non-empty non-comment line; should start with `# version `*`VERSION_NUMBER`*. See docs.
#### E101 Not supported language version
Bad value in language version directive. See docs for supported version(s).
#### E102 Expected content start
Expected mod-level content (like `Encounter`, `Scene` - see docs). 

Could also appear if previous content was not properly closed, e.g. missing `End Scene`.
#### E103 Duplicate game object
When you declare two or more game objects of same type with same IDs. Reported location corresponds to second encounter.

Possibly caused by copy-pasing and not making IDs unique.
#### E104 Duplicate *game object* property
Same property assigned twice inside game object properties section. Reported location corresponds to second assignment.
#### E105 Unknown *game object* property
Check docs on that game object definition for list of properties.
#### E106 Missing *game object* property
Check docs on that game object definition for list of properties. A required property is missing. 
#### E107 Expected mod header block
Missing or incorrect `Mod` header block. See docs on Mod header.
#### E108 Expected *something*
Incorrect mod header structure. See docs on Mod header.
### Expression errors (E300-E399)
#### E301 Complex expression must be wrapped in ()
Expression denoting calculation should be wrapped in parentheses `()`; valid "bare" expressions are string literals, numbers, and variable references.

This error can be caused by mismatched parentheses or quotes.
### Encounter errors (E400-E499)
#### E400 Expected *something*
Incorrect Encounter structure. See docs on Encounter.
### Scene errors (E500-E599)
#### E500 Expected *something*
Incorrect Scene strucure. See docs on Scene.
#### E501 Missing menu
Scene should have either a `Menu`, `Next`, or `Goto`. See docs on Scene menus.
#### E502 Incorrect transition
Incorrect transition (choice action). See docs on Scene menus.
#### E503 Empty menu
Scene menu should have at least one choice. See docs on Scene menus.
