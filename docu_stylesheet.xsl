<xsl:stylesheet version="1.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:output doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
<xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN"/>
<!--version 0.9.$id -->


<!-- variables-->
<xsl:variable name="separator" select="', '"/>

<!-- create table header and tables -->
<xsl:template match="xsd:schema">
 <html>
 <head><title>AnIML Core-Schema Documentation</title></head>
 <body>
 <style type="text/css">
 TABLE { border: outset 1pt;
				border-collapse: seperate;
				border-spacing: 5pt }
 TD		{ border: inset 1pt }
 TD.special { border: inset 0pt }
 </style>
 <h3 style="text-align:center">Documentation</h3>
 <table>
 <thead>
  <tr>
   <td class="special"><b><xsl:text>&lt;</xsl:text>Element<xsl:text>&gt;</xsl:text>/Attributes</b></td>
   <td class="special"><b>Type</b></td>
   <td class="special"><b>Definition</b></td>
   <td class="special"><b>&lt;ImmediateChildElements&gt; or Allowed Values</b></td>
   <td class="special"><b>Modality</b></td>
   <td class="special"><b>Clarification</b></td>
   <td class="special"><b>Example</b></td>
  </tr>
 </thead>
 <tbody align="left">
<!-- call template for elements and sort the result by name-->
<xsl:apply-templates select="./xsd:element">
<xsl:sort select="@name"/>
</xsl:apply-templates>

 </tbody>
 </table>
 
 <xsl:call-template name="exampleList"/>
 
 <h3 style="text-align:left">Simple Types</h3>
 <table style="margin-left:auto;margin-right:auto" rules="all" border="4">
 <thead style="background-color:black;color:white">
  <tr>
   <td style="width:230">Type Name</td>
   <td style="width:230">Base Type</td>
   <td style="width:230">Definition</td>
  </tr>
  </thead>
  <tbody align="left">
   <!-- call template for 2nd table simpleTypes and sort by name-->
   <xsl:apply-templates mode="simpleTypes" select="./xsd:simpleType">
    <xsl:sort select="@name"/>
   </xsl:apply-templates>
  </tbody>
 </table>
  </body>
 </html>
</xsl:template>


<!-- template to fill table with element name, type, documentation, ImmediateChildElements, clarification & example -->
<xsl:template match="xsd:element">
<xsl:param name="example_id2"/>
 <tr valign="top" class="elements">
 <td><tt>
 <xsl:text>&lt;</xsl:text>
 <xsl:value-of select="@name"/>
 <xsl:text>&gt;</xsl:text>
 </tt></td>
 <td><tt>
 <xsl:value-of select="@type"/>
 </tt></td>
 <td>
 <xsl:if test="boolean(./xsd:annotation)">
 <p style="text-align:left">
 <xsl:value-of select="./xsd:annotation/xsd:documentation/text()"/>
 </p>
 </xsl:if>
 <xsl:if test="not(boolean(./xsd:annotation))">
 <pre>&#x20;</pre>
 </xsl:if>
 </td>
 <td>
 <!-- call template(s) for ImmediateChildElements handling-->
 <p style="text-align: left">
 
 <!-- handling of childelements-->
 <xsl:choose>
		<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:choice/xsd:element)">
			<xsl:text>{</xsl:text>
			<xsl:apply-templates mode="seqchoi_element_childs" select="//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:choice/xsd:element">
			<xsl:with-param name="separator" select="' | '"/>
			</xsl:apply-templates>
			<xsl:text>} </xsl:text>
			<xsl:call-template name="choice_handling">
				<xsl:with-param name="path" select="//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:choice"/>
			</xsl:call-template>
			<xsl:if test="boolean(//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:element)">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates mode="seqchoi_element_childs" select="//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:element">
				<xsl:with-param name="separator" select="', '"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:when>
		<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:element)">
			<xsl:apply-templates mode="seqchoi_element_childs" select="//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:element">
			<xsl:with-param name="separator" select="', '"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:choice/xsd:element)">
			<xsl:text>{</xsl:text>
			<xsl:apply-templates mode="seqchoi_element_childs" select="//xsd:complexType[@name=current()/@type]/xsd:choice/xsd:element">
			<xsl:with-param name="separator" select="' | '"/>
			</xsl:apply-templates>
			<xsl:text>} </xsl:text>
			<xsl:call-template name="choice_handling">
				<xsl:with-param name="path" select="//xsd:complexType[@name=current()/@type]/xsd:choice"/>
			</xsl:call-template>
		</xsl:when>
 </xsl:choose> 
 
 </p>
 <!-- test if matching complexType has childelement(s) -->
 <xsl:if test="not(boolean(//xsd:complexType[@name=current()/@type]/xsd:sequence/xsd:element))">
  <xsl:if test="not(boolean(//xsd:complexType[@name=current()/@type]/xsd:choice/xsd:element))">
 <pre>&#x20;</pre>
  </xsl:if>
 </xsl:if>
 </td>
 <td>
 <!-- empty space cause elements dont have modality -->
 <pre>&#x20;</pre>
 </td>
 <!-- fill clarification field if clarification exists - if not blank field -->
 <td>
 <xsl:if test="boolean(./xsd:annotation/xsd:documentation/xsd:clarification)">
 <xsl:value-of select="./xsd:annotation/xsd:documentation/xsd:clarification/text()"/>
 </xsl:if>
 <xsl:if test="not(boolean(./xsd:annotation/xsd:documentation/xsd:clarification))">
 <pre>&#x20;</pre>
 </xsl:if>
 </td>
 <td>
 <!-- add text like "see example 1" in appropriate column or leave blank field -->
 <xsl:choose>
		<xsl:when test="boolean(./xsd:annotation/xsd:documentation/xsd:example)">
			<a>
				<xsl:attribute name="href">#example<xsl:apply-templates mode="count" select="./xsd:annotation/xsd:documentation/xsd:example"/>
