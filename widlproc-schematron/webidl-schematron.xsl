<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<axsl:param name="archiveDirParameter"/><axsl:param name="archiveNameParameter"/><axsl:param name="fileNameParameter"/><axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->
<axsl:output xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-select-full-path"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-get-full-path"><axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''"><axsl:value-of select="name()"/><axsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><axsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p_1"/>]</axsl:if></axsl:when><axsl:otherwise><axsl:text>*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text><axsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><axsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p_2"/>]</axsl:if></axsl:otherwise></axsl:choose></axsl:template><axsl:template match="@*" mode="schematron-get-full-path"><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/></axsl:when><axsl:otherwise><axsl:text>@*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text></axsl:otherwise></axsl:choose></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-2"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="preceding-sibling::*[name(.)=name(current())]"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<axsl:template match="/" mode="generate-id-from-path"/><axsl:template match="text()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></axsl:template><axsl:template match="comment()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></axsl:template><axsl:template match="processing-instruction()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></axsl:template><axsl:template match="@*" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.@', name())"/></axsl:template><axsl:template match="*" mode="generate-id-from-path" priority="-0.5"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:text>.</axsl:text><axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-3"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="parent::*"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-2 -->
<axsl:template match="/" mode="generate-id-2">U</axsl:template><axsl:template match="*" mode="generate-id-2" priority="2"><axsl:text>U</axsl:text><axsl:number level="multiple" count="*"/></axsl:template><axsl:template match="node()" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>n</axsl:text><axsl:number count="node()"/></axsl:template><axsl:template match="@*" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>_</axsl:text><axsl:value-of select="string-length(local-name(.))"/><axsl:text>_</axsl:text><axsl:value-of select="translate(name(),':','.')"/></axsl:template><!--Strip characters--><axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->
<axsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" title="" schemaVersion=""><axsl:comment><axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/></axsl:comment><svrl:active-pattern><axsl:attribute name="id">definedTypes</axsl:attribute><axsl:attribute name="name">definedTypes</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M0"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M1"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M2"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M3"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M4"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M5"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M6"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M9"/></svrl:schematron-output></axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN definedTypes-->


	<!--RULE -->
<axsl:template match="//Type[@name]" priority="1000" mode="M0"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//Type[@name]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="//Interface[@name=current()/@name]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="//Interface[@name=current()/@name]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text><axsl:text/><axsl:value-of select="@name"/><axsl:text/> type used in <axsl:text/><axsl:value-of select="ancestor::Interface[1]/@name"/><axsl:text/>.<axsl:text/><axsl:value-of select="parent::*[1]/@name"/><axsl:text/> declaration undefined.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/></axsl:template><axsl:template match="text()" priority="-1" mode="M0"/><axsl:template match="@*|node()" priority="-2" mode="M0"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name]" priority="1000" mode="M1"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@name='AllowAny' or @name='Callback' or @name='Constructor' or @name='NamedConstructor' or @name='NamespaceObject' or @name='NoInterfaceObject' or @name='OverrideBuiltins' or @name='PrototypeRoot' or @name='PutForwards' or @name='Replaceable' or @name='TreastNullAs' or @name='TreatUndefinedAs'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@name='AllowAny' or @name='Callback' or @name='Constructor' or @name='NamedConstructor' or @name='NamespaceObject' or @name='NoInterfaceObject' or @name='OverrideBuiltins' or @name='PrototypeRoot' or @name='PutForwards' or @name='Replaceable' or @name='TreastNullAs' or @name='TreatUndefinedAs'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute of <axsl:text/><axsl:value-of select="@name"/><axsl:text/> is unknown in WebIDL.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M1"/></axsl:template><axsl:template match="text()" priority="-1" mode="M1"/><axsl:template match="@*|node()" priority="-2" mode="M1"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M1"/></axsl:template>

