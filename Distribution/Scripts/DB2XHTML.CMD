/*
 *************************************************************************************
 *
 *   DocBook Framework for OS/2 and eComStation
 *   Convert DocBook to XHTML
 *
 *   More info on the web:
 *   http://www.kacer.biz/os2/docbook-framework/
 *
 *   Author:
 *   Jarda Kacer <mailto:jarda@kacer.biz>
 *
 *************************************************************************************
 *
 *   This script converts a DocBook document into a single XHTML file.
 *
 *************************************************************************************
 *
 *   $Author: jkacer $
 *   $Revision: 2 $
 *   $Date: 2007-09-05 15:07:46 -0500 (Wed, 05 Sep 2007) $
 *   $HeadURL: http://svn.netlabs.org/repos/docbook/trunk/Distribution/Scripts/DB2XHTML.CMD $
 *
 *************************************************************************************
 */

OuterEnv = SetLocal()

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
CALL SysLoadFuncs

ScriptDir = GetScriptPath()
RootDir = GetParentDirectory(ScriptDir)

Arguments = ARG(1)

IF WORDS(Arguments) = 1
	THEN DO
		InputFile = WORD(Arguments, 1)
		OutputFile = SUBSTR(InputFile, 1, LASTPOS(".", InputFile)-1) || ".XHTML"
		CALL Saxon "-o " || OutputFile || " " || InputFile || " " || RootDir || "\XSL\xhtml\docbook.xsl use.extensions=1"
	END
	ELSE DO
		CALL PrintUsage
	END

CALL EndLocal
EXIT


/***********************************************************************************************/
/*                               Procedures and functions                                      */
/***********************************************************************************************/


/*
 * Sets an environment variable or appends a value to it.
 */
AddEnvironment: PROCEDURE
PARSE ARG VarName, VarValue
IF (Value(VarName, , "OS2ENVIRONMENT")="")
	THEN CALL SetEnvironment VarName, VarValue
	ELSE CALL Value VarName, GetEnvironment(VarName) || ";" || VarValue, "OS2ENVIRONMENT"
RETURN


/*
 * Sets an environment variable, overwriting its previous value.
 */
SetEnvironment: PROCEDURE
PARSE ARG VarName, VarValue
CALL Value VarName, VarValue, "OS2ENVIRONMENT"
RETURN


/*
 * Returns the value of an environment variable.
 */
GetEnvironment: PROCEDURE
PARSE ARG VarName
RETURN Value(VarName, , "OS2ENVIRONMENT")


/*
 * Returns the current script name.
 */
GetScriptName: PROCEDURE
PARSE SOURCE Result
RETURN WORD(Result, 3)


/*
 * Returns the current script path, without "\" at the end.
 */
GetScriptPath: PROCEDURE
ScriptName = GetScriptName()
RETURN SUBSTR(ScriptName, 1, LASTPOS("\", ScriptName)-1)


/*
 * Returns True if the given file exists.
 */
FileExists: PROCEDURE
PARSE ARG FileName
CALL SysFileTree FileName, Result
RETURN Result.0 > 0


/*
 * Returns the current directory, without "\" at the end.
 */
GetCurrentDir: PROCEDURE
RETURN DIRECTORY()


/*
 * Returns the parent directory of the directory passed as argument, without "\" at the end.
 */
GetParentDirectory: PROCEDURE
PARSE ARG DirName
RETURN SUBSTR(DirName, 1, LASTPOS("\", DirName)-1)


/*
 * Prints out a short help on how to call this script.
 */
PrintUsage: PROCEDURE
SAY "DocBook Framework for OS/2, DocBook --> XHTML"
SAY "Usage: DB2XHTML <DocBook Source>"
RETURN