</xsl:attribute>
				<xsl:text>see example #</xsl:text>
				<xsl:apply-templates mode="count" select="./xsd:annotation/xsd:documentation/xsd:example"/>
			</a>
		</xsl:when>
		<xsl:when test="not(boolean(./xsd:annotation/xsd:documentation/xsd:example))">
			<pre>&#x20;</pre>
		</xsl:when>
	</xsl:choose>
 </td>
 </tr>
 
<!-- call template(s) for associated attribute(Group)(s) -->
<xsl:choose>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:attributeGroup)">
		<xsl:apply-templates mode="complex_attributeGroup" select="//xsd:complexType[@name=current()/@type]/xsd:attributeGroup"/>
	</xsl:when>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:complexContent/xsd:extension/xsd:attributeGroup)">
		<xsl:apply-templates mode="complex_attributeGroup" select="//xsd:complexType[@name=current()/@type]/xsd:complexContent/xsd:extension/xsd:attributeGroup"/>
	</xsl:when>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:simpleContent/xsd:extension/xsd:attributeGroup)">
		<xsl:apply-templates mode="complex_attributeGroup" select="//xsd:complexType[@name=current()/@type]/xsd:simpleContent/xsd:extension/xsd:attributeGroup"/>
	</xsl:when>
</xsl:choose> 
 
<xsl:choose>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:attribute)">
		<xsl:apply-templates mode="complex_attributes" select="//xsd:complexType[@name=current()/@type]/xsd:attribute"/>
	</xsl:when>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:complexContent/xsd:extension/xsd:attribute)">
		<xsl:apply-templates mode="complex_attributes" select="//xsd:complexType[@name=current()/@type]/xsd:complexContent/xsd:extension/xsd:attribute"/>
	</xsl:when>
	<xsl:when test="boolean(//xsd:complexType[@name=current()/@type]/xsd:simpleContent/xsd:extension/xsd:attribute)">
		<xsl:apply-templates mode="complex_attributes" select="//xsd:complexType[@name=current()/@type]/xsd:simpleContent/xsd:extension/xsd:attribute"/>
	</xsl:when>
</xsl:choose>

</xsl:template>