<!--PATTERN -->
<axsl:template match="text()" priority="-1" mode="M2"/><axsl:template match="@*|node()" priority="-2" mode="M2"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M2"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='Callback']" priority="1000" mode="M3"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='Callback']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — <axsl:text/><axsl:value-of select="@name"/><axsl:text/> expected only on interfaces.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value) or @value='FunctionOnly' or @value='PropertyOnly'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value) or @value='FunctionOnly' or @value='PropertyOnly'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute Callback used on <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> uses an unknown argument <axsl:text/><axsl:value-of select="@value"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> has extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> but inherits from another interface (<axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance/Name/@name"/><axsl:text/>).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/ExtendedAttribute[@name='Constructor' or @name='NamedConstructor'])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/ExtendedAttribute[@name='Constructor' or @name='NamedConstructor'])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> has both extended attributes Callback and <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/ExtendedAttribute[@name='Constructor' or @name='NamedConstructor']/@name"/><axsl:text/>).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/Operation[@getter or @setter or @creator or @deleter or @caller or @stringifier])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/Operation[@getter or @setter or @creator or @deleter or @caller or @stringifier])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> has a Callback extended attribute, but offers a either  getters, setters, creators, deleters, caller or stringifier.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/Attribute[ExtendedAttributeList/ExtendedAttribute[@name='PutForwards' or @name='TreatNullAs' or @name='TreatUndefinedAs']])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/Attribute[ExtendedAttributeList/ExtendedAttribute[@name='PutForwards' or @name='TreatNullAs' or @name='TreatUndefinedAs']])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> has a Callback extended attribute, but exposes an attribute with a <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/Attribute/ExtendedAttributeList/ExtendedAttribute[@name='PutForwards' or @name='TreatNullAs' or @name='TreatUndefinedAs']/@name"/><axsl:text/> extended attribute.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value and parent::ExtendedAttributeList/parent::Interface/Attribute)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value and parent::ExtendedAttributeList/parent::Interface/Attribute)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> uses a Callback extended attribute with an argument, but exposes at least one attribute.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:variable name="firstOperationName" select="parent::ExtendedAttributeList/parent::Interface/Operation[1]/@name"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value) or (count(parent::ExtendedAttributeList/parent::Interface/Operation[@name!=$firstOperationName])=0 and $firstOperationName)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value) or (count(parent::ExtendedAttributeList/parent::Interface/Operation[@name!=$firstOperationName])=0 and $firstOperationName)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> uses a Callback extended attribute with an argument, but exposes zero or multiple operations with different identifiers.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/></axsl:template><axsl:template match="text()" priority="-1" mode="M3"/><axsl:template match="@*|node()" priority="-2" mode="M3"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='Constructor']" priority="1000" mode="M4"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='Constructor']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — <axsl:text/><axsl:value-of select="@name"/><axsl:text/> expected only on interfaces.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/></axsl:template><axsl:template match="text()" priority="-1" mode="M4"/><axsl:template match="@*|node()" priority="-2" mode="M4"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='NamedConstructor']" priority="1000" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='NamedConstructor']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — <axsl:text/><axsl:value-of select="@name"/><axsl:text/> expected only on interfaces.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Interface/ExtendedAttributeList/ExtendedAttribute[@name='NamedConstructor' and @value=current()/@value])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Interface/ExtendedAttributeList/ExtendedAttribute[@name='NamedConstructor' and @value=current()/@value])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NamedConstructor with identifier <axsl:text/><axsl:value-of select="@value"/><axsl:text/> in <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> interface clashes with NamedConstructor on interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/preceding::Interface[ExtendedAttributeList/ExtendedAttribute[@name='NamedConstructor' and @value=current()/@value]]/@name"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Interface[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Interface[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NamedConstructor with identifier <axsl:text/><axsl:value-of select="@value"/><axsl:text/> in <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> interface clashes with  interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/preceding::Interface[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value]/@name"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Exception[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/preceding::Exception[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NamedConstructor with identifier <axsl:text/><axsl:value-of select="@value"/><axsl:text/> in <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> interface clashes with exception interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/preceding::Exception[not(ExtendedAttributeList/ExtendedAttribute[@name='NoInterfaceObject'])][@name=current()/@value]/@name"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5"/></axsl:template><axsl:template match="text()" priority="-1" mode="M5"/><axsl:template match="@*|node()" priority="-2" mode="M5"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='NamespaceObject']" priority="1000" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='NamespaceObject']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Module"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Module"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NamespaceObject used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — NamespaceObject expected only on modules.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used with arguments on <axsl:text/><axsl:value-of select="concat(local-name(parent::ExtendedAttributeList/parent::*),' ',parent::ExtendedAttributeList/parent::*/@name)"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Module/ancestor::Module[ExtendedAttributeList/ExtendedAttribute[@name='NamespaceObject']])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Module/ancestor::Module[ExtendedAttributeList/ExtendedAttribute[@name='NamespaceObject']])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NamespaceObject used on module <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Module/@name"/><axsl:text/> that is included in module <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Module/ancestor::Module[ExtendedAttributeList/ExtendedAttribute[@name='NamespaceObject']]/@name"/><axsl:text/> that also has a NamespaceOjbect extended attribute.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/></axsl:template><axsl:template match="text()" priority="-1" mode="M6"/><axsl:template match="@*|node()" priority="-2" mode="M6"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='NoInterfaceObject']" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='NoInterfaceObject']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface or parent::ExtendedAttributeList/parent::Exception"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface or parent::ExtendedAttributeList/parent::Exception"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NoInterfaceObject used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — NoInterfaceObject expected only on interfaces and exceptions.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used with arguments on <axsl:text/><axsl:value-of select="concat(local-name(parent::ExtendedAttributeList/parent::*),' ',parent::ExtendedAttributeList/parent::*/@name)"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/ExtendedAttribute[@name='Constructor'])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/ExtendedAttribute[@name='Constructor'])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute NoInterfaceObject used in combination with extended attribute Constructor on interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::*/@name"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='OverrideBuiltins']" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='OverrideBuiltins']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — <axsl:text/><axsl:value-of select="@name"/><axsl:text/> expected only on interfaces.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used with arguments on <axsl:text/><axsl:value-of select="concat(local-name(parent::ExtendedAttributeList/parent::*),' ',parent::ExtendedAttributeList/parent::*/@name)"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface[Operation/@getter]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface[Operation/@getter]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute OverrideBuiltins used on interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> that does not have a name getter.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></axsl:template><axsl:template match="text()" priority="-1" mode="M8"/><axsl:template match="@*|node()" priority="-2" mode="M8"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></axsl:template>

