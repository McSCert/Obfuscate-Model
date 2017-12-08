README
======

This readme contains a brief description of the small utility functions I've put together that aren't big enough to warrant being a full tool, but are useful little quality of life upgrades. Any utility that needs more explaining will have its own document. 

UTILITIES
=========

renameBlock.m - Renames all blocks in a model with the same name to a new name. Call as follows: 

renameBlock(rootSysName, oldname, newname)

renameDS.m - Renames all data store blocks with the same data store name to a new data store name. Note that this is the "dataStoreName" parameter, not the "Name" parameter of the data store blocks. Does not take shadowing into account. Call as follows:

renameDS(rootSysName, oldname, newname)

renameGoto.m - Renames all gotos, froms, and goto tag visibility blocks that share a GotoTag with a new GotoTag. Note that this is the "GotoTag" parameter and not the "Name" parameter of the data store blocks. Does not take shadowing into account. Call as follows:

renameDS(rootSysName, oldtag, newtag)

renameConstant - Changes the value of all constant blocks that share the same value with a new value. This is the "Value" parameter, not the name parameter! Be careful, as this function does not just work on constants, it works on any block with a "Value" parameter, so be wary. Typically used when the constant block has a calibration as its value.

renameDS(rootSysName, oldvalue, newvalue)