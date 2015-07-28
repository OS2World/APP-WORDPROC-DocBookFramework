/*
 *************************************************************************************
 *
 *   DocBook Framework for OS/2 and eComStation
 *   Create the WarpIN installation archive
 *
 *   More info on the web:
 *   http://www.kacer.biz/os2/docbook-framework/
 *
 *   Author:
 *   Jarda Kacer <mailto:jarda@kacer.biz>
 *
 *************************************************************************************
 *
 *   This script creates the framework's WarpIN installation archive.
 *   Attention: No directory to be included in the archive can have the ARCHIVE flag set!
 *
 *************************************************************************************
 *
 *   $Author: jkacer $
 *   $Revision: 2 $
 *   $Date: 2007-09-05 15:07:46 -0500 (Wed, 05 Sep 2007) $
 *   $HeadURL: http://svn.netlabs.org/repos/docbook/trunk/Install/MakeWPI.CMD $
 *
 *************************************************************************************
 */

FrameworkVersionMajor = "1"
FrameworkVersionMinor = "0"
FrameworkVersionPatch = "0"

WarpINDirectory = "C:\eCS\Install\WarpIN"
PathToWIC = WarpINDirectory || "\wic.exe"
Description = "DBF4OS2.WIS"
ArchiveName = "DocBookFrameworkForOS2"

TargetDirectory = "E:\Temp"
DistributionDirectory = "..\Distribution"

PathToArchive = TargetDirectory || "\" || ArchiveName || "-" || FrameworkVersionMajor || "-" || FrameworkVersionMinor || "-" || FrameworkVersionPatch || ".WPI"
Command = PathToWIC || " " || PathToArchive || " -a 1 -c" || DistributionDirectory || " -r * -s " || Description

Command

EXIT