<!--PATTERN -->


	<!--RULE -->
<axsl:template match="//ExtendedAttribute[@name='PrototypeRoot']" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ExtendedAttribute[@name='PrototypeRoot']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="parent::ExtendedAttributeList/parent::Interface"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="parent::ExtendedAttributeList/parent::Interface"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used on <axsl:text/><axsl:value-of select="local-name(parent::ExtendedAttributeList/parent::*)"/><axsl:text/> — <axsl:text/><axsl:value-of select="@name"/><axsl:text/> expected only on interfaces.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@value)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@value)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> used with arguments on <axsl:text/><axsl:value-of select="concat(local-name(parent::ExtendedAttributeList/parent::*),' ',parent::ExtendedAttributeList/parent::*/@name)"/><axsl:text/>.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>The interface <axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/@name"/><axsl:text/> has extended attribute <axsl:text/><axsl:value-of select="@name"/><axsl:text/> but inherits from another interface (<axsl:text/><axsl:value-of select="parent::ExtendedAttributeList/parent::Interface/InterfaceInheritance/Name/@name"/><axsl:text/>).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></axsl:template><axsl:template match="text()" priority="-1" mode="M9"/><axsl:template match="@*|node()" priority="-2" mode="M9"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></axsl:template></axsl:stylesheet>
