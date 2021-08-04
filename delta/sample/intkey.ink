*COMMENT Intkey initialization file.

*SET IMAGEPATH images
*SET INFOPATH info

*FILE TAXA iitems
*FILE CHARACTERS ichars

*FILE INPUT settings.inp

*COMMENT Intkey toolbar (start).
*COMMENT Button definitions using FILE-DISPLAY commands must be here,
*COMMENT not in toolbar.inp. webgen.bat converts them to URLs, and
*COMMENT saves the altered file as intkeyw.ink.

*DEFINE BUTTON CLEAR

*DEFINE BUTTON intro.bmp
"FILE DISPLAY index.htm"
"Introduction, references, contact information, etc."
"This button allows you to display an introduction to the package,
attributes treated as ‘implicit’ in the descriptions,
acknowledgements, references, contact information, and conditions of use."

*DEFINE BUTTON hints.bmp
"FILE DISPLAY hints.htm"
"Hints on using the key"
"This button displays information on how to use the interactive key."

*FILE INPUT toolbar.inp
