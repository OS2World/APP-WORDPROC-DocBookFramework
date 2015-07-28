/*
 *************************************************************************************
 *
 *   DocBook Framework for OS/2 and eComStation
 *   Start FOP
 *
 *   More info on the web:
 *   http://www.kacer.biz/os2/docbook-framework/
 *
 *   Author:
 *   Jarda Kacer <mailto:jarda@kacer.biz>
 *
 *************************************************************************************
 *
 *   This script invokes FOP and passes all user arguments to it.
 *
 *************************************************************************************
 *
 *   $Author: jkacer $
 *   $Revision: 2 $
 *   $Date: 2007-09-05 15:07:46 -0500 (Wed, 05 Sep 2007) $
 *   $HeadURL: http://svn.netlabs.org/repos/docbook/trunk/Distribution/Scripts/FOP.CMD $
 *
 *************************************************************************************
 */

OuterEnv = SetLocal()

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
CALL SysLoadFuncs

ScriptDir = GetScriptPath()
RootDir = GetParentDirectory(ScriptDir)

JavaCommand = "java.exe"

JavaCP = " -cp "
JavaCP = JavaCP || RootDir || "\SW\FOP\build\fop.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\batik.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\xalan-2.4.1.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\xercesImpl-2.2.1.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\xml-apis.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\avalon-framework-cvs-20020806.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\logkit-1.0.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\jimi-1.0.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\jai_core.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\lib\jai_codec.jar;"
JavaCP = JavaCP || RootDir || "\SW\FOP\hyph"

MainClass = " org.apache.fop.apps.Fop"
FOPCommand = " -c " || RootDir || "\SW\FOP\conf\userconfig.xml"

Arguments = ARG(1)

FinalCommand = JavaCommand || JavaCP || MainClass || FOPCommand || " " || Arguments

/*
 *  Execute the final command
 */
FinalCommand

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
 * Returns the parent directory of the directory passed as argument, without "\" at the end
 */
GetParentDirectory: PROCEDURE
PARSE ARG DirName
RETURN SUBSTR(DirName, 1, LASTPOS("\", DirName)-1)
