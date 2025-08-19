<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:strat="urn:ISO:std:iso:17469:tech:xsd:PerformancePlanOrReport"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:p="http://www.stratml.net/PerformancePlanOrReport"
                xmlns:x="http://www.w3.org/2001/XMLSchema-instance"
                exclude-result-prefixes="p x strat"
                version="1.0">

		<!-- Updated August,2024: Rekha Thakur made the following enhancements: 1) commented out the code responsible for displaying the document type.
		2)Removed & modified the code responsible for displaying the Stakeholder Type.
		3) Removed the code responsible for generating the secondary TOC between Goal and Objective elements.
        4)  Modify the structure of table of content in the left side of screen.
		5)Added XSLT template to replace conversion of charcters with breaks and bullets.
		6)Modified XSLT template to always include <UnitOfMeasurement><Name> as a column header.
		7)Modified XSLT to include logic for checking and displaying an organization logo image.
		8) Updated XSLT to enhance table formatting.
		9) Added conditional logic to the XSLT to check for content before displaying the prompt.
		10) Modified XSLT to use HTML5 details and summary elements for collapsible sections.
		11)Updated XSLT to transform URLs into clickable hyperlinks.
		12)Updated XSLT to transform email addresses into mailto links.
		-->

    <!-- Updated 2018-11-28 - Ibrahim Shah made the following enhancements: 1) Corrected the 
    	presentation of the <UnitOfMeasurement> and <Descriptor> columns in the 
    	<PerformanceIndicator>s table.  The columns now display only if those elements are 
    	populated.  2) Activated the <Relationship> hyperlinks and made them open in new 
    	browser tabs. 3) Enabled mailto comment links on <Goal>s and <Objective>s.  The 
    	mailto link capabilities will be commented out in the base stylesheet but available 
    	for use when desired. -->

	<!-- Updated 2016-05-08 - changed general html output from table to div 
		construction (improved readability) - some minor changes to styles / representation 
		Updated 2016-04-11 - moved representation of <Relationship> elements from 
		above to below the indicators table - modified logic for additional <Descriptor> 
		column - some minor changes to styles / representation All changes are marked 
		with '(dhh)' Detlef Horst Heyn detlef.heyn@googlemail.com -->

	<!-- Updated 2016-04-10 - Added logic to output Descriptor content in the 
		INDICATORS table Marijan (Mario) Madunic mario.madunic@nsxml.com North Shore 
		XML Consulting BC, Canada -->

	<!-- On October 10, 2015, Colin Mackenzie (http://mackenziesolutions.co.uk) 
		changed the orientation of the MeasurementInstance table so that the Type, 
		Startdate, EdnDate, and Description are shown as columns -->

	<!-- On September 30, 2015, Owen Ambur changed the prompt on the Role Name 
		element from "As" to "Role:" on line 466. -->
	
	<!-- Copyright (C) 2015 Joe Carmel Changes have been made to the previous 
		work to make the stylesheet compatible with the StratML Part 1 ISO standard. 
		Copyright (C) 2012 Joe Carmel Changes have been made to the previous work 
		with the use of a table in order to place the table of contents at the top 
		of the display. The font has also been changed to Times Roman. This stylesheet 
		started from a StratML Part1 display stylesheets developed by Crane Softwrights 
		Ltd. Parts an design used from the Crane Softwrights Ltd. Redistribution 
		and use in source and binary forms, with or without modification, are permitted 
		provided that the following conditions are met: - Redistributions of source 
		code must retain the above copyright notices, this list of conditions and 
		the following disclaimer. - Redistributions in binary form must reproduce 
		the above copyright notice, this list of conditions and the following disclaimer 
		in the documentation and/or other materials provided with the distribution. 
		- The name of the author may not be used to endorse or promote products derived 
		from this software without specific prior written permission. THIS SOFTWARE 
		IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, 
		INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
		AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
		AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
		OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
		GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
		HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
		LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY 
		OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
		DAMAGE. -->

	<!-- Copyright (C) 2010 01 COMMUNICATIONS INC. http://stratml.DNAOS.com/stratml.html 
		This stylesheet started from a StratML Part1 display stylesheets developed 
		by Crane Softwrights Ltd. Parts an design used from the Crane Softwrights 
		Ltd. StratML Part1 stylesheets are Copyright (C) - Crane Softwrights Ltd. 
		- http://www.CraneSoftwrights.com/links/res-stratml.htm Redistribution and 
		use in source and binary forms, with or without modification, are permitted 
		provided that the following conditions are met: - Redistributions of source 
		code must retain the above copyright notices, this list of conditions and 
		the following disclaimer. - Redistributions in binary form must reproduce 
		the above copyright notice, this list of conditions and the following disclaimer 
		in the documentation and/or other materials provided with the distribution. 
		- The name of the author may not be used to endorse or promote products derived 
		from this software without specific prior written permission. THIS SOFTWARE 
		IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, 
		INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
		AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
		AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
		OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
		GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
		HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
		LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY 
		OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
		DAMAGE. Note: for your reference, the above is the "Modified BSD license", 
		this text was obtained 2002-12-16 at http://www.xfree86.org/3.3.6/COPYRIGHT2.html#5 -->

	<!-- January 2010: This script has been modified to accommodate the updated 
		StratML schema. http://xml.gov/stratml/references/PerformancePlanOrReport.xsd 
		The primary changes involved changing xpath locations, adding a couple of 
		elements (Name, Description, OtherInformation), and changing the linking 
		ids to use the Identifiers provided within the StratML file. Redistribution 
		and use in source and binary forms, with or without modification, are permitted 
		per the copyright provided above. Joe Carmel -->

	<!-- October 2010: StratML Part2 stylesheets where created starting from 
		the StratML Part1 versions, with important fixes,changes, and additions. 
		The StratML document display stylesheet supports display of both StratML 
		Part1 and Part2 specifications, including Web browser support. The easiest 
		way to use it is probably to ensure that the first two lines of all StratML 
		documents are as follows: .................................................................................... 
		<?xml version="1.0" encoding="UTF-8"?> <?xml-stylesheet href="http://stratml.DNAOS.com/stratml.xsl" 
		type="text/xsl" ?> .................................................................................... 
		More information is available from stratml@DNAOS.com, and all questions, 
		comments, and suggestions should also be sent to the same email address (stratml@DNAOS.com). 
		A copy of this XSLT-1 stylesheet is maintained and available along with corresponding 
		StratML Part1 and Part2 Schema, as well as some documentation are maintained 
		and accessible at the corresponding respective URLs: - XSLT-1 Browser presentation 
		stylesheet: http://stratml.DNAOS.com/stratml.xsl - StratML Part1 XML Schema: 
		http://stratml.DNAOS.com/stratml1.xsd - StratML Part2 XML Schema: http://stratml.DNAOS.com/stratml2.xsd 
		- StratML Stylesheet documentation: http://stratml.DNAOS.com/stratml.html 
		Note that the portal sub-site http://stratml.dnaos.com/, refers to the same 
		directory and has been provided for convenience. An XSLT-2 version of the 
		StratML (x)html presentation stylesheet has been integrated into 01 COMMUNICATIONS' 
		DNAOS technology (http://www.DNAOS.com/) along with StratML content and document 
		management support. More information on that version, as well as the associated 
		DNAOS technologies and services are available at stratml@DNAOS.com. Andre 
		Cusson 01 COMMUNICATIONS INC. acusson@01COMMUNICATIONS.com -->


<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

  
			
<!-- Template to apply formatting to the "p" element -->
	<xsl:template match="p">
		<p style="font-family: Arial; font-size: 12pt; margin-bottom: 10pt;">
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<!-- Template to apply formatting to the "body" element -->
	<xsl:template match="body">
		<body style="font-family: Arial; font-size: 12pt; margin-left: 20pt; margin-right: 20pt;">
			<xsl:apply-templates />
		</body>
	</xsl:template>


<xsl:output encoding="UTF-8" indent="yes" method="html" />

	<xsl:template match="/">
		<xsl:variable name="doc-type">
			<xsl:choose>
				<xsl:when test="string(*/@Type)">
					<xsl:value-of select="*/@Type" />
				</xsl:when>
				<xsl:when test="local-name(*) = 'PerformancePlanOrReport'">
					<xsl:value-of select="'PerformancePlanOrReport'" />
				</xsl:when>
				<xsl:when test="local-name(*) = 'StrategicPlan'">
					<xsl:value-of select="'StrategicPlan'" />
				</xsl:when>
				<xsl:otherwise>
					<!-- <xsl:message terminate="yes">
 Expected a "PerformancePlanOrReport" or "StrategicPlan" document
 element, but detected:
 "
                        <xsl:value-of select="concat(namespace-uri(*), ':', local-name(*))" />
 "
                    </xsl:message> -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="plan" select="*" />
		<html>
			<xsl:text>
			</xsl:text>
			<xsl:comment>
 End result created using
 http://stratml.us/carmel/iso/part2/part2stratml_CommentsTEST.xsl
			</xsl:comment>
			<xsl:text>
			</xsl:text>
			<xsl:comment>
 See: http://stratml.us
			</xsl:comment>
			<xsl:text>
			</xsl:text>
			<head>
				<title>
					<xsl:value-of select="concat($doc-type, ' - Source: ', //*[local-name(.) = 'Source'])" />
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<!--these styles are assumed by the stylesheet; can be overridden -->
				<style type="text/css">
 /*(dhh) changed from table to div construction*/
 html{background-color:#EFEFFF;overflow:hidden;}
 .toc
 {    float: left;
    width: 20%;
    height: 100vh;
    overflow: scroll;
    font-size: 80%;}
	 .toctitle{
		text-align: center;
    font-size: 16pt;
    color: green;
    font-weight: bold;
	}
 .content
 {padding:15pt;background-color:#FFFFFF;float:left;width:76%;height:100vh;overflow:scroll;}
 /*Global*/
 pre,samp {font-family:Times-Roman;font-size:80%}
 /*Heading information*/
 /*(dhh) changed from Times-Roman to Tahoma,
 Arial*/
 .doc {font-family:Tahoma, Arial; font-size:14pt}
 .docheading
 {font-size:20pt;text-align:center;font-weight:bold}
 .docsubheading
 {font-size:15pt;text-align:center;color:green}
 .sourceheading {}
 .herald {font-family:sans-serif;font-size:12pt;font-weight:bold}
 .subtitle {text-align:left;
 font-size:14pt;color:black;font-weight:bold}
 .orgstaketitle
 {text-align:left;
 font-size:14pt;color:black;font-weight:bold}
 .orgstakeholder
 {margin-left:0in;font-family:Tahoma, Arial !important;font-size:12pt;}
 .toggle-input {
    display: none;
}
.indent {
    padding-left: 50px; /* Adjust the value as needed */
    display: inline; /* Ensures the bullet and text stay on the same line */
}
 .objectives-container {
    display: none;
}

.toggle-input {
    display: none;
}

.toggle-input:checked ~ .objectives-container {
    display: block;
}

.goal-title {
    cursor: pointer;
    margin-left: 25px;
}

.goal-title::before {
    content: " ?";
    color: #048;
    text-transform: uppercase;
}

.toggle-input:checked + .goal-title::before {
    content: " ?";
}

.expand-all-toggle {
    display: none;
}
.expand-all-button {
    display: inline-block;
    margin-bottom: 10px;
    padding: 5px 10px;
    background-color: #f0f0f0;
    color: #333;
    text-decoration: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
    position: relative;
    left: 50%;
    transform: translateX(-50%);
}

.expand-all-button:hover {
    background-color: #e0e0e0;
}

.expand-all-toggle:not(:checked) ~ .expand-all-button .collapse-text {
    display: none;
}

.expand-all-toggle:checked ~ .expand-all-button .expand-text {
    display: none;
}

.expand-all-toggle:checked ~ .goal-container .objectives-container {
    display: block;
}

.expand-all-toggle:checked ~ .goal-container .goal-title::before {
    content: " ?";
}

.toctitle {
    font-weight: bold;
    margin-top: 20px;
}

.tocentry {
    margin-left: 20px;
}

.tocsubentry {
    margin-left: 40px;
}


 .placeholder {
    display: inline-block;
    width: 30px; /* Same width as the images */
    height: 30px; /* Same height as the images */
    background-color: #f0f0f0; /* Light grey background to show the area */
    text-align: center;
    line-height: 30px; /* Center the text vertically */
    font-size: 12px;
    color: #999; /* Grey text color */
    border: 1px solid #ccc; /* Optional: Add a border for visibility */
}

 .tocsubtitle
 {text-align:left;
 font-size:14pt;color:black;font-weight:bold}
 .tocentry
   {  margin-left: 0in;
    text-indent: 0.25in;
    margin-top: 0pt;
    margin-bottom: 0pt;}
 .tocsubentry
 {
    margin-left: 0.25in;
    text-indent: 0.25in;
    margin-top: 0pt;
    margin-bottom: 0pt;
 }
 /*Body*/
 .vmvhead {font-size:15pt;font-weight:bold}
 .vmvdesc
 {margin-left:.25in}
 .goalsep
 {display:visible;margin-top:16pt;margin-bottom:0pt}
 .goalhead
 {text-align:center;font-size:16pt;color:green;font-weight:bold;margin-top:8pt}
 .goaldesc {text-align:center;margin-left:25%;margin-right:25%}
 .goalstaketitle {margin-left:0.5in;text-align:left;
 font-size:14pt;color:black;font-weight:bold}
 .goalstakeholder
 {margin-left:1in;text-align:left;margin-left:5%;margin-right:5%}
 .objhead {font-size:15pt}
 .objstaketitle {margin-left:0.5in;
 text-align:left;
 font-size:12pt;color:black;font-weight:bold}
 .objstakeholder {margin-left:1in}
 /*(dhh) added margin-bottom*/
 .infotitle
 {margin-left:0.5in;text-indent:.25in;margin-top:0pt;margin-bottom:.25in;font-weight:bold;}

 .para-c { margin-left:.25in; margin-right:.25in; text-align:
 center; }

 /*Meta*/
 .meta
 {font-size:8pt;text-align:right;margin-top:0pt;margin-bottom:0pt}
 .datatable {
 border-collapse: collapse;
 margin-left: 10px;
 margin-right: 10px;
 margin-top: 10px;
 margin-botttom: 10px; }
 .datatable,
 .datatable thead th,
 .datatable tbody th,
 .datatable tbody
 td {
 border: 0px solid black;
 padding-left: 10px;
 padding-right: 10px;
 }
 .double-break {
    margin-top: 1em;
	
}

.single-break {
    margin-top: 0.5em;
}
 a:link { text-decoration:none; color: #06D; }
 a:visited { color:
 #048D; }
 a:hover { color: black; }
				</style>
				<xsl:text>
				</xsl:text>
				<xsl:comment>
 End-user styles override built-in styles.
				</xsl:comment>
				<xsl:text>
				</xsl:text>
				<!-- Is this external stylesheet required? <link type="text/css" rel="stylesheet" href="http://stratml.hyperbase.com/stratml.css"/> -->
				
				<!-- Chart.js library for line charts -->
				<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
				
				<!-- Additional styles for charts -->
				<style type="text/css">
					.chart-container {
						margin: 20px 0;
						padding: 15px;
						border: 1px solid #ddd;
						border-radius: 5px;
						background-color: #f9f9f9;
					}
					.chart-title {
						font-size: 16pt;
						font-weight: bold;
						color: #333;
						margin-bottom: 10px;
						text-align: center;
					}
					.chart-canvas {
						width: 100% !important;
						height: 400px !important;
					}
					.chart-toggle {
						margin-bottom: 10px;
						text-align: center;
					}
					.chart-toggle button {
						background-color: #4CAF50;
						color: white;
						padding: 8px 16px;
						border: none;
						border-radius: 4px;
						cursor: pointer;
						margin: 0 5px;
					}
					.chart-toggle button:hover {
						background-color: #45a049;
					}
					.chart-toggle button.active {
						background-color: #2196F3;
					}
				</style>
			</head>
		
			<body class="doc">
				<!--present all of the title information -->
				<!-- (dhh) adding div construction -->
				<div class="toc" width="25%" valign="top">
					<xsl:call-template name="toc">
						<xsl:with-param name="tocid"
							select="generate-id(//*[local-name(.) = 'StrategicPlanCore'])" />
					</xsl:call-template>
				</div>
				<!-- (dhh) adding div construction -->
				<div class="content" style="padding:10pt;">
				
	<!-- Comment Document type -->
					<!-- <p class="docheading">
						<xsl:value-of select="$doc-type" />
					</p> -->
					<p class="docsubheading">
						<xsl:value-of select="$plan/*[local-name(.) = 'Name']" />
					</p>
					<p class="para">
    <xsl:variable name="descText">
        <xsl:value-of select="normalize-space($plan/*[local-name(.) = 'Description'])"/>
    </xsl:variable>
    <xsl:call-template name="process-text">
        <xsl:with-param name="text" select="$descText"/>
    </xsl:call-template>
</p>
					   <p class="other-information">
                    
                      
                        <xsl:apply-templates select="strat:PerformancePlanOrReport/strat:OtherInformation" mode="transform"/>
                    </p>
                    
					<xsl:for-each
						select="$plan//*[local-name(.) = 'AdministrativeInformation']">
						<xsl:variable name="anchor">
							<xsl:call-template name="getid" />
						</xsl:variable>
						<p class="docsubheading" id="{$anchor}">
							<xsl:text>Source: </xsl:text>
							<br />
							<a href="{*[local-name(.) = 'Source']}" target="_blank">
								<samp class="sourceheading">
									<xsl:value-of select="*[local-name(.) = 'Source']" />
								</samp>
							</a>
						</p>
						<p class="docsubheading">
							<xsl:text>Start: </xsl:text>
							<xsl:value-of select="*[local-name(.) = 'StartDate']" />
							<xsl:text> End: </xsl:text>
							<xsl:value-of select="*[local-name(.) = 'EndDate']" />
							<xsl:text> Publication Date: </xsl:text>
							<xsl:value-of select="*[local-name(.) = 'PublicationDate']" />
						</p>
					</xsl:for-each>
					<table summary="submitter and organization information"
						class="doc" align="center">
						<tr valign="top">
							<td>
								<xsl:variable name="submitter"
									select="$plan//*[local-name(.) = 'Submitter']" />
								<xsl:if test="normalize-space($submitter)">
									<p class="subtitle">Submitter:</p>
									<xsl:apply-templates select="$submitter" />
								</xsl:if>
							</td>
							<td>
								<xsl:variable name="org"
									select="$plan/*[local-name(.) = 'StrategicPlanCore']/*[local-name(.) = 'Organization']" />
								<xsl:if test="normalize-space($org)">
									<p class="subtitle">Organization:</p>
									<xsl:apply-templates select="$org" />
								</xsl:if>
							</td>
						</tr>
					</table>
					<!-- <xsl:call-template name="toc"><xsl:with-param name="tocid" select="generate-id(//*[local-name(.) 
						= 'StrategicPlanCore'])"/></xsl:call-template> -->
					<xsl:apply-templates
						select="//*[contains('Vision Mission', local-name(.))]" />
					<xsl:if test="//*[local-name(.) = 'Value' and normalize-space(.)]">
						<p class="vmvhead" id="values_">
							<xsl:text>Value</xsl:text>
							<xsl:if
								test="count(//*[local-name(.) = 'Value' and normalize-space(.)])&gt;1">
								<xsl:text>s</xsl:text>
							</xsl:if>
						</p>
						<xsl:for-each select="//*[local-name(.) = 'Value']">
							<p class="vmvdesc" id="{generate-id()}">
								<xsl:call-template name="name-desc" />
							</p>
						</xsl:for-each>
					</xsl:if>
					<xsl:apply-templates select="//*[local-name(.) = 'Goal']" />

					<!--meta data -->
					<p class="meta">
						<a href="http://mackenziesolutions.co.uk" target="_blank">
							<xsl:text>http://mackenziesolutions.co.uk</xsl:text>
						</a>
						<br />
						<xsl:text>(Stylesheet revision: 2015-10-06)</xsl:text>
						<br />
					</p>
					<p class="meta">
						<a href="http://xmldatasets.net/XF2/stratmlisoxform.xml" target="_blank">
							<xsl:text>XMLDatasets.net</xsl:text>
						</a>
						<br />
						<xsl:text>(Stylesheet revision: 2012-09-20 and 2015-05-01)</xsl:text>
						<br />
					</p>

					<p class="meta">
						<a href="http://stratml.DNAOS.com/stratml.html" target="_blank">
							<xsl:text>01 COMMUNICATIONS INC.</xsl:text>
							<br />
							<samp>http://stratml.DNAOS.com/stratml.html</samp>
						</a>
					</p>
					<p class="meta">
						<xsl:text>Stylesheet revision (main): 2010-10-20T20:10:10.20Z</xsl:text>
						<br />
						<xsl:text>Stylesheet revision (base): 2010-10-20T20:10:10.20Z</xsl:text>
					</p>
					<p class="meta">
						<a href="http://xmldatasets.net/XF2/stratmlxform3.xml" target="_blank">
							<xsl:text>XMLDatasets.net</xsl:text>
							<br />
							<samp>http://www.xmldatasets.net/StratML</samp>
						</a>
					</p>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="ReferentNotID">
		<xsl:choose>
			<xsl:when test="normalize-space(*[local-name(.) = 'Identifier'])">
				<xsl:value-of select="*[local-name(.) = 'Identifier']" />
				<!-- <xsl:text>hiShah</xsl:text> -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="generate-id(.)" />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="getid">
		<xsl:choose>
			<xsl:when test="normalize-space(*[local-name(.) = 'Identifier'])">
				<xsl:value-of select="*[local-name(.) = 'Identifier']" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="generate-id(.)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.) = 'Submitter']">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<blockquote id="{$anchor}">
			<xsl:for-each select="*[local-name(.) = 'GivenName' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Given name: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:for-each select="*[local-name(.) = 'Surname' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Surname: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:for-each
				select="*[local-name(.) = 'PhoneNumber' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Phone Number: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:for-each
				select="*[local-name(.) = 'EmailAddress' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Email Address: </xsl:text>
					</b>
					<a href="mailto:{.}">
						<samp>
							<xsl:value-of select="." />
						</samp>
					</a>
				</p>
			</xsl:for-each>
		</blockquote>
	</xsl:template>


	 <!-- <xsl:template match="Description">
    <p class="para"> 
      
       <xsl:call-template name="ProcessText">
        <xsl:with-param name="text" select="."/>
      </xsl:call-template>
    </p>
  </xsl:template> -->

 
	<xsl:template match="*[local-name(.) = 'Organization']">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<blockquote id="{$anchor}" style="font-family:  sans-serif !important ;font-size:12pt;">
	
			<xsl:for-each select="*[local-name(.) = 'Name' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Name: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:for-each select="*[local-name(.) = 'Acronym' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Acronym: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:for-each
				select="*[local-name(.) = 'Description' and normalize-space(.)]">
				<p>
					<b class="herald">
						<xsl:text>Description: </xsl:text>
					</b>
					<xsl:value-of select="." />
				</p>
			</xsl:for-each>
			<xsl:call-template name="stakeholder">
				<xsl:with-param name="level" select="'org'" />
			</xsl:call-template>
		</blockquote>
	</xsl:template>

<xsl:template name="toc">
    <xsl:param name="tocid" select="'toc'" />
    
   
    <xsl:for-each select="*/*[local-name(.) = 'StrategicPlanCore']">
        <p class="toctitle" id="{$tocid}">
            <br />
            <xsl:text>Table of Contents</xsl:text>
            <hr width="60%" />
        </p>
         <!-- Add this checkbox and label at the top of your table of contents -->
    <input type="checkbox" id="expand-all" class="expand-all-toggle" />
    <label for="expand-all" class="expand-all-button">
        <span class="expand-text">Expand All</span>
        <span class="collapse-text">Collapse All</span>
    </label>
    
        <!-- Vision Section -->
        <xsl:for-each select="*[local-name(.) = 'Vision']">
            <p class="tocentry">
                <xsl:variable name="anchor">
                    <xsl:call-template name="getid" />
                </xsl:variable>
                <a href="#{$anchor}">Vision</a>
            </p>
        </xsl:for-each>
        
        <!-- Mission Section -->
        <xsl:for-each select="*[local-name(.) = 'Mission']">
            <p class="tocentry">
                <xsl:variable name="anchor1">
                    <xsl:call-template name="getid" />
                </xsl:variable>
                <a href="#{$anchor1}">Mission</a>
            </p>
        </xsl:for-each>
        
        <!-- Values Section -->
        <xsl:if test="*[local-name(.) = 'Value']">
            <p class="tocentry">
                <a href="#values_">
                    <xsl:text>Value</xsl:text>
                    <xsl:if test="count(*[local-name(.) = 'Value']) > 1">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </a>
            </p>
            <xsl:for-each select="*[local-name(.) = 'Value']">
                <p class="tocsubentry">
                    <a href="#{generate-id(.)}">
                        <xsl:apply-templates select="*[local-name(.) = 'Name']" />
                    </a>
                </p>
            </xsl:for-each>
        </xsl:if>
        
        <!-- Goals and Objectives Section -->
        <xsl:for-each select="*[local-name(.) = 'Goal']">
            <xsl:variable name="goalID" select="generate-id()" />
            <div class="goal-container">
                <input type="checkbox" id="toggle-{$goalID}" class="toggle-input" />
                <label for="toggle-{$goalID}" class="goal-title">
                    <xsl:variable name="anchor2">
                        <xsl:call-template name="ReferentNotID" />
                    </xsl:variable>
                    <a href="#{string($anchor2)}">
                        <xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
                        <xsl:if test="*[local-name(.) = 'SequenceIndicator']">
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:apply-templates select="*[local-name(.) = 'Name']" />
                    </a>
                </label>
                
                <div class="objectives-container">
                    <xsl:for-each select="*[local-name(.) = 'Objective']">
                        <p class="tocsubentry">
                            <xsl:variable name="anchor3">
                                <xsl:call-template name="getid" />
                            </xsl:variable>
                            <a href="#{$anchor3}">
                                <xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
                                <xsl:if test="*[local-name(.) = 'SequenceIndicator']">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:apply-templates select="*[local-name(.) = 'Name']" />
                            </a>
                        </p>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:for-each>
    </xsl:for-each>
    <br />
    <hr width="60%" />
</xsl:template>






<xsl:template match="*[local-name(.) = 'SequenceIndicator' and normalize-space(.)]">
    <xsl:value-of select="concat(., ': ')" />
</xsl:template>
<xsl:template match="strat:OtherInformation" mode="transform">
    <xsl:call-template name="replace-special-characters">
        <xsl:with-param name="text" select="normalize-space(.)"/>
    </xsl:call-template>
</xsl:template>

<!-- Template to replace special characters -->
<xsl:template name="replace-special-characters">
    <xsl:param name="text"/>
    <xsl:choose>
        <xsl:when test="starts-with($text, '^^ *')">
            <div class="double-break" style="margin-left: 20px;"></div>
            <span class="indent">&#8226; </span>
            <xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="substring-after($text, '^^ *')" />
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="starts-with($text, '^ *')">
            <div class="single-break"></div>
             <span class="indent">&#8226; </span>
            <xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="substring-after($text, '^ *')" />
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="starts-with($text, '^^')">
            <div class="double-break"></div>
            <xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="substring-after($text, '^^')" />
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="starts-with($text, '*')">
            <div class="single-break"></div>
             <span class="indent">&#8226; </span>
            <xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="substring-after($text, '*')" />
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="starts-with($text, '^')">
            <div class="single-break"></div>
            <xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="substring-after($text, '^')" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="next-special" select="substring-before(concat($text, '^'), '^')"/>
            <xsl:value-of select="$next-special" />
            <xsl:if test="$next-special != $text">
                <xsl:call-template name="replace-special-characters">
                    <xsl:with-param name="text" select="substring-after($text, $next-special)" />
                </xsl:call-template>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

	<xsl:template match="*[local-name(.) = 'Goal']">
		<hr class="goalsep" />
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<p class="goalhead" id="{$anchor}">
			<a href="#{$anchor}">
				<xsl:if
					test="not(contains(*[local-name(.) = 'SequenceIndicator'], 'Goal'))">
					<xsl:text>Goal </xsl:text>
				</xsl:if>
				<xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
				<xsl:text>   </xsl:text>
			</a>
			<xsl:for-each select="*[local-name(.) = 'Name' and normalize-space(.)]">
				<xsl:apply-templates select="." />
				<xsl:variable name="NameValueVariable">
					<xsl:apply-templates select="." />
				</xsl:variable>
				<br />
				<a>
<!--					<xsl:attribute name="href">
				    	<xsl:text>mailto: </xsl:text>
					<xsl:for-each select="//*[local-name(.) = 'EmailAddress']">
						<xsl:value-of select="." />
						<xsl:text>?Subject=</xsl:text>
						<xsl:value-of select='$NameValueVariable' />
					</xsl:for-each>
				    </xsl:attribute>
					<sup>
						<xsl:text>Click to Comment on This Goal "</xsl:text>
						<xsl:value-of select='$NameValueVariable' />
						<xsl:text> "</xsl:text>
					</sup>
				</a>

				<br />
--></a>
			</xsl:for-each>
		</p>
		<xsl:for-each
			select="*[local-name(.) = 'Description' and normalize-space(.)]">
			<p class="goaldesc">
				<xsl:apply-templates />
			</p>
		</xsl:for-each>
		<xsl:call-template name="stakeholder">
			<xsl:with-param name="level" select="'goal'" />
		</xsl:call-template>
		<!-- <p class="infotitle">Objective(s):</p>
		<xsl:for-each select="*[local-name(.) = 'Objective' and normalize-space(.)]">
			<p class="tocsubentry">
				<xsl:variable name="anchor2">
					<xsl:call-template name="getid" />
				</xsl:variable>
				<a href="#{$anchor2}">
					<xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
					<xsl:text>  </xsl:text>
					<xsl:apply-templates select="*[local-name(.) = 'Name']" />
					<br />
				</a>
			</p> -->
		<!-- </xsl:for-each> -->
		<br />
		<xsl:apply-templates select="strat:OtherInformation" mode="transform" />
		<xsl:apply-templates select="*[contains('Objective  ', local-name(.))]" />
	</xsl:template>

	<xsl:template name="stakeholder">
		<xsl:param name="level" select="'org'" />
		<xsl:if test="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
			<p class="{concat($level, 'staketitle')}">
				<xsl:text>Stakeholder(s):</xsl:text>
			</p>
			<xsl:apply-templates select="*[local-name(.) = 'Stakeholder']">
				<xsl:with-param name="level" select="$level" />
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!-- Template to apply images of stakeholder type -->
<xsl:template match="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
    <xsl:param name="level" select="'org'" />
    <p class="{concat(@level, 'stakeholder')}">
        <xsl:choose>
            <!-- Check if StakeholderTypeType is 'Generic_Group' and if the Name element contains 'You.com' -->
            <!-- <xsl:when test="@StakeholderTypeType = 'Generic_Group' and contains(normalize-space(*[local-name()='Name']), 'You.com')">
                <img src="images/YOU.jpg" alt="You.com Image" width="30px" height="30px" />
            </xsl:when> -->
            <xsl:when test="@StakeholderTypeType = 'Generic_Group'">
                <img src="images/group.png" alt="Group Image" width="30px" height="30px" />
            </xsl:when>
            <xsl:when test="@StakeholderTypeType = 'Person'">
                <img src="images/person.png" alt="Person Image" width="30px" height="30px" />
            </xsl:when>
            <xsl:when test="@StakeholderTypeType = 'Organization'">
                <img src="images/organization.png" alt="Organization Image" width="30px" height="30px" />
            </xsl:when>
            <xsl:otherwise>
                <!-- Handle other cases if needed -->
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:call-template name="name-desc-role" />
    </p>
</xsl:template>


<xsl:template name="name-desc-role">
    <xsl:call-template name="name-desc" />
    <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
        <xsl:text> (</xsl:text>
        <xsl:for-each select="*[local-name() = 'RoleType' and normalize-space(.)]">
            <xsl:if test="position() > 1">
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="." />
        </xsl:for-each>
        <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:if test="*[local-name() = 'Role' and normalize-space(.)]">
        <xsl:text> </xsl:text>
        <xsl:for-each select="*[local-name() = 'Role' and normalize-space(.)]">
             <div class="single-break"></div>
            <xsl:call-template name="name-desc-role" />
        </xsl:for-each>
    </xsl:if>
</xsl:template>

<xsl:template name="name-desc">

   
    <b style="padding-left: 5px;">
        <xsl:apply-templates select="*[local-name() = 'Name' and normalize-space(.)]" />
    </b>
  
    <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="*[local-name() = 'Description' and normalize-space(.)]" />
    </xsl:if>
	
</xsl:template>


	<xsl:template match="*[contains('Vision Mission', local-name(.))]">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<p class="vmvhead" id="{$anchor}">
			<a href="#{$anchor}">
				<xsl:choose>
					<xsl:when test="local-name(.) = 'Vision'">
						Vision
					</xsl:when>
					<xsl:otherwise>
						Mission
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</p>
		<p class="vmvdesc">
			<xsl:apply-templates select="*[local-name(.) = 'Description']" />
		</p>
	</xsl:template>

	<xsl:template match="*[local-name(.) = 'Objective']">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<p class="objhead" id="{$anchor}">
    <a href="#{$anchor}">
        <xsl:text>Objective </xsl:text>
        <xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
            <xsl:text></xsl:text>
        <xsl:text> </xsl:text> 
        <!-- Add space after SequenceIndicator -->
    </a>
    <xsl:for-each select="*[local-name(.) = 'Name']">
        <xsl:variable name="NameValueObjective">
            <xsl:apply-templates select="." />
        </xsl:variable>
        <xsl:apply-templates select="." />
				<br />
<!--				<a>
					<xsl:attribute name="href">
					<xsl:text>mailto: </xsl:text>
						<xsl:for-each select="//*[local-name(.) = 'EmailAddress']">
							<xsl:value-of select="." />
								<xsl:text>?Subject=</xsl:text>
								<xsl:value-of select='$NameValueObjecive' />
						</xsl:for-each>
					</xsl:attribute>
					<sup>
						<xsl:text>Click to Comment on This Objective " </xsl:text>
						<xsl:value-of select='$NameValueObjecive' />
						<xsl:text> "</xsl:text>
					</sup>
				</a>
-->
			</xsl:for-each>
		</p>
		<xsl:for-each select="*[local-name(.) = 'Description']">
			<p class="para">
				<xsl:apply-templates select="." />
			</p>
		</xsl:for-each>
		<xsl:call-template name="stakeholder">
			<xsl:with-param name="level" select="'obj'" />
		</xsl:call-template>
		<xsl:apply-templates select="*[local-name(.) = 'OtherInformation']" />
		<xsl:apply-templates
			select="*[local-name(.) = 'PerformanceIndicator' and normalize-space(.)]" />
	</xsl:template>

	<!-- Template to process the "OtherInformation" element -->
  <xsl:template match="*[local-name() = 'OtherInformation' and normalize-space(.)]">
        <p class="infotitle" id="{generate-id(.)}">
            <xsl:text>Other Information:</xsl:text>
        </p>
		<!-- <p class ="para"> -->
			<xsl:call-template name="replace-special-characters">
                <xsl:with-param name="text" select="normalize-space(.)"/>
            </xsl:call-template>	
			<xsl:value-of select="*[local-name() = 'OtherInformation' and normalize-space(.)]" />
		<!-- </p> -->
    </xsl:template> 
	<xsl:template match="*[local-name(.) = 'PerformanceIndicator']">
		<xsl:if test="position() = 1">
			<p class="para-c">Performance Indicator</p>
		</xsl:if>
		  <xsl:apply-templates select="*[local-name(.) = 'Description']"/>

		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<p class="para-c" id="{$anchor}">
			<a href="#{$anchor}">
				<xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
				<xsl:value-of select="normalize-space(*[local-name(.) = 'Name'])" />
				<xsl:if
					test="normalize-space(concat(@PerformanceIndicatorType, @ValueChainStage))">
					<!-- <xsl:text>[</xsl:text> <xsl:value-of select="normalize-space(@PerformanceIndicatorType)" 
						/> <xsl:if test="normalize-space(@PerformanceIndicatorType) and normalize-space(@ValueChainStage)"> 
						<xsl:text> | </xsl:text> </xsl:if> <xsl:value-of select="normalize-space(@ValueChainStage)" 
						/> <xsl:text>]</xsl:text> -->
				</xsl:if>
				<!-- <xsl:text>Measurements </xsl:text> -->
				<xsl:if
					test="*[local-name(.) = 'MeasurementDimension' and normalize-space(.)]">
					<!-- <xsl:text>in </xsl:text> -->
					<xsl:apply-templates select="*[local-name(.) = 'MeasurementDimension']" />
				</xsl:if>
			</a>
		</p>
		<p class="para">
			<xsl:apply-templates select="*[local-name(.) = 'Description']" />
		</p>

		<!-- (dhh) position of previous representation of <Relationship> elements -->

		<xsl:apply-templates select="."
			mode="makeMeasurementInstanceTable" />
		
		<!-- Add line chart visualization -->
		<xsl:apply-templates select="."
			mode="makeMeasurementInstanceChart" />

		<!-- (dhh) moved representation of <Relationship> elements from above to 
			below the indicators table just show the relationship if it contains element -->
	 <xsl:if test="*[local-name(.) = 'Relationship'][*[local-name(.) = 'Name' or local-name(.) = 'Description' or local-name(.) = 'ReferentIdentifier'][normalize-space()]]">
      <p class="para">Relationships:</p>
      <xsl:apply-templates select="*[local-name(.) = 'Relationship'][*[local-name(.) = 'Name' or local-name(.) = 'Description' or local-name(.) = 'ReferentIdentifier'][normalize-space()]]" />
    </xsl:if>

		<xsl:apply-templates select="*[local-name(.) = 'ReferentIdentifier']" />
		<xsl:apply-templates select="*[local-name(.) = 'OtherInformation']" />

	</xsl:template>


 <xsl:template match="*[local-name(.) = 'Relationship'][*[local-name(.) = 'Name' or local-name(.) = 'Description' or local-name(.) = 'ReferentIdentifier'][normalize-space()]]">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
			<xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
		</xsl:variable>
		<xsl:if test="normalize-space(@RelationshipType)">
			<xsl:variable name="MyRelationShipType">
				<xsl:value-of select="concat(@RelationshipType,'-')" />
			</xsl:variable>
			<xsl:variable name="MyRelationShipName">
				<xsl:value-of select="normalize-space(*[local-name(.) = 'Name'])" />
			</xsl:variable>
			<xsl:variable name="URLString">
				<xsl:value-of select="*[local-name(.) = 'ReferentIdentifier']" />
			</xsl:variable>

			<!-- <xsl:variable name="FoundID" select="boolean('true')"/> -->

			<p class="vmvdesc">
				<xsl:for-each
					select="*[local-name(.) = 'ReferentIdentifier' and normalize-space(.)]">


					<a>
						<xsl:attribute name="href">
			 		<xsl:choose>
						<xsl:when test="contains($URLString,'http')"> 
							<xsl:value-of select='$URLString' />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('#',$URLString)" />
						</xsl:otherwise>
					</xsl:choose>
					
			 		</xsl:attribute>

						<xsl:attribute name="target">
			 			<xsl:text>_blank</xsl:text>
			 		
			 		</xsl:attribute>

						<xsl:choose>
							<xsl:when test="contains($URLString,'http')">
								<!-- <xsl:value-of select='$MyRelationShipType' /> -->
								<xsl:value-of select="concat($MyRelationShipName,' - ')" />
								<xsl:value-of select='$URLString' />
							</xsl:when>
							<xsl:otherwise>
								<!-- <xsl:value-of select='$MyRelationShipType' /> -->
								<xsl:value-of select="concat($MyRelationShipName,' - ')" />

								<xsl:for-each select="//*[local-name(.) = 'Goal']">
									<!-- <xsl:if test="$FoundID"> -->
									<xsl:variable name="GoalNames"
										select="normalize-space(*[local-name(.) = 'Name'])" />
									<xsl:variable name="GoalSequenceIndicators"
										select="normalize-space(*[local-name(.) = 'SequenceIndicator'])" />
									<xsl:variable name="GoalLocalIdentifierID"
										select="normalize-space(*[local-name(.) = 'Identifier'])" />
									<xsl:if test="contains($URLString,$GoalLocalIdentifierID)">
										<!-- <xsl:value-of select="concat($GoalSequenceIndicators,' ')" 
											/> -->
										<xsl:value-of select="concat($GoalNames,' ')" />
										<!-- <xsl:variable name="FoundID" select="boolean('false')"/> -->
									</xsl:if>
									<xsl:for-each select="*[local-name(.) = 'Objective']">
										<!-- <xsl:if test="$FoundID"> -->
										<xsl:variable name="Names"
											select="normalize-space(*[local-name(.) = 'Name'])" />
										<xsl:variable name="SequenceIndicators"
											select="normalize-space(*[local-name(.) = 'SequenceIndicator'])" />
										<xsl:variable name="LocalIdentifierID"
											select="normalize-space(*[local-name(.) = 'Identifier'])" />
										<xsl:if test="contains($URLString,$LocalIdentifierID)">
											<!-- <xsl:text>Objective </xsl:text> -->
											<!-- <xsl:value-of select="concat($SequenceIndicators,' - ')" 
												/> -->
											<xsl:value-of select="concat($Names,' ')" />
											<!-- <xsl:variable name="FoundID" select="boolean('false')"/> -->
										</xsl:if>
										<!-- </xsl:if> -->
									</xsl:for-each>
									<!-- </xsl:if> -->
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>

					</a>

				</xsl:for-each>
			</p>
		</xsl:if>
		<!-- </xsl:for-each> -->
		<p class="vmvdesc">
			<xsl:apply-templates select="*[local-name(.) = 'Description']" />
		</p>
		<!-- <br/> -->
	</xsl:template>
	<xsl:template match="*[local-name(.) = 'ReferentIdentifier']">
		<xsl:variable name="anchor">
			<xsl:call-template name="getid" />
		</xsl:variable>
		<a href="#{$anchor}">
			<xsl:value-of select="*[local-name(.) = 'ReferentIdentifier']" />
		</a>
	</xsl:template>




   
	   <!-- Template to match PerformanceIndicator and create a table and enable its graphical display if it contains more than one number of units populated and also shows unit of measurement whether number of unit is populated or not  -->


<xsl:template match="*[local-name() = 'PerformanceIndicator']" mode="makeMeasurementInstanceTable">
    <xsl:variable name="hasUnits" select="boolean(descendant::*[local-name() = 'UnitOfMeasurement']/text() or descendant::*[local-name() = 'NumberOfUnits' and normalize-space(.) != ''])"/>
    <table align="center" class="datatable" width="98%">
        <thead>
            <tr>
                <th align="center" width="10%">Type</th>
                <th align="center" width="10%">StartDate</th>
                <th align="center" width="10%">EndDate</th>
                <xsl:if test="$hasUnits">
                    <th align="center" width="10%">
                        <xsl:choose>
                            <xsl:when test="descendant::*[local-name(.) = 'UnitOfMeasurement']">
                                <xsl:value-of select="descendant::*[local-name(.) = 'UnitOfMeasurement']"/>
                            </xsl:when>
                            <xsl:otherwise>Units Of Measurement</xsl:otherwise>
                        </xsl:choose>
                    </th>
                </xsl:if>
                <xsl:if test="descendant::*[local-name() = 'Descriptor' and string-length(child::*) > 0]">
                    <th align="right" width="15%">
                        <xsl:value-of select="normalize-space(descendant::*[local-name() = 'Descriptor'][string-length(child::*[local-name() = 'DescriptorName']) > 0][1]/child::*[local-name() = 'DescriptorName'])"/>
                    </th>
                </xsl:if>
                <th align="left" width="*">Description</th>
            </tr>
        </thead>
        <tbody>
            <xsl:apply-templates select="*[local-name() = 'MeasurementInstance']/*[((local-name()='TargetResult') or (local-name() = 'ActualResult')) and normalize-space(.)]">
                <xsl:with-param name="hasUnits" select="$hasUnits"/>
                <xsl:sort select="*[local-name(.) = 'StartDate']"/>
                <xsl:sort select="*[local-name(.) = 'EndDate']"/>
                <xsl:sort select="local-name(.)" order="descending"/>
            </xsl:apply-templates>
        </tbody>
    </table>
</xsl:template>

<xsl:template match="*[local-name(.) = 'UnitOfMeasurement']">
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="*[(local-name()='TargetResult') or (local-name() = 'ActualResult')]">
    <xsl:param name="hasUnits"/>
    <tr>
        <td align="center" width="10%">
            <xsl:choose>
                <xsl:when test="local-name()='TargetResult'">
                    <xsl:text>Target</xsl:text>
                </xsl:when>
                <xsl:when test="local-name()='ActualResult'">
                    <xsl:text>Actual</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </td>
        <td align="center" width="10%">
            <xsl:choose>
                <xsl:when test="normalize-space(*[local-name(.) = 'StartDate'])">
                    <xsl:value-of select="*[local-name(.) = 'StartDate']" />
                </xsl:when>
                <xsl:otherwise>
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </td>
        <td align="center" width="10%">
            <xsl:choose>
                <xsl:when test="normalize-space(*[local-name(.) = 'EndDate'])">
                    <xsl:value-of select="*[local-name(.) = 'EndDate']" />
                </xsl:when>
                <xsl:otherwise>
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </td>
        <xsl:if test="$hasUnits">
            <td align="center" width="10%">
                <xsl:choose>
                    <xsl:when test="normalize-space(*[local-name(.) = 'NumberOfUnits'])">
                        <xsl:value-of select="*[local-name(.) = 'NumberOfUnits']" />
                    </xsl:when>
                    <xsl:otherwise>
                        <br />
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </xsl:if>
        <xsl:if test="../descendant::*[local-name() = 'Descriptor' and string-length(child::*) > 0]">
            <td align="right" width="15%">
                <xsl:choose>
                    <xsl:when test="child::*[local-name(.) = 'Descriptor']/child::*[local-name(.) = 'DescriptorValue']">
                        <xsl:value-of select="normalize-space(descendant::*[local-name(.) = 'DescriptorValue'])" />
                    </xsl:when>
                    <xsl:otherwise>
                        <br />
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </xsl:if>
        <td align="left" width="">
            <xsl:choose>
                <xsl:when test="normalize-space(*[local-name(.) = 'Description'])" >
                    <xsl:apply-templates select="*[local-name(.) = 'Description']"/>
                </xsl:when>
                <xsl:otherwise>
                    <br />
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </tr>
</xsl:template>

<!-- Template to create line charts for PerformanceIndicators -->
<xsl:template match="*[local-name() = 'PerformanceIndicator']" mode="makeMeasurementInstanceChart">
    <xsl:variable name="hasData" select="boolean(*[local-name() = 'MeasurementInstance']/*[local-name() = 'TargetResult' or local-name() = 'ActualResult']/*[local-name() = 'NumberOfUnits' and normalize-space(.) != ''])"/>
    <xsl:variable name="chartId" select="generate-id(.)"/>
    <xsl:variable name="measurementDimension" select="normalize-space(*[local-name() = 'MeasurementDimension'])"/>
    <xsl:variable name="unitOfMeasurement" select="normalize-space(*[local-name() = 'UnitOfMeasurement'])"/>
    
    <xsl:if test="$hasData">
        <div class="chart-container">
            <div class="chart-title">
                <xsl:value-of select="$measurementDimension"/>
                <xsl:if test="$unitOfMeasurement != ''">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="$unitOfMeasurement"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text> - Performance Over Time</xsl:text>
            </div>
            
            <div class="chart-toggle">
                <button onclick="toggleChartView('{$chartId}', 'line')" class="active" id="lineBtn{$chartId}">Line Chart</button>
                <button onclick="toggleChartView('{$chartId}', 'bar')" id="barBtn{$chartId}">Bar Chart</button>
            </div>
            
            <canvas id="chart{$chartId}" class="chart-canvas"></canvas>
        </div>
        
        <script type="text/javascript">
            <xsl:text>
            (function() {
                // Data extraction for chart </xsl:text><xsl:value-of select="$chartId"/><xsl:text>
                var chartData = {
                    labels: [],
                    targetData: [],
                    actualData: []
                };
                
                // Extract data from measurement instances
                var measurementInstances = [</xsl:text>
                
                <xsl:for-each select="*[local-name() = 'MeasurementInstance']">
                    <xsl:sort select="*[local-name() = 'TargetResult']/*[local-name() = 'StartDate']"/>
                    <xsl:variable name="startDate" select="normalize-space(*[local-name() = 'TargetResult']/*[local-name() = 'StartDate'] | *[local-name() = 'ActualResult']/*[local-name() = 'StartDate'])"/>
                    <xsl:variable name="targetValue" select="normalize-space(*[local-name() = 'TargetResult']/*[local-name() = 'NumberOfUnits'])"/>
                    <xsl:variable name="actualValue" select="normalize-space(*[local-name() = 'ActualResult']/*[local-name() = 'NumberOfUnits'])"/>
                    
                    <xsl:if test="$startDate != ''">
                        <xsl:if test="position() > 1">,</xsl:if>
                        <xsl:text>{
                            date: "</xsl:text><xsl:value-of select="$startDate"/><xsl:text>",
                            target: </xsl:text><xsl:choose><xsl:when test="$targetValue != ''"><xsl:value-of select="$targetValue"/></xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose><xsl:text>,
                            actual: </xsl:text><xsl:choose><xsl:when test="$actualValue != ''"><xsl:value-of select="$actualValue"/></xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose><xsl:text>
                        }</xsl:text>
                    </xsl:if>
                </xsl:for-each>
                
                <xsl:text>];
                
                // Sort by date and populate chart data
                measurementInstances.sort(function(a, b) {
                    return new Date(a.date) - new Date(b.date);
                });
                
                measurementInstances.forEach(function(item) {
                    var year = new Date(item.date).getFullYear();
                    chartData.labels.push(year.toString());
                    chartData.targetData.push(item.target);
                    chartData.actualData.push(item.actual);
                });
                
                // Chart configuration
                var ctx = document.getElementById('chart</xsl:text><xsl:value-of select="$chartId"/><xsl:text>').getContext('2d');
                window.chart</xsl:text><xsl:value-of select="$chartId"/><xsl:text> = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: chartData.labels,
                        datasets: [{
                            label: 'Target',
                            data: chartData.targetData,
                            borderColor: 'rgb(75, 192, 192)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderWidth: 2,
                            fill: false,
                            tension: 0.1
                        }, {
                            label: 'Actual',
                            data: chartData.actualData,
                            borderColor: 'rgb(255, 99, 132)',
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderWidth: 2,
                            fill: false,
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            title: {
                                display: true,
                                text: '</xsl:text><xsl:value-of select="$measurementDimension"/><xsl:text> Performance Trends'
                            },
                            legend: {
                                display: true,
                                position: 'top'
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: false,
                                title: {
                                    display: true,
                                    text: '</xsl:text><xsl:value-of select="$unitOfMeasurement"/><xsl:text>'
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: 'Year'
                                }
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index'
                        }
                    }
                });
            })();
            
            // Global function to toggle chart types
            if (typeof toggleChartView === 'undefined') {
                window.toggleChartView = function(chartId, type) {
                    var chart = window['chart' + chartId];
                    if (chart) {
                        chart.config.type = type;
                        chart.update();
                        
                        // Update button states
                        document.getElementById('lineBtn' + chartId).classList.remove('active');
                        document.getElementById('barBtn' + chartId).classList.remove('active');
                        document.getElementById(type + 'Btn' + chartId).classList.add('active');
                    }
                };
            }
            </xsl:text>
        </script>
    </xsl:if>
</xsl:template>





<xsl:template match="*[local-name() = 'Description' and normalize-space(.)]">
  <Description>
   <p class="para">
    <xsl:variable name="descText">
      <xsl:call-template name="normalize-space">
        <xsl:with-param name="string" select="."/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:call-template name="process-text">
      <xsl:with-param name="text" select="$descText"/>
    </xsl:call-template>
	</p>
  </Description>
</xsl:template>

<xsl:template name="normalize-space">
  <xsl:param name="string"/>
  <xsl:choose>
    <xsl:when test="string-length(normalize-space($string)) = 0">
      <xsl:value-of select="''"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="remove-extra-spaces">
        <xsl:with-param name="string" select="normalize-space($string)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="remove-extra-spaces">
  <xsl:param name="string"/>
  <xsl:choose>
    <xsl:when test="not(contains($string, '  '))">
      <xsl:value-of select="$string"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="remove-extra-spaces">
        <xsl:with-param name="string" select="concat(substring-before($string, '  '), ' ', substring-after($string, '  '))"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="process-text">
  <xsl:param name="text"/>
  <xsl:choose>
    <!-- Check for full URLs and 'www' links -->
    <xsl:when test="contains($text, 'https://') or contains($text, 'http://') or contains($text, 'www')">
      <xsl:variable name="before">
        <xsl:call-template name="substring-before-link">
          <xsl:with-param name="text" select="$text"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="link">
        <xsl:call-template name="extract-link">
          <xsl:with-param name="text" select="$text"/>
        </xsl:call-template>
      </xsl:variable>
      <!-- Check if the link starts with 'www' and prepend 'https://' -->
      <xsl:variable name="finalLink">
        <xsl:choose>
          <xsl:when test="starts-with($link, 'www')">
            <xsl:value-of select="concat('https://', $link)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$link"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="after">
        <xsl:call-template name="substring-after-link">
          <xsl:with-param name="text" select="$text"/>
          <xsl:with-param name="link" select="$link"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:call-template name="process-text">
        <xsl:with-param name="text" select="$before"/>
      </xsl:call-template>
      <a href="{$finalLink}">
        <xsl:value-of select="$finalLink"/>
      </a>
      <xsl:call-template name="process-text">
        <xsl:with-param name="text" select="$after"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:when test="contains($text, '@')">
      <xsl:variable name="email">
        <xsl:call-template name="extract-email">
          <xsl:with-param name="text" select="$text"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:call-template name="process-text">
        <xsl:with-param name="text" select="substring-before($text, $email)"/>
      </xsl:call-template>
      <a href="mailto:{$email}">
        <xsl:value-of select="$email"/>
      </a>
      <xsl:call-template name="process-text">
        <xsl:with-param name="text" select="substring-after($text, $email)"/>
      </xsl:call-template>
    </xsl:when>
    
    <xsl:otherwise>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="$text"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="substring-before-link">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text, 'https://')">
      <xsl:value-of select="substring-before($text, 'https://')"/>
    </xsl:when>
   
    <xsl:when test="contains($text, 'http://')">
      <xsl:value-of select="substring-before($text, 'http://')"/>
    </xsl:when>
   <xsl:when test="contains($text, 'www.')">
      <xsl:value-of select="substring-before($text, 'www.')"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>
<xsl:template name="extract-link">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text, 'https://')">
      <xsl:call-template name="process-url">
        <xsl:with-param name="protocol" select="'https://'"/>
        <xsl:with-param name="url-part" select="substring-after($text, 'https://')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($text, 'http://')">
      <xsl:call-template name="process-url">
        <xsl:with-param name="protocol" select="'http://'"/>
        <xsl:with-param name="url-part" select="substring-after($text, 'http://')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($text, 'www.')">
      <xsl:call-template name="process-url">
        <xsl:with-param name="protocol" select="'www.'"/>
        <xsl:with-param name="url-part" select="substring-after($text, 'www.')"/>
      </xsl:call-template>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="process-url">
  <xsl:param name="protocol"/>
  <xsl:param name="url-part"/>
  
  <xsl:variable name="trimmed-url-part">
    <xsl:choose>
      <xsl:when test="contains($url-part, ' ')">
        <xsl:value-of select="substring-before($url-part, ' ')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$url-part"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="final-url-part">
    <xsl:choose>
      <xsl:when test="substring($trimmed-url-part, string-length($trimmed-url-part)) = '.'">
        <xsl:value-of select="substring($trimmed-url-part, 1, string-length($trimmed-url-part) - 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$trimmed-url-part"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:value-of select="concat($protocol, $final-url-part)"/>
</xsl:template>



<xsl:template name="substring-after-link">
  <xsl:param name="text"/>
  <xsl:param name="link"/>
  <xsl:value-of select="substring-after($text, $link)"/>
</xsl:template>

<xsl:template name="process-replacements">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text, '^^ * ')">
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-before($text, '^^ * ')"/>
      </xsl:call-template>
      <div class="double-break"></div>
      <span class="indent">&#8226; </span>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-after($text, '^^ * ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($text, '^ *')">
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-before($text, '^ *')"/>
      </xsl:call-template>
      <div class="single-break"></div>
      <span class="indent">&#8226; </span>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-after($text, '^ *')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($text, '^^')">
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-before($text, '^^')"/>
      </xsl:call-template>
      <div class="double-break"></div>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-after($text, '^^')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($text, '^')">
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-before($text, '^')"/>
      </xsl:call-template>
      <div class="single-break"></div>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-after($text, '^')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="starts-with($text, '* ')">
      <span class="indent">&#8226; </span>
      <xsl:call-template name="process-replacements">
        <xsl:with-param name="text" select="substring-after($text, '* ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template name="extract-email">
  <xsl:param name="text"/>
  <xsl:variable name="before" select="substring-before($text, '@')"/>
  <xsl:variable name="after" select="substring-after($text, '@')"/>
  <xsl:variable name="local-part">
    <xsl:call-template name="get-local-part">
      <xsl:with-param name="text" select="$before"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="domain">
    <xsl:call-template name="get-domain">
      <xsl:with-param name="text" select="$after"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="concat($local-part, '@', $domain)"/>
</xsl:template>

<xsl:template name="get-local-part">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text, ' ')">
      <xsl:call-template name="get-local-part">
        <xsl:with-param name="text" select="substring-after($text, ' ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="get-domain">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text, ' ')">
      <xsl:value-of select="substring-before($text, ' ')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>




</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2007. Progress 
	Software Corporation. All rights reserved. <metaInformation> <scenarios ><scenario 
	default="yes" name="test" userelativepaths="yes" externalpreview="no" url="..\..\..\..\..\..\..\..\xml.war\WEB-INF\cosmos\src\stratml\smi-fy09.stratml" 
	htmlbaseurl="" outputurl="" processortype="internal" useresolver="yes" profilemode="0" 
	profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" 
	additionalclasspath="" postprocessortype="none" postprocesscommandline="" 
	postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" 
	validator="internal" customvalidator="" ><advancedProp name="sInitialMode" 
	value=""/><advancedProp name="bXsltOneIsOkay" value="true"/><advancedProp 
	name="bSchemaAware" value="false"/><advancedProp name="bXml11" value="false"/><advancedProp 
	name="iValidation" value="0"/><advancedProp name="bExtensions" value="true"/><advancedProp 
	name="iWhitespace" value="0"/><advancedProp name="sInitialTemplate" value=""/><advancedProp 
	name="bTinyTree" value="true"/><advancedProp name="bWarnings" value="true"/><advancedProp 
	name="bUseDTD" value="false"/><advancedProp name="iErrorHandling" value="0"/></scenario></scenarios><MapperMetaTag><MapperInfo 
	srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" 
	destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition><TemplateContext></TemplateContext><MapperFilter 
	side="source"></MapperFilter></MapperMetaTag> </metaInformation> -->