<!-- template to count and print example id in first and second table-->
<xsl:template name="count">
<xsl:number level="any" count="xsd:example" from="xsd:schema" format="1"/>
</xsl:template>

<!-- handles display of min and maxOccurs of xsd:choice-->
<xsl:template name="choice_handling">
<xsl:param name="path"/>
	<!--min and max occurs of choice element-->
			<xsl:text> (</xsl:text>
			<xsl:if test="boolean($path)">
			<xsl:value-of select="@minOccurs"/>
			</xsl:if>
			<xsl:if test="not(boolean($path/@minOccurs))">
			<xsl:text>1</xsl:text>
			</xsl:if>
			<!-- ... --> 
			<xsl:text>...</xsl:text>
			<!-- max occurs -->
			<xsl:if test="boolean($path/@maxOccurs)">
			<xsl:if test="$path/@maxOccurs = 'unbounded'">
			<xsl:text>inf</xsl:text>
			</xsl:if>
			<xsl:if test="$path/@maxOccurs != 'unbounded'">
			<xsl:value-of select="$path/@maxOccurs"/>
			</xsl:if>
			</xsl:if>
			<xsl:if test="not(boolean($path/@maxOccurs))">
			<xsl:text>1</xsl:text>
			</xsl:if>
			<xsl:text>)</xsl:text>
</xsl:template>

<!-- per xsd:element from complexType, output the following: <name> (<min>...<max>) If max = unbounded, output 'inf' instead. default output if not present is 1 for both minOccurs and maxOccurs. -->
<xsl:template mode="seqchoi_element_childs" match="xsd:element">
<xsl:param name="separator"/>
<tt>
<xsl:text>&lt;</xsl:text>
<xsl:value-of select="@ref" />
<xsl:text>&gt;</xsl:text>
</tt>
<xsl:text> (</xsl:text>
<!-- min occurs -->
<xsl:if test="boolean(@minOccurs)">
<xsl:value-of select="@minOccurs"/>
</xsl:if>
<xsl:if test="not(boolean(@minOccurs))">
<xsl:text>1</xsl:text>
</xsl:if>
<!-- ... --> 
<xsl:text>...</xsl:text>
<!-- max occurs -->
<xsl:if test="boolean(@maxOccurs)">
<xsl:if test="@maxOccurs = 'unbounded'">
<xsl:text>inf</xsl:text>
</xsl:if>
<xsl:if test="@maxOccurs != 'unbounded'">
<xsl:value-of select="@maxOccurs"/>
</xsl:if>
</xsl:if>
<xsl:if test="not(boolean(@maxOccurs))">
<xsl:text>1</xsl:text>
</xsl:if>
<xsl:text>)</xsl:text>
<!-- next one ? -->
<xsl:if test="position() != last()">
<xsl:value-of select="$separator"/>
</xsl:if>
</xsl:template>


<!-- template to handle attributeGroup(s) -->
<xsl:template name="multilevel_attrGroup" mode="complex_attributeGroup" match="xsd:attributeGroup">
<xsl:param name="attrGroup_name" select="current()/@ref"/>

<xsl:if test="boolean(//xsd:attributeGroup[@name=$attrGroup_name]/xsd:attributeGroup)">
 
  <xsl:call-template name="multilevel_attrGroup">
   <xsl:with-param name="attrGroup_name" select="//xsd:attributeGroup[@name=$attrGroup_name]/xsd:attributeGroup/@ref"/>
  </xsl:call-template>

</xsl:if>
<!-- calls attribute handle template -->
<xsl:apply-templates mode="complex_attributes" select="//xsd:attributeGroup[@name=$attrGroup_name]/xsd:attribute"/>
</xsl:template>


