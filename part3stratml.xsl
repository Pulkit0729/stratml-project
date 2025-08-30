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
                <!-- Google Fonts for modern typography -->
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;family=Source+Sans+Pro:wght@300;400;600;700&amp;display=swap" rel="stylesheet"/>
                
                <style type="text/css">
                    /* Modern CSS Reset and Base Styles */
                    *, *::before, *::after {
                        box-sizing: border-box;
                    }
                    
                    html {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        font-size: 16px;
                        line-height: 1.6;
                        overflow: hidden;
                        height: 100vh;
                    }
                    
                    body {
                        margin: 0;
                        padding: 0;
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                        color: #2d3748;
                        background: transparent;
                    }
                    
                    /* Modern Table of Contents */
                    .toc {
                        float: left;
                        width: 22%;
                        height: 100vh;
                        overflow-y: auto;
                        overflow-x: hidden;
                        background: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
                        border-right: 1px solid #e2e8f0;
                        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
                        padding: 0 16px 16px 16px;
                        font-size: 14px;
                        margin: 0;
                        position: relative;
                        top: 0;
                    }
                    
                    .toc::-webkit-scrollbar {
                        width: 6px;
                    }
                    
                    .toc::-webkit-scrollbar-track {
                        background: #f1f5f9;
                    }
                    
                    .toc::-webkit-scrollbar-thumb {
                        background: #cbd5e1;
                        border-radius: 3px;
                    }
                    
                    .toc::-webkit-scrollbar-thumb:hover {
                        background: #94a3b8;
                    }
                    
                    .toctitle {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 18px;
                        font-weight: 600;
                        color: #1e293b;
                        text-align: center;
                        margin: 8px 0 16px 0;
                        padding: 16px 12px;
                        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
                        color: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 12px;
                    }
                    
                    /* Modern Content Area */
                    .content {
                        float: left;
                        width: 78%;
                        height: 100vh;
                        overflow-y: auto;
                        overflow-x: hidden;
                        background: #ffffff;
                        padding: 32px 40px;
                        margin: 0;
                    }
                    
                    .content::-webkit-scrollbar {
                        width: 8px;
                    }
                    
                    .content::-webkit-scrollbar-track {
                        background: #f8fafc;
                    }
                    
                    .content::-webkit-scrollbar-thumb {
                        background: #cbd5e1;
                        border-radius: 4px;
                    }
                    
                    .content::-webkit-scrollbar-thumb:hover {
                        background: #94a3b8;
                    }
                    
                    /* Modern Typography */
                    .doc {
                        font-family: 'Inter', sans-serif;
                        font-size: 16px;
                        line-height: 1.7;
                        color: #374151;
                    }
                    
                    .docheading {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 32px;
                        font-weight: 700;
                        text-align: center;
                        margin: 0 0 16px 0;
                        background: linear-gradient(135deg, #1e293b 0%, #475569 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }
                    
                    .docsubheading {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 24px;
                        font-weight: 600;
                        text-align: center;
                        color: #4f46e5;
                        margin: 0 0 32px 0;
                        padding: 16px 0;
                        border-bottom: 2px solid #e0e7ff;
                    }
                    
                    .sourceheading {
                        font-family: 'Source Sans Pro', monospace;
                        font-size: 14px;
                        color: #6366f1;
                    }
                    
                    .sourceheading-inline {
                        font-family: 'Inter', sans-serif;
                        font-size: 16px;
                        color: #374151;
                        text-align: left;
                        margin: 16px 0;
                        padding: 0;
                        font-weight: 500;
                    }
                    
                    .sourceheading-inline a {
                        color: #4f46e5;
                        text-decoration: none;
                        font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, monospace;
                        font-size: 14px;
                    }
                    
                    .sourceheading-inline a:hover {
                        text-decoration: underline;
                    }
                    
                    .herald {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 16px;
                        font-weight: 600;
                        color: #1e293b;
                    }
                    
                    .subtitle {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 20px;
                        font-weight: 600;
                        color: #1e293b;
                        margin: 24px 0 16px 0;
                        padding: 12px 0;
                        border-left: 4px solid #4f46e5;
                        padding-left: 16px;
                    }
                    
                    /* Simple Administrative Information Layout */
                    .admin-info-simple {
                        display: block;
                        margin: 32px 0;
                        padding: 0;
                        text-align: left;
                    }
                    
                    .admin-section {
                        border-left: 4px solid #4f46e5;
                        padding-left: 20px;
                        margin-bottom: 32px;
                    }
                    
                    .admin-section:last-child {
                        margin-bottom: 0;
                    }
                    
                    .admin-title {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 18px;
                        font-weight: 600;
                        color: #1e293b;
                        margin: 0 0 16px 0;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }
                    
                    /* Inline Admin Section Styles */
                    .admin-inline-section {
                        font-family: 'Inter', sans-serif;
                        font-size: 16px;
                        line-height: 1.6;
                        margin: 16px 0;
                        color: #374151;
                        text-align: left;
                    }
                    
                    .admin-title-inline {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 600;
                        color: #1e293b;
                        font-size: 16px;
                        margin-right: 0;
                    }
                    
                    /* Enhanced styles for organization info */
                    .org-info {
                        font-size: 20px !important;
                        margin: 20px 0 !important;
                    }
                    
                    .org-title {
                        font-size: 20px !important;
                        font-weight: 700 !important;
                        color: #0f172a !important;
                    }
                    
                    .org-info .admin-inline-name {
                        font-size: 20px !important;
                        font-weight: 600 !important;
                    }
                    
                    .admin-simple-field {
                        margin-bottom: 12px;
                        line-height: 1.6;
                    }
                    
                    .admin-simple-label {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 600;
                        color: #475569;
                        display: inline;
                        margin-right: 8px;
                    }
                    
                    .admin-simple-value {
                        font-family: 'Inter', sans-serif;
                        color: #1e293b;
                        display: inline;
                    }
                    
                    .admin-simple-value a {
                        color: #4f46e5;
                        text-decoration: none;
                    }
                    
                    .admin-simple-value a:hover {
                        text-decoration: underline;
                    }
                    
                    /* Inline Admin Styles for Single Line Display */
                    .admin-inline-info {
                        font-family: 'Inter', sans-serif;
                        font-size: 16px;
                        line-height: 1.4;
                        color: #1e293b;
                    }
                    
                    .admin-inline-name {
                        font-weight: 600;
                        color: #1e293b;
                    }
                    
                    .admin-inline-separator {
                        color: #6b7280;
                        font-weight: 400;
                    }
                    
                    .admin-inline-contact {
                        color: #4f46e5;
                        font-weight: 500;
                        text-decoration: none;
                    }
                    
                    .admin-inline-contact:hover {
                        text-decoration: underline;
                    }
                    
                    .stakeholder-simple {
                        margin-top: 20px;
                        padding-top: 16px;
                        border-top: 1px solid #e2e8f0;
                    }
                    
                    .stakeholder-simple-title {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 600;
                        color: #475569;
                        margin-bottom: 12px;
                        font-size: 14px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }
                    
                    .stakeholder-simple-item {
                        margin-bottom: 8px;
                        color: #1e293b;
                        font-size: 14px;
                    }
                    
                    .stakeholder-simple-item::before {
                        content: "\2022 ";
                        color: #4f46e5;
                        font-weight: bold;
                        margin-right: 6px;
                    }
                    
                    .stakeholder-role {
                        color: #6b7280;
                        font-style: italic;
                        font-size: 0.9em;
                    }
                    
                    /* Modern Goal and Objective Styling */
                    .goalhead {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 22px;
                        font-weight: 600;
                        text-align: center;
                        color: #065f46;
                        margin: 16px 0 10px 0;
                        padding: 12px 16px;
                        background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 50%, #dcfce7 100%);
                        border-radius: 16px;
                        border: 2px solid #a7f3d0;
                        box-shadow: 0 8px 32px rgba(5, 150, 105, 0.12);
                        position: relative;
                        overflow: hidden;
                    }
                    
                    .goalhead::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 4px;
                        background: linear-gradient(90deg, #10b981 0%, #059669 50%, #047857 100%);
                    }
                    
                    .goaldesc {
                        text-align: center;
                        margin: 0 auto 24px auto;
                        max-width: 800px;
                        font-size: 16px;
                        color: #4b5563;
                        line-height: 1.7;
                    }
                    
                    .objhead {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 18px;
                        font-weight: 600;
                        color: #1e40af;
                        margin: 20px 0 12px 0;
                        padding: 0;
                        background: none;
                        border: none;
                        box-shadow: none;
                        position: relative;
                    }
                    
                    
                    /* Modern TOC Navigation */
                    .tocentry {
                        margin: 6px 0;
                        padding: 8px 10px;
                        border-radius: 8px;
                        transition: all 0.2s ease;
                        line-height: 1.4;
                        clear: both;
                        display: block;
                        background: transparent;
                        min-height: 16px;
                    }
                    
                    .tocentry:hover {
                        background: #f1f5f9;
                        transform: translateX(4px);
                    }
                    
                    .tocentry a {
                        color: #475569;
                        text-decoration: none;
                        font-weight: 500;
                        display: block;
                        line-height: 1.4;
                        word-wrap: break-word;
                    }
                    
                    .tocentry a:hover {
                        color: #4f46e5;
                    }
                    
                    .tocsubentry {
                        margin: 4px 0 4px 16px;
                        padding: 6px 10px;
                        border-radius: 6px;
                        font-size: 13px;
                        transition: all 0.2s ease;
                        line-height: 1.3;
                        clear: both;
                        display: block;
                        background: transparent;
                        min-height: 14px;
                    }
                    
                    .tocsubentry:hover {
                        background: #e0e7ff;
                        transform: translateX(4px);
                    }
                    
                    .tocsubentry a {
                        color: #64748b;
                        text-decoration: none;
                        font-weight: 400;
                        line-height: 1.3;
                        word-wrap: break-word;
                    }
                    
                    .tocsubentry a:hover {
                        color: #4f46e5;
                    }
                    
                    /* Fix for overlapping goal items */
                    .goal-container {
                        margin-bottom: 16px;
                        clear: both;
                    }
                    
                    .goal-title {
                        cursor: pointer;
                        margin: 6px 0 4px 0;
                        padding: 8px 10px;
                        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                        border-radius: 8px;
                        border: 1px solid #cbd5e1;
                        transition: all 0.3s ease;
                        position: relative;
                        font-weight: 500;
                        color: #1e293b;
                        display: block;
                        clear: both;
                        min-height: 20px;
                        line-height: 1.4;
                    }
                    
                    /* Modern Collapsible Navigation */
                    .toggle-input, .expand-all-toggle {
                        display: none;
                    }
                    
                    .goal-title {
                        cursor: pointer;
                        margin: 6px 0;
                        padding: 8px 10px;
                        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                        border-radius: 8px;
                        border: 1px solid #cbd5e1;
                        transition: all 0.3s ease;
                        position: relative;
                        font-weight: 500;
                        color: #1e293b;
                    }
                    
                    .goal-title:hover {
                        background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%);
                        border-color: #a5b4fc;
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15);
                    }
                    
                    .goal-title::before {
                        content: "";
                        display: inline-block;
                        width: 0;
                        height: 0;
                        border-left: 6px solid #4f46e5;
                        border-top: 4px solid transparent;
                        border-bottom: 4px solid transparent;
                        margin-right: 12px;
                        vertical-align: middle;
                        transition: transform 0.3s ease;
                    }
                    
                    .toggle-input:checked + .goal-title::before {
                        transform: rotate(90deg);
                    }
                    
                    .objectives-container {
                        display: none;
                        margin-left: 20px;
                        padding: 16px;
                        background: #fafafa;
                        border-radius: 8px;
                        border-left: 3px solid #e0e7ff;
                    }
                    
                    .toggle-input:checked ~ .objectives-container {
                        display: block;
                        animation: slideDown 0.3s ease;
                    }
                    
                    @keyframes slideDown {
                        from {
                            opacity: 0;
                            transform: translateY(-10px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
                    
                    /* Modern Expand All Icon */
                    .expand-all-icon {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 20px;
                        height: 20px;
                        background: rgba(255, 255, 255, 0.2);
                        border-radius: 50%;
                        cursor: pointer;
                        position: relative;
                        transition: all 0.3s ease;
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        order: -1;
                    }
                    
                    .expand-all-icon:hover {
                        background: rgba(255, 255, 255, 0.3);
                        transform: scale(1.1);
                    }
                    
                    .expand-all-icon::before,
                    .expand-all-icon::after {
                        content: '';
                        position: absolute;
                        background: white;
                        transition: all 0.3s ease;
                    }
                    
                    .expand-all-icon::before {
                        width: 12px;
                        height: 2px;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                    }
                    
                    .expand-all-icon::after {
                        width: 2px;
                        height: 12px;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        transition: transform 0.3s ease;
                    }
                    
                    .expand-all-toggle:checked ~ .expand-all-icon::after {
                        transform: translate(-50%, -50%) rotate(90deg);
                    }
                    
                    /* Modern Table Styling */
                    .datatable {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0;
                        margin: 12px 0;
                        background: white;
                        border-radius: 12px;
                        overflow: hidden;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                        border: 1px solid #e2e8f0;
                    }
                    
                    .datatable th {
                        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                        padding: 6px 8px;
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 600;
                        color: #1e293b;
                        text-align: left;
                        border-bottom: 2px solid #cbd5e1;
                        font-size: 14px;
                    }
                    
                    .datatable td {
                        padding: 6px 8px;
                        border-bottom: 1px solid #f1f5f9;
                        color: #374151;
                        font-size: 14px;
                        vertical-align: top;
                    }
                    
                    .datatable tr:last-child td {
                        border-bottom: none;
                    }
                    
                    /* Modern Paragraph and Text Styling */
                    .para {
                        margin: 16px 0;
                        line-height: 1.7;
                        color: #374151;
                    }
                    
                    .para-c {
                        margin: 16px 0;
                        text-align: center;
                        line-height: 1.7;
                        color: #374151;
                        font-weight: 500;
                    }
                    
                    /* Table Description Styling */
                    .table-desc {
                        margin: 8px 0;
                        line-height: 1.5;
                        color: #374151;
                        font-size: 14px;
                        text-align: left;
                    }
                    
                    /* Modern Links */
                    a:link {
                        color: #4f46e5;
                        text-decoration: none;
                        font-weight: 500;
                        transition: all 0.2s ease;
                    }
                    
                    a:visited {
                        color: #7c3aed;
                    }
                    
                    a:hover {
                        color: #3730a3;
                        text-decoration: underline;
                        text-decoration-thickness: 2px;
                        text-underline-offset: 3px;
                    }
                    
                    /* Stakeholder and Organization Styling */
                    .orgstaketitle {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 18px;
                        font-weight: 600;
                        color: #1e293b;
                        margin: 20px 0 12px 0;
                        padding: 12px 16px;
                        background: linear-gradient(135deg, #fff7ed 0%, #fed7aa 100%);
                        border-radius: 8px;
                        border-left: 4px solid #f97316;
                    }
                    
                    .orgstakeholder {
                        margin: 8px 0;
                        padding: 16px;
                        background: #ffffff;
                        border-radius: 8px;
                        border: 1px solid #e5e7eb;
                        font-family: 'Inter', sans-serif;
                        font-size: 14px;
                        line-height: 1.5;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                        transition: all 0.2s ease;
                    }
                    
                    .orgstakeholder:hover {
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        transform: translateY(-1px);
                    }
                    
                    .stakeholder-card {
                        margin: 8px 0;
                        padding: 16px;
                        background: #ffffff;
                        border-radius: 8px;
                        border: 1px solid #e5e7eb;
                        font-family: 'Inter', sans-serif;
                        font-size: 14px;
                        line-height: 1.5;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                        transition: all 0.2s ease;
                    }
                    
                    .stakeholder-card:hover {
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        transform: translateY(-1px);
                    }
                    
                    .stakeholder-card-header {
                        font-weight: 600;
                        color: #1e293b;
                        margin-bottom: 8px;
                        padding-bottom: 8px;
                        border-bottom: 1px solid #f1f5f9;
                        display: flex;
                        align-items: center;
                    }
                    
                    .stakeholder-card-field {
                        margin: 6px 0;
                        display: flex;
                        align-items: flex-start;
                    }
                    
                    .stakeholder-card-field .stakeholder-card-value:only-child {
                        width: 100%;
                        margin-left: 0;
                    }
                    
                    .stakeholder-card-label {
                        font-weight: 500;
                        color: #64748b;
                        min-width: 80px;
                        margin-right: 12px;
                        font-size: 13px;
                    }
                    
                    .stakeholder-card-value {
                        color: #374151;
                        flex: 1;
                        font-size: 14px;
                    }
                    
                    .goalstaketitle, .objstaketitle {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 600;
                        color: #1e293b;
                        margin: 24px 0 12px 0;
                        padding: 0;
                        background: none;
                        border: none;
                        font-size: 18px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        border-bottom: 2px solid #e2e8f0;
                        padding-bottom: 8px;
                    }
                    
                    .goalstakeholder, .objstakeholder {
                        margin: 8px 0;
                        padding: 16px;
                        background: #ffffff;
                        border-radius: 8px;
                        border: 1px solid #e5e7eb;
                        font-size: 14px;
                        line-height: 1.5;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                        transition: all 0.2s ease;
                    }
                    
                    .goalstakeholder:hover, .objstakeholder:hover {
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        transform: translateY(-1px);
                    }
                    
                    /* Apply card styling to all stakeholder containers */
                    .orgstakeholder .stakeholder-card-header,
                    .goalstakeholder .stakeholder-card-header,
                    .objstakeholder .stakeholder-card-header {
                        font-weight: 600;
                        color: #1e293b;
                        margin-bottom: 8px;
                        padding-bottom: 8px;
                        border-bottom: 1px solid #f1f5f9;
                        display: flex;
                        align-items: center;
                    }
                    
                    .orgstakeholder .stakeholder-card-field,
                    .goalstakeholder .stakeholder-card-field,
                    .objstakeholder .stakeholder-card-field {
                        margin: 6px 0;
                        display: flex;
                        align-items: flex-start;
                    }
                    
                    .orgstakeholder .stakeholder-card-label,
                    .goalstakeholder .stakeholder-card-label,
                    .objstakeholder .stakeholder-card-label {
                        font-weight: 500;
                        color: #64748b;
                        min-width: 80px;
                        margin-right: 12px;
                        font-size: 13px;
                    }
                    
                    .orgstakeholder .stakeholder-card-value,
                    .goalstakeholder .stakeholder-card-value,
                    .objstakeholder .stakeholder-card-value {
                        color: #374151;
                        flex: 1;
                        font-size: 14px;
                    }
                    
                    /* Utility Classes */
                    .double-break {
                        margin-top: 32px;
                    }
                    
                    .single-break {
                        margin-top: 16px;
                    }
                    
                    .meta {
                        font-size: 12px;
                        color: #6b7280;
                        text-align: right;
                        margin: 8px 0;
                        font-style: italic;
                    }
                    
                    .infotitle {
                        font-weight: 600;
                        margin: 16px 0 8px 0;
                        color: #374151;
                        font-size: 16px;
                    }
                    
                    /* OtherInformation Toggle Styles */
                    .other-info-toggle {
                        background: none;
                        border: 1px solid #d1d5db;
                        border-radius: 4px;
                        padding: 4px 8px;
                        font-size: 11px;
                        color: #6b7280;
                        cursor: pointer;
                        margin: 8px 0;
                        transition: all 0.2s ease;
                        display: inline-flex;
                        align-items: center;
                        gap: 4px;
                    }
                    
                    .other-info-toggle:hover {
                        background-color: #f3f4f6;
                        border-color: #9ca3af;
                        color: #374151;
                    }
                    
                    .other-info-toggle::before {
                        content: "+";
                        font-size: 12px;
                        font-weight: bold;
                        transition: transform 0.2s ease;
                        display: inline-block;
                        margin-right: 4px;
                        width: 12px;
                        text-align: center;
                    }
                    
                    .other-info-toggle.expanded::before {
                        content: "-";
                        transform: none;
                    }
                    
                    .other-information {
                        display: none;
                        margin: 12px 0;
                        padding: 12px;
                        background-color: #f9fafb;
                        border: 1px solid #e5e7eb;
                        border-radius: 6px;
                        font-size: 13px;
                        color: #4b5563;
                        line-height: 1.5;
                    }
                    
                    .other-information.visible {
                        display: block;
                        animation: fadeInSlide 0.3s ease-out;
                    }
                    
                    @keyframes fadeInSlide {
                        from {
                            opacity: 0;
                            transform: translateY(-10px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
                    
                    /* Modern pre and code styling */
                    pre, samp {
                        font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace;
                        font-size: 13px;
                        background: #f8fafc;
                        padding: 12px 16px;
                        border-radius: 8px;
                        border: 1px solid #e2e8f0;
                        overflow-x: auto;
                        line-height: 1.5;
                    }
                    
                    /* Placeholder styling */
                    .placeholder {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 40px;
                        height: 40px;
                        background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
                        color: #64748b;
                        border: 1px solid #cbd5e1;
                        border-radius: 8px;
                        font-size: 12px;
                        font-weight: 500;
                    }
                </style>
                
                <!-- Chart.js library for line charts -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        // Handle expand all/collapse all functionality
                        const expandAllToggle = document.getElementById('expand-all');
                        if (expandAllToggle) {
                            expandAllToggle.addEventListener('change', function() {
                                const allGoalToggles = document.querySelectorAll('.toggle-input');
                                allGoalToggles.forEach(function(toggle) {
                                    toggle.checked = expandAllToggle.checked;
                                });
                            });
                        }
                    });
                    
                    // Function to toggle OtherInformation visibility
                    function toggleOtherInfo() {
                        const content = document.getElementById('otherInfoContent');
                        const toggle = document.getElementById('otherInfoToggle');
                        
                        if (content &amp;&amp; toggle) {
                            if (content.classList.contains('visible')) {
                                content.classList.remove('visible');
                                toggle.classList.remove('expanded');
                            } else {
                                content.classList.add('visible');
                                toggle.classList.add('expanded');
                            }
                        }
                    }
                </script>
                
                <!-- Additional modern styles for charts -->
                <style type="text/css">
                    .chart-container {
                        margin: 32px 0;
                        padding: 24px;
                        background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                        border-radius: 16px;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
                        border: 1px solid #e2e8f0;
                    }
                    
                    .chart-title {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 20px;
                        font-weight: 600;
                        color: #1e293b;
                        margin-bottom: 20px;
                        text-align: center;
                        padding-bottom: 12px;
                        border-bottom: 2px solid #e0e7ff;
                    }
                    
                    .chart-canvas {
                        width: 100% !important;
                        height: 400px !important;
                        border-radius: 12px;
                    }
                    
                    .chart-toggle {
                        margin-bottom: 20px;
                        text-align: center;
                        display: flex;
                        gap: 12px;
                        justify-content: center;
                        flex-wrap: wrap;
                    }
                    
                    .chart-toggle button {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                        padding: 10px 20px;
                        border: none;
                        border-radius: 8px;
                        cursor: pointer;
                        font-family: 'Inter', sans-serif;
                        font-weight: 500;
                        font-size: 14px;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
                    }
                    
                    .chart-toggle button:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
                    }
                    
                    .chart-toggle button.active {
                        background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
                        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
                    }
                    
                    .chart-visibility-toggle {
                        margin: 24px 0;
                        text-align: center;
                    }
                    
                    .chart-visibility-button {
                        background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
                        color: white;
                        padding: 12px 24px;
                        border: none;
                        border-radius: 10px;
                        cursor: pointer;
                        font-family: 'Inter', sans-serif;
                        font-weight: 600;
                        font-size: 15px;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 12px rgba(14, 165, 233, 0.3);
                    }
                    
                    .chart-visibility-button:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(14, 165, 233, 0.4);
                    }
                    
                    .chart-content {
                        display: none;
                        animation: fadeIn 0.4s ease;
                    }
                    
                    .chart-content.visible {
                        display: block;
                    }
                    
                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
                    
                    /* Modern Qualitative Chart Styling */
                    .qualitative-chart-container {
                        margin: 32px 0;
                        padding: 24px;
                        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                        border-radius: 16px;
                        box-shadow: 0 8px 32px rgba(245, 158, 11, 0.15);
                        border: 1px solid #fbbf24;
                    }
                    
                    .qualitative-chart-title {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-size: 20px;
                        font-weight: 600;
                        color: #92400e;
                        margin-bottom: 20px;
                        text-align: center;
                        padding-bottom: 12px;
                        border-bottom: 2px solid #fbbf24;
                    }
                    
                    .comparison-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 24px;
                        margin: 20px 0;
                    }
                    
                    .comparison-item {
                        padding: 20px;
                        border-radius: 12px;
                        border: 2px solid transparent;
                        background: white;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                        transition: all 0.3s ease;
                    }
                    
                    .comparison-item:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                    }
                    
                    .comparison-target {
                        border-color: #3b82f6;
                        background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
                    }
                    
                    .comparison-actual {
                        border-color: #10b981;
                        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
                    }
                    
                    .comparison-header {
                        font-family: 'Source Sans Pro', sans-serif;
                        font-weight: 700;
                        font-size: 18px;
                        margin-bottom: 16px;
                        text-align: center;
                        padding: 12px;
                        border-radius: 8px;
                        color: white;
                    }
                    
                    .comparison-target .comparison-header {
                        background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
                    }
                    
                    .comparison-actual .comparison-header {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                    }
                    
                    .comparison-item > div:not(.comparison-header) {
                        margin: 12px 0;
                        padding: 12px 16px;
                        background: rgba(255, 255, 255, 0.8);
                        border-radius: 8px;
                        border-left: 4px solid;
                        font-size: 14px;
                        line-height: 1.6;
                    }
                    
                    .comparison-target > div:not(.comparison-header) {
                        border-left-color: #3b82f6;
                    }
                    
                    .comparison-actual > div:not(.comparison-header) {
                        border-left-color: #10b981;
                    }
                    
                    /* Responsive Design */
                    @media (max-width: 768px) {
                        .toc {
                            width: 100%;
                            height: auto;
                            float: none;
                            padding: 16px;
                        }
                        
                        .content {
                            width: 100%;
                            float: none;
                            padding: 20px;
                        }
                        
                        .comparison-grid {
                            grid-template-columns: 1fr;
                            gap: 16px;
                        }
                        
                        .chart-toggle {
                            flex-direction: column;
                            align-items: center;
                        }
                        
                        .chart-toggle button {
                            width: 200px;
                        }
                    }
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
                    
                    <!-- OtherInformation Toggle Section -->
                    <xsl:if test="normalize-space($plan/*[local-name(.) = 'OtherInformation'])">
                        <button class="other-info-toggle" onclick="toggleOtherInfo()" id="otherInfoToggle">
                            Other Information
                        </button>
                        <div class="other-information" id="otherInfoContent">
                            <xsl:apply-templates select="$plan/*[local-name(.) = 'OtherInformation']" mode="transform"/>
                        </div>
                    </xsl:if>
                    
                    <xsl:for-each select="$plan//*[local-name(.) = 'AdministrativeInformation']">
                        <xsl:variable name="anchor">
                            <xsl:call-template name="getid" />
                        </xsl:variable>
                        <p class="sourceheading-inline" id="{$anchor}">
                            <xsl:text>Source: </xsl:text>
                            <a href="{*[local-name(.) = 'Source']}" target="_blank">
                                <xsl:value-of select="*[local-name(.) = 'Source']" />
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
                    
                    <!-- Simple Administrative Information Layout -->
                    <div class="admin-info-simple">
                        <xsl:variable name="org" select="$plan/*[local-name(.) = 'StrategicPlanCore']/*[local-name(.) = 'Organization']" />
                        <xsl:if test="normalize-space($org)">
                            <p class="admin-inline-section org-info">
                                <span class="admin-title-inline org-title">Organization: </span>
                                <xsl:apply-templates select="$org" mode="inline" />
                            </p>
                        </xsl:if>
                        
                        <xsl:variable name="submitter" select="$plan//*[local-name(.) = 'Submitter']" />
                        <xsl:if test="normalize-space($submitter)">
                            <p class="admin-inline-section">
                                <span class="admin-title-inline">Submitter: </span>
                                <xsl:apply-templates select="$submitter" mode="inline" />
                            </p>
                        </xsl:if>
                    </div>
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

    <!-- Simple Admin Templates -->
    <xsl:template match="*[local-name(.) = 'Submitter']" mode="simple">
        <xsl:for-each select="*[local-name(.) = 'GivenName' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Given name:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'Surname' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Surname:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'PhoneNumber' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Phone Number:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'EmailAddress' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Email Address:</span>
                <span class="admin-simple-value">
                    <a href="mailto:{.}"><xsl:value-of select="." /></a>
                </span>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'Organization']" mode="simple">
        <xsl:for-each select="*[local-name(.) = 'Name' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Name:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'Acronym' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Acronym:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'Description' and normalize-space(.)]">
            <div class="admin-simple-field">
                <span class="admin-simple-label">Description:</span>
                <span class="admin-simple-value"><xsl:value-of select="." /></span>
            </div>
        </xsl:for-each>
        <xsl:call-template name="stakeholder">
            <xsl:with-param name="level" select="'org'" />
            <xsl:with-param name="mode" select="'simple'" />
        </xsl:call-template>
    </xsl:template>

    <!-- Inline Admin Templates for Single Line Display -->
    <xsl:template match="*[local-name(.) = 'Submitter']" mode="inline">
        <span class="admin-inline-info">
            <xsl:variable name="fullName">
                <xsl:if test="*[local-name(.) = 'GivenName' and normalize-space(.)]">
                    <xsl:value-of select="*[local-name(.) = 'GivenName']"/>
                    <xsl:if test="*[local-name(.) = 'Surname' and normalize-space(.)]">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="*[local-name(.) = 'Surname' and normalize-space(.)]">
                    <xsl:value-of select="*[local-name(.) = 'Surname']"/>
                </xsl:if>
            </xsl:variable>
            
            <xsl:variable name="contact">
                <xsl:choose>
                    <xsl:when test="*[local-name(.) = 'EmailAddress' and normalize-space(.)]">
                        <xsl:value-of select="*[local-name(.) = 'EmailAddress']"/>
                    </xsl:when>
                    <xsl:when test="*[local-name(.) = 'PhoneNumber' and normalize-space(.)]">
                        <xsl:value-of select="*[local-name(.) = 'PhoneNumber']"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:if test="normalize-space($fullName)">
                <span class="admin-inline-name"><xsl:value-of select="normalize-space($fullName)"/></span>
                <xsl:if test="normalize-space($contact)">
                    <span class="admin-inline-separator"> (</span>
                    <xsl:choose>
                        <xsl:when test="*[local-name(.) = 'EmailAddress' and normalize-space(.)]">
                            <a href="mailto:{$contact}" class="admin-inline-contact"><xsl:value-of select="$contact"/></a>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="admin-inline-contact"><xsl:value-of select="$contact"/></span>
                        </xsl:otherwise>
                    </xsl:choose>
                    <span class="admin-inline-separator">)</span>
                </xsl:if>
            </xsl:if>
        </span>
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'Organization']" mode="inline">
        <span class="admin-inline-info">
            <xsl:variable name="orgName" select="normalize-space(*[local-name(.) = 'Name'])"/>
            <xsl:variable name="acronym" select="normalize-space(*[local-name(.) = 'Acronym'])"/>
            
            <xsl:if test="$orgName">
                <span class="admin-inline-name"><xsl:value-of select="$orgName"/></span>
                <xsl:if test="$acronym">
                    <span class="admin-inline-separator"> (</span>
                    <span class="admin-inline-contact"><xsl:value-of select="$acronym"/></span>
                    <span class="admin-inline-separator">)</span>
                </xsl:if>
            </xsl:if>
        </span>
        
        <!-- Display stakeholders for organization -->
        <xsl:if test="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
            <div class="stakeholder-simple">
                <div class="stakeholder-simple-title">Stakeholders:</div>
                <xsl:for-each select="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
                    <div class="orgstakeholder">
                        <div class="stakeholder-card-header">
                            <xsl:choose>
                                <xsl:when test="@StakeholderTypeType = 'Generic_Group'">
                                    <img src="images/group.png" alt="Group" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                                </xsl:when>
                                <xsl:when test="@StakeholderTypeType = 'Person'">
                                    <img src="images/person.png" alt="Person" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                                </xsl:when>
                                <xsl:when test="@StakeholderTypeType = 'Organization'">
                                    <img src="images/organization.png" alt="Organization" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="*[local-name() = 'Name']" />
                        </div>
                        <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                            <div class="stakeholder-card-field">
                                <span class="stakeholder-card-label">Description:</span>
                                <span class="stakeholder-card-value">
                                    <xsl:value-of select="*[local-name() = 'Description']" />
                                </span>
                            </div>
                        </xsl:if>
                        <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                            <div class="stakeholder-card-field">
                                <span class="stakeholder-card-label">Role Type:</span>
                                <span class="stakeholder-card-value">
                                    <xsl:for-each select="*[local-name() = 'RoleType' and normalize-space(.)]">
                                        <xsl:if test="position() > 1">, </xsl:if>
                                        <xsl:value-of select="." />
                                    </xsl:for-each>
                                </span>
                            </div>
                        </xsl:if>
                        <xsl:if test="*[local-name() = 'Role' and normalize-space(.)]">
                            <xsl:for-each select="*[local-name() = 'Role' and normalize-space(.)]">
                                <div class="stakeholder-card-field">
                                    <span class="stakeholder-card-value">
                                        <strong><xsl:value-of select="*[local-name() = 'Name']" /></strong>
                                        <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                                            <span> - <xsl:value-of select="*[local-name() = 'Description']" /></span>
                                        </xsl:if>
                                        <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                                            <span class="stakeholder-role"> (<xsl:value-of select="*[local-name() = 'RoleType']" />)</span>
                                        </xsl:if>
                                    </span>
                                </div>
                            </xsl:for-each>
                        </xsl:if>
                    </div>
                </xsl:for-each>
            </div>
        </xsl:if>
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

    <xsl:template match="*[local-name(.) = 'Organization']" mode="admin-card">
        <xsl:for-each select="*[local-name(.) = 'Name' and normalize-space(.)]">
            <div class="admin-field">
                <div class="admin-field-label">Name:</div>
                <div class="admin-field-value"><xsl:value-of select="." /></div>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'Acronym' and normalize-space(.)]">
            <div class="admin-field">
                <div class="admin-field-label">Acronym:</div>
                <div class="admin-field-value"><xsl:value-of select="." /></div>
            </div>
        </xsl:for-each>
        <xsl:for-each select="*[local-name(.) = 'Description' and normalize-space(.)]">
            <div class="admin-field">
                <div class="admin-field-label">Description:</div>
                <div class="admin-field-value"><xsl:value-of select="." /></div>
            </div>
        </xsl:for-each>
        <xsl:call-template name="stakeholder">
            <xsl:with-param name="level" select="'org'" />
            <xsl:with-param name="mode" select="'admin-card'" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="toc">
        <xsl:param name="tocid" select="'toc'" />
        <xsl:for-each select="*/*[local-name(.) = 'StrategicPlanCore']">
            <input type="checkbox" id="expand-all" class="expand-all-toggle" />
            <p class="toctitle" id="{$tocid}">
                <label for="expand-all" class="expand-all-icon" title="Expand/Collapse All"></label>
                <xsl:text>Table of Contents</xsl:text>
            </p>
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
                <xsl:variable name="valuesID" select="'values-container'" />
                <div class="goal-container">
                    <input type="checkbox" id="toggle-{$valuesID}" class="toggle-input" />
                    <label for="toggle-{$valuesID}" class="goal-title">
                        <a href="#values_">
                            <xsl:text>Value</xsl:text>
                            <xsl:if test="count(*[local-name(.) = 'Value']) > 1">
                                <xsl:text>s</xsl:text>
                            </xsl:if>
                        </a>
                    </label>
                    <div class="objectives-container">
                        <xsl:for-each select="*[local-name(.) = 'Value']">
                            <p class="tocsubentry">
                                <a href="#{generate-id(.)}">
                                    <xsl:apply-templates select="*[local-name(.) = 'Name']" />
                                </a>
                            </p>
                        </xsl:for-each>
                    </div>
                </div>
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

    <xsl:template match="*[local-name(.) = 'OtherInformation']" mode="transform">
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
        <xsl:apply-templates select="strat:OtherInformation" mode="transform" />
        <xsl:apply-templates select="*[contains('Objective  ', local-name(.))]" />
    </xsl:template>

    <xsl:template name="stakeholder">
        <xsl:param name="level" select="'org'" />
        <xsl:param name="mode" select="'normal'" />
        <xsl:if test="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
            <xsl:choose>
                <xsl:when test="$mode = 'simple'">
                    <div class="stakeholder-simple">
                        <div class="stakeholder-simple-title">Stakeholder(s):</div>
                        <xsl:apply-templates select="*[local-name(.) = 'Stakeholder']" mode="simple">
                            <xsl:with-param name="level" select="$level" />
                        </xsl:apply-templates>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <p class="{concat($level, 'staketitle')}">
                        <xsl:text>Stakeholder(s):</xsl:text>
                    </p>
                    <xsl:apply-templates select="*[local-name(.) = 'Stakeholder']">
                        <xsl:with-param name="level" select="$level" />
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'Stakeholder' and normalize-space(.)]">
        <xsl:param name="level" select="'org'" />
        <div class="{concat($level, 'stakeholder')}">
            <div class="stakeholder-card-header">
                <xsl:choose>
                    <xsl:when test="@StakeholderTypeType = 'Generic_Group'">
                        <img src="images/group.png" alt="Group" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                    </xsl:when>
                    <xsl:when test="@StakeholderTypeType = 'Person'">
                        <img src="images/person.png" alt="Person" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                    </xsl:when>
                    <xsl:when test="@StakeholderTypeType = 'Organization'">
                        <img src="images/organization.png" alt="Organization" width="20px" height="20px" style="margin-right: 8px; vertical-align: middle;" />
                    </xsl:when>
                </xsl:choose>
                <xsl:value-of select="*[local-name() = 'Name']" />
            </div>
            <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                <div class="stakeholder-card-field">
                    <span class="stakeholder-card-label">Description:</span>
                    <span class="stakeholder-card-value">
                        <xsl:value-of select="*[local-name() = 'Description']" />
                    </span>
                </div>
            </xsl:if>
            <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                <div class="stakeholder-card-field">
                    <span class="stakeholder-card-label">Role Type:</span>
                    <span class="stakeholder-card-value">
                        <xsl:for-each select="*[local-name() = 'RoleType' and normalize-space(.)]">
                            <xsl:if test="position() > 1">, </xsl:if>
                            <xsl:value-of select="." />
                        </xsl:for-each>
                    </span>
                </div>
            </xsl:if>
            <xsl:if test="*[local-name() = 'Role' and normalize-space(.)]">
                <xsl:for-each select="*[local-name() = 'Role' and normalize-space(.)]">
                    <div class="stakeholder-card-field">
                        <span class="stakeholder-card-value">
                            <strong><xsl:value-of select="*[local-name() = 'Name']" /></strong>
                            <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                                <span> - <xsl:value-of select="*[local-name() = 'Description']" /></span>
                            </xsl:if>
                            <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                                <span class="stakeholder-role"> (<xsl:value-of select="*[local-name() = 'RoleType']" />)</span>
                            </xsl:if>
                        </span>
                    </div>
                </xsl:for-each>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="*[local-name(.) = 'Stakeholder' and normalize-space(.)]" mode="simple">
        <xsl:param name="level" select="'org'" />
        <div class="stakeholder-simple-item">
            <strong><xsl:value-of select="*[local-name() = 'Name']" /></strong>
            <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                <span> - <xsl:value-of select="*[local-name() = 'Description']" /></span>
            </xsl:if>
            <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                <span class="stakeholder-role"> (<xsl:for-each select="*[local-name() = 'RoleType' and normalize-space(.)]">
                    <xsl:if test="position() > 1">, </xsl:if>
                    <xsl:value-of select="." />
                </xsl:for-each>)</span>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template name="name-desc-role">
        <div class="stakeholder-card">
            <div class="stakeholder-card-header">
                <xsl:value-of select="*[local-name() = 'Name']" />
            </div>
            <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                <div class="stakeholder-card-field">
                    <span class="stakeholder-card-label">Description:</span>
                    <span class="stakeholder-card-value">
                        <xsl:value-of select="*[local-name() = 'Description']" />
                    </span>
                </div>
            </xsl:if>
            <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                <div class="stakeholder-card-field">
                    <span class="stakeholder-card-label">Role Type:</span>
                    <span class="stakeholder-card-value">
                        <xsl:for-each select="*[local-name() = 'RoleType' and normalize-space(.)]">
                            <xsl:if test="position() > 1">, </xsl:if>
                            <xsl:value-of select="." />
                        </xsl:for-each>
                    </span>
                </div>
            </xsl:if>
            <xsl:if test="*[local-name() = 'Role' and normalize-space(.)]">
                <xsl:for-each select="*[local-name() = 'Role' and normalize-space(.)]">
                    <div class="stakeholder-card-field">
                        <span class="stakeholder-card-value">
                            <strong><xsl:value-of select="*[local-name() = 'Name']" /></strong>
                            <xsl:if test="*[local-name() = 'Description' and normalize-space(.)]">
                                <span> - <xsl:value-of select="*[local-name() = 'Description']" /></span>
                            </xsl:if>
                            <xsl:if test="*[local-name() = 'RoleType' and normalize-space(.)]">
                                <span class="stakeholder-role"> (<xsl:value-of select="*[local-name() = 'RoleType']" />)</span>
                            </xsl:if>
                        </span>
                    </div>
                </xsl:for-each>
            </xsl:if>
        </div>
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
                            <xsl:call-template name="format-number-with-commas">
                                <xsl:with-param name="number" select="*[local-name(.) = 'NumberOfUnits']"/>
                            </xsl:call-template>
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
            <p class="table-desc">
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

    <!-- Template to format numbers with commas -->
    <xsl:template name="format-number-with-commas">
        <xsl:param name="number"/>
        <xsl:choose>
            <xsl:when test="string-length($number) > 3">
                <xsl:variable name="remainder" select="string-length($number) mod 3"/>
                <xsl:choose>
                    <xsl:when test="$remainder = 0">
                        <xsl:call-template name="add-commas">
                            <xsl:with-param name="text" select="$number"/>
                            <xsl:with-param name="position" select="3"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring($number, 1, $remainder)"/>
                        <xsl:if test="string-length($number) > $remainder">,</xsl:if>
                        <xsl:call-template name="add-commas">
                            <xsl:with-param name="text" select="substring($number, $remainder + 1)"/>
                            <xsl:with-param name="position" select="3"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$number"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Helper template to add commas recursively -->
    <xsl:template name="add-commas">
        <xsl:param name="text"/>
        <xsl:param name="position"/>
        <xsl:choose>
            <xsl:when test="string-length($text) > $position">
                <xsl:value-of select="substring($text, 1, $position)"/>
                <xsl:text>,</xsl:text>
                <xsl:call-template name="add-commas">
                    <xsl:with-param name="text" select="substring($text, $position + 1)"/>
                    <xsl:with-param name="position" select="3"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
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
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            var label = context.dataset.label || '';
                                            if (label) {
                                                label += ': ';
                                            }
                                            if (context.parsed.y !== null) {
                                                label += context.parsed.y.toLocaleString();
                                            }
                                            return label;
                                        }
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: false,
                                    title: {
                                        display: true,
                                        text: '</xsl:text><xsl:value-of select="$unitOfMeasurement"/><xsl:text>'
                                    },
                                    ticks: {
                                        callback: function(value, index, values) {
                                            return value.toLocaleString();
                                        }
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