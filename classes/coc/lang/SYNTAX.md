# Mod scripting syntax
## Concepts

A *Mod* is a collection of game objects such as areas, encounters and scenes.

### Area
*Area* is a named pool of encounters; it does not have any properties except its name and ID.

### Encounter

### Scene
*Scene* is displayable "page" of content; it can not only display text but also have side-effects &mdash; perform actions such as altering player stats, status effects etc.

Scene ends with menu of buttons. Each button can lead to:
* Next scene
* Battle
* Return (to camp)
* "Acquire item" subscene followed by another scene

## Syntax

Mod file should start with language version directive
```
# version 1
```
followed by mod header.

After mod header, mod content is present (in any order).
Possible content types:
* Encounter
* Scene

### Mod header

```
Mod "mod_name"
```

### Encounter

```
Encounter "encounter_id" = [
    property_name: property_value
    property_name: property_value
    ...
]
```

### Scene

```
Scene "id":

// scene body

// scene menu 

End Scene
```

#### Scene body statements

##### Text output
```
p "Text"
```
Display paragraph of text
```
cont "Text"
```

##### Game commands

Game commands are in form of
```
CommandName argument
```
or
```
CommandName arg1=value1 arg2=value2 ...
```

A list of available commands and their arguments will be provided in separate file.

##### Flow control

#### Scene menu

```
Menu:

choice choice_properties "Label" -> transition
choice choice_properties "Label" -> transition
...

End Menu
```
where optional choice_properties can be: (TODO)

Shortcut for single "Next" button is
```
Next -> transition
```

##### Menu transitions
```
-> return
```
Return to camp, use 1 hour.
```
-> "scene_ref"
```
Continue to scene "scene_ref"
```
-> battle
```
TODO

##### Goto

Can be used instead of Next/Menu.
```
Goto "scene_ref"
```
will imediately call scene `"scene_ref"`, without clearing screen

### Expression syntax

Strings, numbers, and variable references can be used as-is. Any more complex expressions using operators should be wrapped in `()`.

E.g.:
* `AddLust 10`
* `p "Text"` 
* `AddHp $variable`

but
* `AddLust (10+$variable)`
* `p ($variable ? "Text" : "AnotherText")`

#### Strings

```
'short string'
"short string"
'''long string'''
"""long string"""
```
Long strings can be multi-line.

Short string can escape characters with `\ `: 
* `\n` is line break
* `\t` is tab character
* `\u12ef` is Unicode character 0x12EF
* `\'`, `\"`. `\\` encode `'`, `"`. `\ ` characters


#### Numbers

Decimal integers & real numbers. Scientific notation is also supported (1.2e-4). For real numbers, you cannot omit integer part (`0.5`, not `.5`).

