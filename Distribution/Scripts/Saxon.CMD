/*
 *************************************************************************************
 *
 *   DocBook Framework for OS/2 and eComStation
 *   Start Saxon
 *
 *   More info on the web:
 *   http://www.kacer.biz/os2/docbook-framework/
 *
 *   Author:
 *   Jarda Kacer <mailto:jarda@kacer.biz>
 *
 *************************************************************************************
 *
 *   This script invokes Saxon and passes all user arguments to it.
 *   It also sets environment variables SGML_CATALOG_FILES and XML_CATALOG_FILES
 *   before Saxon is launched. Make sure you use DocBook v. 4.3, the catalog files
 *   are written for this version only. When using other version than 4.3, Saxon
 *   will always connect to the Internet.
 *
 *************************************************************************************
 *
 *   $Author: jkacer $
 *   $Revision: 2 $
 *   $Date: 2007-09-05 15:07:46 -0500 (Wed, 05 Sep 2007) $
 *   $HeadURL: http://svn.netlabs.org/repos/docbook/trunk/Distribution/Scripts/Saxon.CMD $
 *
 *************************************************************************************
 */

OuterEnv = SetLocal()

CALL RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
CALL SysLoadFuncs

ScriptDir = GetScriptPath()
RootDir = GetParentDirectory(ScriptDir)

JavaCommand = "java.exe"
JavaX = " -Xmx100M" /* was 300 */

JavaCP = " -cp " || RootDir || "\SW\Saxon;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\resolver.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\saxon.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\xercesImpl.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\xmlParserAPIs.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\saxon-jdom.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\saxon-xml-apis.jar;"
JavaCP = JavaCP || RootDir || "\SW\Saxon\saxon643.jar;"

JavaD1 = " -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration"
JavaD2 = " -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl"
JavaD3 = " -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl"

MainClass = " com.icl.saxon.StyleSheet"

ResolverX = " -x com.sun.resolver.tools.ResolvingXMLReader"
ResolverY = " -y com.sun.resolver.tools.ResolvingXMLReader"
ResolverR = " -r com.sun.resolver.tools.CatalogResolver"

Arguments = ARG(1)

FinalCommand = JavaCommand || JavaX || JavaCP || JavaD1 || JavaD2 || JavaD3 || MainClass || ResolverX || ResolverY || ResolverR || " " || Arguments

/*
 *  Set catalog environment variables
 */
CatalogSGML = RootDir || "\SW\Jade\catalog;" || RootDir || "\ISOEntities\isoent.cat;" || RootDir || "\DTD\docbook.cat"
CatalogXML = "file:///" || TRANSLATE(RootDir, '/', '\') || "/catalog.xml"

CALL SetEnvironment "SGML_CATALOG_FILES", CatalogSGML
CALL SetEnvironment "XML_CATALOG_FILES", CatalogXML

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
