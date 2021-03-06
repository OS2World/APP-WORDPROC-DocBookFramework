=========================================
DocBook Framework for OS/2, version 1.0.0
=========================================

DocBook Framework for OS/2 is a bundle of programs and libraries allowing you
to manipulate DocBook source files and convert them to various output formats.
The framework itself does not bring any new software to you, it just groups
free software downloaded from different places and provides Rexx scripts to
configure and launch the software in the right way.

DocBook is a XML-based platform-independent format for books, articles,
technical documentation, FAQ, slides, etc. Once you write your stuff in DocBook,
you can convert it to a number of output formats, including:

- HTML
- XHTML
- HTML Help for Windows
- Java Help
- Eclipse Help
- UNIX Manual Pages
- Formatting Objects, an intermediate format between DocBook and various
  paged-media formats
- PCL
- PDF
- PostScript
- RTF
- SVG
- plain text
- WML (Wordprocessing Markup Language)

The main advantages of using DocBook are the following:

- DocBook is a platform-independent format. You can can edit, read and convert
  the same file on any platform. You can even change the platform right in the
  middle of editing your file, the first part can be written on Windows, the
  second one on OS/2.
- DocBook is XML. This means that you can use all standard tools that
  manipulate XML data, such as parsers, checkers, and converters. 
- DocBook is an open format. This guarantees that you will be able to read and
  manipulate your today-written article in the future.
- Many output formats available. Being a XML format, DocBook itself is not
  intended to be read directly by humans. Instead, many output formats can be
  generated from DocBook, including popular formats such as PDF, HTML and RTF.


----------------------
1. System Requirements
----------------------

The framework is a bundle of Java software, data files, and Rexx scripts.
Therefore, you will need the following stuff installed:

- Rexx
- Java. Use Golden Code or InnoTek Java 1.4, if you can. However, IBM Java 1.3
  should also work.
- WarpIN for installation/deinstallation. Since you are reading this file, you
  have probably installed it already.


----------------------------------
2. Installation and Deinstallation
----------------------------------

DocBook Framework is installed automatically using WarpIN. During installation,
your CONFIG.SYS will be modified. If you don't allow WarpIN to perform the
modification, you will have to:

- either modify CONFIG.SYS on your own by adding the "...\Scripts" directory to
  your PATH, or
- add the "...\Scripts" directory to your PATH from the command line every time
  you use the framework.

In addition, java.exe must be in your PATH. It is assumed that PATH already
contains a Java "...\jre\bin" directory and no checks are performed, neither
during installation nor during normal operation.

Before you start using the framework, take a little time to configure it. A few
configuration files must be set up in order for the tools to operate properly.
Please read the file PatchTheseFiles.TXT for more details. These changes can be
performed automatically and future versions of the framework will contain
a little configuration tool that will be executed during installation.

The framework can be uninstalled using WarpIN. You can also delete it manually,
but then the WarpIN database will not be consistent with your hard disk's
content.


------------------------------
3. Components of the Framework
------------------------------

The framework consists of the following components:

1. DocBook DTD and ISO entities.
2. DocBook XSL stylesheets that prescribe how DocBook documents should be
   converted into other formats.
3. Saxon - XSLT processor that converts a DocBook document into another format
   using a XSL stylesheet.
4. FOP - FO processor that converts an FO document (generated by Saxon) into
   a paged-media document.
5. Rexx scripts that set up the environment properly before launching the
   programs.

Other software can be plugged into the framework, e.g. XFC or XEP. Rexx scripts
for starting them are present in the distribution, but the programs could not
be included because of their strict licenses. However, you can easily download
them on your own and install them into the "...\SW\XFC" and "...\SW\XEP"
directories. Look into the UsefulLinks.TXT file for links to the software.

Some DocBook-related programs were not included in the distribution. An example
of such programs is OpenJade, a converter using DSSSL styles. DSSSL styles are
older than XSL styles and their importance falls down continuously. In adition,
OpenJade is a native program. Programs like OpenJade may be included in a future
version if users request it.

Editors were not included either. I recommend using either jEdit or XXE. The
latter is almost-WYSIWYG so it will probably be preferred by many users. Again,
see the file UsefulLinks.TXT for an URL.


----------------------
4. Using the Framework
----------------------

The framework offers 19 Rexx scripts that you can call directly and pass them
your DocBook file as a parameter. The scripts are as follows:

DB2EclipseHelp.CMD
 - Converts DocBook into Eclipse help.

DB2FO.CMD
 - Converts DocBook into Formatting Objects. Formatting objects are the
   starting point for paged-media formats, therefore a very important format.
   Look at FO2* scripts to see what you get out of formatting objects.

DB2HTML.CMD
 - Converts DocBook into a single HTML file.

DB2HTMLChunks.CMD
 - Converts DocBook into a set of HTML files, chained by links.

DB2HTMLHelp.CMD
 - Converts DocBook into a set of HTML files that can be compiled into a CHM
   file. This can be used on Windows only.

DB2JavaHelp.CMD
 - Converts DocBook into a set of HTML and XML files that can be packed into
   a JAR archive and read by a Java program.

DB2ManPages.CMD
 - Converts DocBook reference entries into UNIX manual pages. Not much useful
   on OS/2...

DB2XHTML.CMD
 - Converts DocBook into a single XHTML file.

DB2XHTMLChunks.CMD
 - Converts DocBook into a set XHTML files, chained by links.

FO2MIF.CMD
 - This conversion does not work yet.

FO2PCL.CMD
 - Converts Formatting Objects into a PCL file that can be sent to a printer.

FO2PDF.CMD
 - Converts Formatting Objects into a Portable Document format.

FO2Printer.CMD
 - Renders Formatting Objects directly onto a printer.

FO2PS.CMD
 - Converts Formatting Objects into PostScript.

FO2RTF-UsingXFC.CMD
 - Converts Formatting Objects into Rich Text Format. On OS/2, use OpenOffice
   to open the resulting RTF. You must install XFC on your own to be able to
   perform this conversion.

FO2Screen.CMD
 - Renders Formatting Objects on the screen.

FO2SVG.CMD
 - Converts Formatting Objects into Scalable Vector Graphics.

FO2TXT.CMD
 - Converts Formatting Objects into plain text.

FO2WML-UsingXFC.CMD
 - Converts Formatting Objects into Wordprocessing Markup Language. The
   resulting file can be opened by Microsoft Word XP and 2003 on Windows. You
   must install XFC on your own to be able to perform this conversion.

If a new XSL stylesheet appears, you can directly call the converters and
supply them the stylesheet as a parameter. See Saxon.CMD, FOP.CMD, XFC.CMD, and
XEP.CMD for details.


-------------------
5. More Information
-------------------

The framework's homepage is at
    http://www.kacer.biz/os2/docbook-framework

To contact the packager, write to:
    jarda@kacer.biz