<!-- template to fill attribute-row with name, type, documentation, AllowedValues, modality & clarification -->
<xsl:template mode="complex_attributes" name="all_attributes" match="xsd:attribute">
<tr valign="top">
	<td><div style="margin-left:30px;"><tt><xsl:value-of select="@name"/></tt></div></td>
	<td><tt><xsl:value-of select="@type"/></tt></td>
	<td>
	<xsl:if test="boolean(./xsd:annotation)">
    <p style="text-align:left">
    <xsl:value-of select="./xsd:annotation/xsd:documentation/text()"/>
    </p>
    </xsl:if>
    <xsl:if test="not(boolean(./xsd:annotation))">
    <pre>&#x20;</pre>
    </xsl:if>
    </td>
    <!-- fill with allowed values or blank  -->
	<td class="allowedValues">
	<xsl:call-template name="allowedValue_handling"/>
	</td>
	<!-- modality -->
	<td><tt><xsl:value-of select="@use"/></tt></td>
	<td>
    <xsl:if test="boolean(./xsd:annotation/xsd:documentation/xsd:clarification)">
    <p style="text-align:left">
    <xsl:value-of select="./xsd:annotation/xsd:documentation/xsd:clarification/text()"/>
    </p>
    </xsl:if>
    <xsl:if test="not(boolean(./xsd:annotation/xsd:documentation/xsd:clarification))">
    <pre>&#x20;</pre>
    </xsl:if>
    </td>
    <td>
	<pre>&#x20;</pre>
	</td>
</tr>
</xsl:template>

<!-- template to handle allowed value output -->
<xsl:template name="allowedValue_handling">
 <!-- if matching simpleType has at least a restriction child call simpleType template -->
 <xsl:if test="boolean(//xsd:simpleType[@name=current()/@type]/xsd:restriction)">
  <xsl:apply-templates select="//xsd:simpleType[@name=current()/@type]"/>
 </xsl:if>
 <!-- create blank field if matching simpleType has no restriction child -->
 <xsl:if test="not(boolean(//xsd:simpleType[@name=current()/@type]/xsd:restriction))">
  <pre>&#x20;</pre>
 </xsl:if>
</xsl:template>

<!-- template to create allowed value output -->
<xsl:template match="xsd:simpleType">
 <!-- if simpleType has allowed values, output like this: valuename: documentation 2xlinebreaks valuename: etc.-->
 <xsl:if test="boolean(./xsd:restriction/xsd:enumeration)">
  <xsl:for-each select="./xsd:restriction/xsd:enumeration">
   <p style="text-align:left">
    <span style="font-weight:100">
     <tt><xsl:value-of select="@value"/></tt>
    </span>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="./xsd:annotation/xsd:documentation/text()"/>
    <xsl:if test="position() != last()">
     <br/>
     <br/>
    </xsl:if>
   </p>
  </xsl:for-each>
 </xsl:if>
 <!-- if simpleType does not have allowed values, output blank -->
 <xsl:if test="not(boolean(./xsd:restriction/xsd:enumeration))">
  <pre>&#x20;</pre>
 </xsl:if>
</xsl:template>

<!-- template for simpleTypes table, fill with name, base type and documentation-->
<xsl:template mode="simpleTypes" match="xsd:simpleType">
 <tr>
		<td><xsl:value-of select="@name"/></td>
		<td>
		 <xsl:if test="boolean(./xsd:restriction/@base)">
		  <xsl:value-of select="./xsd:restriction/@base"/>
		 </xsl:if>
		 <xsl:if test="not(boolean(./xsd:restriction/@base))">
		  <pre>&#x20;</pre>
		 </xsl:if>
		</td>
		<td><xsl:value-of select="./xsd:annotation/xsd:documentation/text()"/></td>
 </tr>
</xsl:template>

<xsl:template name="exampleList">
<h3 style="text-align:left">Examples for Elements</h3>
<xsl:apply-templates select="//xsd:example"/>
</xsl:template>

<!-- template fills example list with corresponding entries-->
<xsl:template match="xsd:example">

<h4 style="text-align:left"><a><xsl:attribute name="name">example<xsl:call-template name="count"/></xsl:attribute></a>Example #<xsl:call-template name="count"/></h4>

<pre><xsl:value-of select="./text()"/></pre>

<xsl:value-of select="../xsd:exampletext/text()"/>

</xsl:template>

<xsl:template mode="count" match="xsd:example">
	<xsl:call-template name="count"/>
</xsl:template>

</xsl:stylesheet>
