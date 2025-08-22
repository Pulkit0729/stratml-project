<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:strat="urn:ISO:std:iso:17469:tech:xsd:PerformancePlanOrReport"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:p="http://www.stratml.net/PerformancePlanOrReport"
                xmlns:x="http://www.w3.org/2001/XMLSchema-instance"
                exclude-result-prefixes="p x strat"
                version="1.0">

    <!-- Updated March 2025: Fixed shading by matching Actual/Target via StartDate/EndDate. -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="p">
        <p style="font-family: Arial; font-size: 12pt; margin-bottom: 10pt;">
            <xsl:apply-templates />
        </p>
    </xsl:template>

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
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="plan" select="*" />
        <html>
            <head>
                <title>
                    <xsl:value-of select="concat($doc-type, ' - Source: ', //*[local-name(.) = 'Source'])" />
                </title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <style type="text/css">
                    html{background-color:#EFEFFF;overflow:hidden;}
                    .toc {float:left;width:20%;height:100vh;overflow:scroll;font-size:80%;}
                    .toctitle {text-align:center;font-size:16pt;color:green;font-weight:bold;}
                    .content {padding:15pt;background-color:#FFFFFF;float:left;width:76%;height:100vh;overflow:scroll;}
                    pre,samp {font-family:Times-Roman;font-size:80%}
                    .doc {font-family:Tahoma,Arial;font-size:14pt}
                    .docheading {font-size:20pt;text-align:center;font-weight:bold}
                    .docsubheading {font-size:15pt;text-align:center;color:green}
                    .sourceheading {}
                    .herald {font-family:sans-serif;font-size:12pt;font-weight:bold}
                    .subtitle {text-align:left;font-size:14pt;color:black;font-weight:bold}
                    .orgstaketitle {text-align:left;font-size:14pt;color:black;font-weight:bold}
                    .orgstakeholder {margin-left:0in;font-family:Tahoma,Arial !important;font-size:12pt;}
                    .toggle-input {display:none;}
                    .indent {padding-left:50px;display:inline;}
                    .objectives-container {display:none;}
                    .toggle-input:checked ~ .objectives-container {display:block;}
                    .goal-title {cursor:pointer;margin-left:25px;position:relative;}
                    .goal-title::before {
                        content:"";
                        display:inline-block;
                        width:0;
                        height:0;
                        border-left:4px solid #048;
                        border-top:4px solid transparent;
                        border-bottom:4px solid transparent;
                        margin-right:8px;
                        vertical-align:middle;
                    }
                    .toggle-input:checked + .goal-title::before {
                        border-left:4px solid transparent;
                        border-right:4px solid transparent;
                        border-top:4px solid #048;
                        border-bottom:none;
                    }
                    .expand-all-toggle {display:none;}
                    .expand-all-button {display:inline-block;margin-bottom:10px;padding:5px 10px;background-color:#f0f0f0;color:#333;text-decoration:none;border:1px solid #ccc;border-radius:4px;cursor:pointer;position:relative;left:50%;transform:translateX(-50%);}
                    .expand-all-button:hover {background-color:#e0e0e0;}
                    .expand-all-toggle:not(:checked) ~ .expand-all-button .collapse-text {display:none;}
                    .expand-all-toggle:checked ~ .expand-all-button .expand-text {display:none;}
                    .expand-all-toggle:checked ~ .goal-container .objectives-container {display:block;}
                    .expand-all-toggle:checked ~ .goal-container .goal-title::before {
                        border-left:4px solid transparent;
                        border-right:4px solid transparent;
                        border-top:4px solid #048;
                        border-bottom:none;
                    }
                    .toctitle {font-weight:bold;margin-top:20px;}
                    .tocentry {margin-left:20px;}
                    .tocsubentry {margin-left:40px;}
                    .placeholder {display:inline-block;width:30px;height:30px;background-color:#f0f0f0;text-align:center;line-height:30px;font-size:12px;color:#999;border:1px solid #ccc;}
                    .tocsubtitle {text-align:left;font-size:14pt;color:black;font-weight:bold}
                    .tocentry {margin-left:0in;text-indent:0.25in;margin-top:0pt;margin-bottom:0pt;}
                    .tocsubentry {margin-left:0.25in;text-indent:0.25in;margin-top:0pt;margin-bottom:0pt;}
                    .vmvhead {font-size:15pt;font-weight:bold}
                    .vmvdesc {margin-left:.25in}
                    .goalsep {display:visible;margin-top:16pt;margin-bottom:0pt}
                    .goalhead {text-align:center;font-size:16pt;color:green;font-weight:bold;margin-top:8pt}
                    .goaldesc {text-align:center;margin-left:25%;margin-right:25%}
                    .goalstaketitle {margin-left:0.5in;text-align:left;font-size:14pt;color:black;font-weight:bold}
                    .goalstakeholder {margin-left:1in;text-align:left;margin-left:5%;margin-right:5%}
                    .objhead {font-size:15pt}
                    .objstaketitle {margin-left:0.5in;text-align:left;font-size:12pt;color:black;font-weight:bold}
                    .objstakeholder {margin-left:1in}
                    .infotitle {margin-left:0.5in;text-indent:.25in;margin-top:0pt;margin-bottom:.25in;font-weight:bold;}
                    .para-c {margin-left:.25in;margin-right:.25in;text-align:center;}
                    .meta {font-size:8pt;text-align:right;margin-top:0pt;margin-bottom:0pt}
                    .datatable {border-collapse:collapse;margin-left:10px;margin-right:10px;margin-top:10px;margin-bottom:10px;}
                    .datatable, .datatable thead th, .datatable tbody th, .datatable tbody td {border:0px solid black;padding-left:10px;padding-right:10px;}
                    .double-break {margin-top:1em;}
                    .single-break {margin-top:0.5em;}
                    a:link {text-decoration:none;color:#06D;}
                    a:visited {color:#048D;}
                    a:hover {color:black;}
                </style>
                
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
                    .chart-visibility-toggle {
                        margin: 10px 0;
                        text-align: center;
                    }
                    .chart-visibility-button {
                        background-color: #008CBA;
                        color: white;
                        padding: 8px 16px;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        font-size: 14px;
                    }
                    .chart-visibility-button:hover {
                        background-color: #007B9A;
                    }
                    .chart-content {
                        display: none;
                    }
                    .chart-content.visible {
                        display: block;
                    }
                    .qualitative-chart-container {
                        margin: 20px 0;
                        padding: 15px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        background-color: #f5f5f5;
                    }
                    .qualitative-chart-title {
                        font-size: 16pt;
                        font-weight: bold;
                        color: #333;
                        margin-bottom: 10px;
                        text-align: center;
                    }
                    .qualitative-chart-toggle {
                        margin-bottom: 10px;
                        text-align: center;
                    }
                    .qualitative-chart-toggle button {
                        background-color: #9C27B0;
                        color: white;
                        padding: 6px 12px;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        margin: 0 3px;
                        font-size: 12px;
                    }
                    .qualitative-chart-toggle button:hover {
                        background-color: #7B1FA2;
                    }
                    .qualitative-chart-toggle button.active {
                        background-color: #E91E63;
                    }
                    .timeline-container {
                        position: relative;
                        margin: 20px 0;
                    }
                    .timeline-item {
                        display: flex;
                        align-items: center;
                        margin: 10px 0;
                        padding: 10px;
                        background: #fff;
                        border-left: 4px solid #2196F3;
                        border-radius: 4px;
                        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    }
                    .timeline-status {
                        width: 120px;
                        font-weight: bold;
                        color: #333;
                    }
                    .timeline-description {
                        flex: 1;
                        margin-left: 15px;
                        font-size: 14px;
                    }
                    .timeline-date {
                        width: 100px;
                        text-align: right;
                        color: #666;
                        font-size: 12px;
                    }
                    .progress-bar-container {
                        margin: 10px 0;
                    }
                    .progress-bar {
                        background-color: #f0f0f0;
                        border-radius: 10px;
                        overflow: hidden;
                        height: 25px;
                        position: relative;
                    }
                    .progress-fill {
                        height: 100%;
                        background: linear-gradient(90deg, #4CAF50, #2196F3);
                        transition: width 0.3s ease;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 12px;
                        font-weight: bold;
                    }
                    .comparison-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 20px;
                        margin: 15px 0;
                    }
                    .comparison-item {
                        padding: 15px;
                        border-radius: 8px;
                        border: 2px solid #ddd;
                    }
                    .comparison-target {
                        background-color: #E3F2FD;
                        border-color: #2196F3;
                    }
                    .comparison-actual {
                        background-color: #E8F5E8;
                        border-color: #4CAF50;
                    }
                    .comparison-header {
                        font-weight: bold;
                        margin-bottom: 10px;
                        text-align: center;
                    }
                    .status-indicator {
                        display: inline-block;
                        width: 12px;
                        height: 12px;
                        border-radius: 50%;
                        margin-right: 8px;
                    }
                    .status-completed { background-color: #4CAF50; }
                    .status-in-progress { background-color: #FF9800; }
                    .status-planned { background-color: #2196F3; }
                    .status-delayed { background-color: #F44336; }
                </style>
            </head>
            <body class="doc">
                <div class="toc" width="25%" valign="top">
                    <xsl:call-template name="toc">
                        <xsl:with-param name="tocid" select="generate-id(//*[local-name(.) = 'StrategicPlanCore'])" />
                    </xsl:call-template>
                </div>
                <div class="content" style="padding:10pt;">
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
                    <xsl:for-each select="$plan//*[local-name(.) = 'AdministrativeInformation']">
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
                    <table summary="submitter and organization information" class="doc" align="center">
                        <tr valign="top">
                            <td>
                                <xsl:variable name="submitter" select="$plan//*[local-name(.) = 'Submitter']" />
                                <xsl:if test="normalize-space($submitter)">
                                    <p class="subtitle">Submitter:</p>
                                    <xsl:apply-templates select="$submitter" />
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:variable name="org" select="$plan/*[local-name(.) = 'StrategicPlanCore']/*[local-name(.) = 'Organization']" />
                                <xsl:if test="normalize-space($org)">
                                    <p class="subtitle">Organization:</p>
                                    <xsl:apply-templates select="$org" />
                                </xsl:if>
                            </td>
                        </tr>
                    </table>
                    <xsl:apply-templates select="//*[contains('Vision Mission', local-name(.))]" />
                    <xsl:if test="//*[local-name(.) = 'Value' and normalize-space(.)]">
                        <p class="vmvhead" id="values_">
                            <xsl:text>Value</xsl:text>
                            <xsl:if test="count(//*[local-name(.) = 'Value' and normalize-space(.)])>1">
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
            <xsl:for-each select="*[local-name(.) = 'PhoneNumber' and normalize-space(.)]">
                <p>
                    <b class="herald">
                        <xsl:text>Phone Number: </xsl:text>
                    </b>
                    <xsl:value-of select="." />
                </p>
            </xsl:for-each>
            <xsl:for-each select="*[local-name(.) = 'EmailAddress' and normalize-space(.)]">
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

    <xsl:template match="*[local-name(.) = 'Organization']">
        <xsl:variable name="anchor">
            <xsl:call-template name="getid" />
        </xsl:variable>
        <blockquote id="{$anchor}" style="font-family: sans-serif !important; font-size:12pt;">
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
            <xsl:for-each select="*[local-name(.) = 'Description' and normalize-space(.)]">
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
            <input type="checkbox" id="expand-all" class="expand-all-toggle" />
            <label for="expand-all" class="expand-all-button">
                <span class="expand-text">Expand All</span>
                <span class="collapse-text">Collapse All</span>
            </label>
            <xsl:for-each select="*[local-name(.) = 'Vision']">
                <p class="tocentry">
                    <xsl:variable name="anchor">
                        <xsl:call-template name="getid" />
                    </xsl:variable>
                    <a href="#{$anchor}">Vision</a>
                </p>
            </xsl:for-each>
            <xsl:for-each select="*[local-name(.) = 'Mission']">
                <p class="tocentry">
                    <xsl:variable name="anchor1">
                        <xsl:call-template name="getid" />
                    </xsl:variable>
                    <a href="#{$anchor1}">Mission</a>
                </p>
            </xsl:for-each>
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

    <xsl:template name="replace-special-characters">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="starts-with($text, '^^ *')">
                <div class="double-break" style="margin-left: 20px;"></div>
                <span class="indent">.</span>
                <xsl:call-template name="replace-special-characters">
                    <xsl:with-param name="text" select="substring-after($text, '^^ *')" />
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="starts-with($text, '^ *')">
                <div class="single-break"></div>
                <span class="indent">.</span>
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
                <span class="indent">.</span>
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
                <xsl:if test="not(contains(*[local-name(.) = 'SequenceIndicator'], 'Goal'))">
                    <xsl:text>Goal </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="*[local-name(.) = 'SequenceIndicator']" />
                <xsl:text>   </xsl:text>
            </a>
            <xsl:for-each select="*[local-name(.) = 'Name' and normalize-space(.)]">
                <xsl:apply-templates select="." />
                <br />
            </xsl:for-each>
        </p>
        <xsl:for-each select="*[local-name(.) = 'Description' and normalize-space(.)]">
            <p class="goaldesc">
                <xsl:apply-templates />
            </p>
        </xsl:for-each>
        <xsl:call-template name="stakeholder">
            <xsl:with-param name="level" select="'goal'" />
        </xsl:call-template>
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

    <xsl:template match="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
        <xsl:param name="level" select="'org'" />
        <p class="{concat(@level, 'stakeholder')}">
            <xsl:choose>
                <xsl:when test="@StakeholderTypeType = 'Generic_Group'">
                    <img src="images/group.png" alt="Group Image" width="30px" height="30px" />
                </xsl:when>
                <xsl:when test="@StakeholderTypeType = 'Person'">
                    <img src="images/person.png" alt="Person Image" width="30px" height="30px" />
                </xsl:when>
                <xsl:when test="@StakeholderTypeType = 'Organization'">
                    <img src="images/organization.png" alt="Organization Image" width="30px" height="30px" />
                </xsl:when>
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
                <xsl:text> </xsl:text>
            </a>
            <xsl:for-each select="*[local-name(.) = 'Name']">
                <xsl:apply-templates select="." />
                <br />
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
        <xsl:apply-templates select="*[local-name(.) = 'PerformanceIndicator' and normalize-space(.)]" />
    </xsl:template>

    <xsl:template match="*[local-name() = 'OtherInformation' and normalize-space(.)]">
        <p class="infotitle" id="{generate-id(.)}">
            <xsl:text>Other Information:</xsl:text>
        </p>
        <xsl:call-template name="replace-special-characters">
            <xsl:with-param name="text" select="normalize-space(.)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*[local-name() = 'PerformanceIndicator']">
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
                <xsl:if test="*[local-name(.) = 'MeasurementDimension' and normalize-space(.)]">
                    <xsl:apply-templates select="*[local-name(.) = 'MeasurementDimension']" />
                </xsl:if>
            </a>
        </p>
        <p class="para">
            <xsl:apply-templates select="*[local-name(.) = 'Description']" />
        </p>
        <table align="center" class="datatable" width="98%">
            <xsl:apply-templates select="." mode="makeMeasurementInstanceTable" />
        </table>
        
        <!-- Add line chart visualization -->
        <xsl:apply-templates select="."
            mode="makeMeasurementInstanceChart" />
        
        <!-- Add qualitative chart visualization -->
        <xsl:apply-templates select="."
            mode="makeQualitativeChart" />
        
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
            <p class="vmvdesc">
                <xsl:for-each select="*[local-name(.) = 'ReferentIdentifier' and normalize-space(.)]">
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
                                <xsl:value-of select="concat($MyRelationShipName,' - ')" />
                                <xsl:value-of select='$URLString' />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($MyRelationShipName,' - ')" />
                                <xsl:for-each select="//*[local-name(.) = 'Goal']">
                                    <xsl:variable name="GoalNames" select="normalize-space(*[local-name(.) = 'Name'])" />
                                    <xsl:variable name="GoalSequenceIndicators" select="normalize-space(*[local-name(.) = 'SequenceIndicator'])" />
                                    <xsl:variable name="GoalLocalIdentifierID" select="normalize-space(*[local-name(.) = 'Identifier'])" />
                                    <xsl:if test="contains($URLString,$GoalLocalIdentifierID)">
                                        <xsl:value-of select="concat($GoalNames,' ')" />
                                    </xsl:if>
                                    <xsl:for-each select="*[local-name(.) = 'Objective']">
                                        <xsl:variable name="Names" select="normalize-space(*[local-name(.) = 'Name'])" />
                                        <xsl:variable name="SequenceIndicators" select="normalize-space(*[local-name(.) = 'SequenceIndicator'])" />
                                        <xsl:variable name="LocalIdentifierID" select="normalize-space(*[local-name(.) = 'Identifier'])" />
                                        <xsl:if test="contains($URLString,$LocalIdentifierID)">
                                            <xsl:value-of select="concat($Names,' ')" />
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>
                </xsl:for-each>
            </p>
        </xsl:if>
        <p class="vmvdesc">
            <xsl:apply-templates select="*[local-name(.) = 'Description']" />
        </p>
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'ReferentIdentifier']">
        <xsl:variable name="anchor">
            <xsl:call-template name="getid" />
        </xsl:variable>
        <a href="#{$anchor}">
            <xsl:value-of select="*[local-name(.) = 'ReferentIdentifier']" />
        </a>
    </xsl:template>

    <xsl:template match="*[local-name() = 'PerformanceIndicator']" mode="makeMeasurementInstanceTable">
        <xsl:variable name="hasUnits" select="boolean(descendant::*[local-name() = 'UnitOfMeasurement']/text() or descendant::*[local-name() = 'NumberOfUnits' and normalize-space(.) != ''])"/>
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
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'UnitOfMeasurement']">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="*[(local-name()='TargetResult') or (local-name() = 'ActualResult')]">
        <xsl:param name="hasUnits"/>
        <tr>
            <!-- Apply light gray only to Target rows -->
            <xsl:if test="local-name()='TargetResult'">
                <xsl:attribute name="style">background-color: #D3D3D3;</xsl:attribute>
            </xsl:if>
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
                            <xsl:attribute name="style">
                                <xsl:if test="local-name()='ActualResult'">
                                    <xsl:variable name="actualUnits" select="number(normalize-space(*[local-name(.) = 'NumberOfUnits']))"/>
                                    <xsl:variable name="startDate" select="normalize-space(*[local-name(.) = 'StartDate'])"/>
                                    <xsl:variable name="endDate" select="normalize-space(*[local-name(.) = 'EndDate'])"/>
                                    <xsl:variable name="targetUnits">
                                        <xsl:choose>
                                            <xsl:when test="../*[local-name()='TargetResult' and normalize-space(*[local-name(.) = 'StartDate']) = $startDate and normalize-space(*[local-name(.) = 'EndDate']) = $endDate]">
                                                <xsl:value-of select="number(normalize-space(../*[local-name()='TargetResult' and normalize-space(*[local-name(.) = 'StartDate']) = $startDate and normalize-space(*[local-name(.) = 'EndDate']) = $endDate]/*[local-name(.) = 'NumberOfUnits']))"/>
                                            </xsl:when>
                                            <xsl:otherwise>NaN</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$actualUnits != 'NaN' and $targetUnits != 'NaN' and $actualUnits > $targetUnits">
                                            background-color: #90EE90; <!-- Light green -->
                                        </xsl:when>
                                        <xsl:when test="$actualUnits != 'NaN' and $targetUnits != 'NaN' and $actualUnits &lt; $targetUnits">
                                            background-color: #FFB6C1; <!-- Light red -->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            background-color: #FFFFFF; <!-- White if equal, missing, or invalid -->
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:attribute>
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
                    <xsl:when test="normalize-space(*[local-name(.) = 'Description'])">
                        <xsl:apply-templates select="*[local-name(.) = 'Description']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <br />
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
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
                <span class="indent">.</span>
                <xsl:call-template name="process-replacements">
                    <xsl:with-param name="text" select="substring-after($text, '^^ * ')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($text, '^ *')">
                <xsl:call-template name="process-replacements">
                    <xsl:with-param name="text" select="substring-before($text, '^ *')"/>
                </xsl:call-template>
                <div class="single-break"></div>
                <span class="indent">.</span>
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
                <span class="indent">.</span>
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

    <!-- Template to create line charts for PerformanceIndicators -->
    <xsl:template match="*[local-name() = 'PerformanceIndicator']" mode="makeMeasurementInstanceChart">
        <xsl:variable name="hasData" select="boolean(*[local-name() = 'MeasurementInstance']/*[local-name() = 'TargetResult' or local-name() = 'ActualResult']/*[local-name() = 'NumberOfUnits' and normalize-space(.) != ''])"/>
        <xsl:variable name="chartId" select="generate-id(.)"/>
        <xsl:variable name="measurementDimension" select="normalize-space(*[local-name() = 'MeasurementDimension'])"/>
        <xsl:variable name="unitOfMeasurement" select="normalize-space(*[local-name() = 'UnitOfMeasurement'])"/>
        
        <xsl:if test="$hasData">
            <div class="chart-visibility-toggle">
                <button class="chart-visibility-button" onclick="toggleChartVisibility('{$chartId}')" id="toggleBtn{$chartId}">
                    Show Chart
                </button>
            </div>
            
            <div class="chart-content" id="chartContent{$chartId}">
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
                
                // Global function to toggle chart visibility
                if (typeof toggleChartVisibility === 'undefined') {
                    window.toggleChartVisibility = function(chartId) {
                        var chartContent = document.getElementById('chartContent' + chartId);
                        var toggleBtn = document.getElementById('toggleBtn' + chartId);
                        
                        if (chartContent.classList.contains('visible')) {
                            chartContent.classList.remove('visible');
                            toggleBtn.textContent = 'Show Chart';
                        } else {
                            chartContent.classList.add('visible');
                            toggleBtn.textContent = 'Hide Chart';
                            
                            // Trigger chart resize when showing for the first time
                            var chart = window['chart' + chartId];
                            if (chart) {
                                setTimeout(function() {
                                    chart.resize();
                                }, 100);
                            }
                        }
                    };
                }
                </xsl:text>
            </script>
        </xsl:if>
    </xsl:template>

    <!-- Template to create qualitative charts for PerformanceIndicators -->
    <xsl:template match="*[local-name() = 'PerformanceIndicator']" mode="makeQualitativeChart">
        <xsl:variable name="isQualitative" select="@PerformanceIndicatorType = 'Qualitative'"/>
        <xsl:variable name="hasQualitativeData" select="boolean(*[local-name() = 'MeasurementInstance']/*[local-name() = 'TargetResult' or local-name() = 'ActualResult']/*[local-name() = 'Descriptor']/*[local-name() = 'DescriptorValue' and normalize-space(.) != ''])"/>
        <xsl:variable name="chartId" select="generate-id(.)"/>
        <xsl:variable name="measurementDimension" select="normalize-space(*[local-name() = 'MeasurementDimension'])"/>
        
        <xsl:if test="$isQualitative and $hasQualitativeData">
            <div class="chart-visibility-toggle">
                <button class="chart-visibility-button" onclick="toggleQualitativeChartVisibility('{$chartId}')" id="toggleQualBtn{$chartId}">
                    Show Qualitative Analysis
                </button>
            </div>
            
            <div class="chart-content" id="qualChartContent{$chartId}">
                <div class="qualitative-chart-container">
                    <div class="qualitative-chart-title">
                        <xsl:value-of select="$measurementDimension"/>
                        <xsl:text> - Qualitative Analysis</xsl:text>
                    </div>
                    
                    <!-- Comparison View -->
                    <div id="comparisonView{$chartId}" class="qualitative-view">
                        <h4>Target vs Actual Comparison</h4>
                        <div class="comparison-grid">
                            <div class="comparison-item comparison-target">
                                <div class="comparison-header">Target Results</div>
                                <xsl:for-each select="*[local-name() = 'MeasurementInstance']/*[local-name() = 'TargetResult']">
                                    <xsl:variable name="status" select="normalize-space(*[local-name() = 'Descriptor']/*[local-name() = 'DescriptorValue'])"/>
                                    <xsl:variable name="description" select="normalize-space(*[local-name() = 'Description'])"/>
                                    <xsl:if test="$status != '' or $description != ''">
                                        <div style="margin: 8px 0; padding: 5px; background: rgba(255,255,255,0.7); border-radius: 4px;">
                                            <xsl:if test="$status != ''"><strong><xsl:value-of select="$status"/>: </strong></xsl:if>
                                            <xsl:value-of select="$description"/>
                                        </div>
                                    </xsl:if>
                                </xsl:for-each>
                            </div>
                            <div class="comparison-item comparison-actual">
                                <div class="comparison-header">Actual Results</div>
                                <xsl:for-each select="*[local-name() = 'MeasurementInstance']/*[local-name() = 'ActualResult']">
                                    <xsl:variable name="status" select="normalize-space(*[local-name() = 'Descriptor']/*[local-name() = 'DescriptorValue'])"/>
                                    <xsl:variable name="description" select="normalize-space(*[local-name() = 'Description'])"/>
                                    <xsl:if test="$status != '' or $description != ''">
                                        <div style="margin: 8px 0; padding: 5px; background: rgba(255,255,255,0.7); border-radius: 4px;">
                                            <xsl:if test="$status != ''"><strong><xsl:value-of select="$status"/>: </strong></xsl:if>
                                            <xsl:value-of select="$description"/>
                                        </div>
                                    </xsl:if>
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <script type="text/javascript">
                <xsl:text>
                // Global functions for qualitative chart management
                if (typeof toggleQualitativeChartVisibility === 'undefined') {
                    window.toggleQualitativeChartVisibility = function(chartId) {
                        var chartContent = document.getElementById('qualChartContent' + chartId);
                        var toggleBtn = document.getElementById('toggleQualBtn' + chartId);
                        
                        if (chartContent.classList.contains('visible')) {
                            chartContent.classList.remove('visible');
                            toggleBtn.textContent = 'Show Qualitative Analysis';
                        } else {
                            chartContent.classList.add('visible');
                            toggleBtn.textContent = 'Hide Qualitative Analysis';
                        }
                    };
                }
                </xsl:text>
            </script>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>