## Compile & run-time mod-related errors E*XXX*
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

### Validation errors (E800-E899)
These errors can appear in runtime as well as during mod loading, if type & reference checking would ever be implemented.

#### E800 Illegal state
Somehow a code that should've failed at compile-time survived until validation/runtime, resulting in an illegal internal state.

It is very likely a bug in compiler.

#### E801 Unknown command
Unknown command in a scene. Check for typos and command reference. 

#### E802 Wrong number of arguments
Wrong number of arguments for command in a scene. Check for typos and command reference.

Can be caused by too early EOL between arguments.

#### E803 Incorrect argument type
In a command or function, supplied argument does not match expected type. Check command reference.

#### E804 Scene does not exist
A scene with that ID does not exist in any loaded module.

### Run-time errors (E900-E999)

#### E900 Internal error
Can be caused by bug in a game as well as error in a mod that wasn't properly handled and designated a error code (which is also likely bug in a game).

#### E901 No such *something*: *ID*
A game object (item, perk, ...) referenced by ID does not exist.

Can be caused by typo, missing mod, or removed content.

### Mod loading errors (E1000-E1099)

### E1000 Redeclaration of *something* *ID* by mod *ID*
A mod tries to add game object with ID already present in another mod.

If the intent was to patch, use patch game object type. Otherwise, consider using local namespace or change the id any other way.