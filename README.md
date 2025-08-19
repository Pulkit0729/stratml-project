# StratML Performance Report with Interactive Charts

This project enhances the StratML (Strategy Markup Language) Part 2 performance reporting system with interactive line charts for better data visualization and analysis.

## ?? Overview

StratML Part 2 is an ISO standard (ISO 17469) for representing performance plans and reports in XML format. This enhanced version transforms the traditional table-based performance data into dynamic, interactive charts alongside the existing tables.

## ?? Recent Enhancements (August 2025)

### Interactive Chart Visualization
- **Line Charts**: Added Chart.js-powered line charts for each Performance Indicator
- **Dual Data Lines**: Displays both Target (baseline) and Actual performance data
- **Time-Series Analysis**: Charts show performance trends over time periods
- **Interactive Features**: Hover tooltips, chart type switching, responsive design

### Key Features Added:
1. **Chart.js Integration**: Modern charting library for professional visualizations
2. **Responsive Design**: Charts adapt to different screen sizes
3. **Chart Type Toggle**: Switch between line and bar chart views
4. **Smart Data Processing**: Automatic extraction and sorting of measurement data
5. **Professional Styling**: Clean, modern appearance with consistent color schemes


## ?? How to Use

**Chart Interaction**:
   - **Hover**: Over data points to see exact values
   - **Toggle**: Click "Line Chart" or "Bar Chart" buttons to switch views
   - **Legend**: Click legend items to show/hide data series

### Sample Data Structure
Your StratML XML should contain Performance Indicators with Measurement Instances:

```xml
<PerformanceIndicator>
    <MeasurementDimension>Procedural Justice</MeasurementDimension>
    <UnitOfMeasurement>Score</UnitOfMeasurement>
    <MeasurementInstance>
        <TargetResult>
            <StartDate>2022-01-01</StartDate>
            <EndDate>2022-12-31</EndDate>
            <NumberOfUnits>6.82</NumberOfUnits>
        </TargetResult>
        <ActualResult>
            <StartDate>2022-01-01</StartDate>
            <EndDate>2022-12-31</EndDate>
            <NumberOfUnits>6.02</NumberOfUnits>
        </ActualResult>
    </MeasurementInstance>
    <!-- More measurement instances... -->
</PerformanceIndicator>
```

## ?? Technical Implementation

### Chart Generation Process
1. **Data Extraction**: XSLT templates extract Target and Actual values from MeasurementInstance elements
2. **Data Processing**: JavaScript sorts data chronologically and handles missing values
3. **Chart Rendering**: Chart.js creates interactive visualizations
4. **Styling**: CSS provides professional appearance and responsive behavior

### Key XSLT Templates Added:
- `makeMeasurementInstanceChart`: Main template for chart generation
- Enhanced CSS for chart containers and styling
- JavaScript for Chart.js configuration and interactivity

### Dependencies:
- **Chart.js 4.x**: Loaded from CDN (https://cdn.jsdelivr.net/npm/chart.js)
- **Modern Web Browser**: Support for ES6 JavaScript and Canvas API

## ?? Chart Features

### Visual Elements:
- **Target Line**: Teal color (`rgb(75, 192, 192)`) representing benchmarks/goals
- **Actual Line**: Red color (`rgb(255, 99, 132)`) representing actual performance
- **Responsive Canvas**: Charts automatically resize with container
- **Professional Styling**: Clean borders, proper spacing, readable fonts

### Interactive Elements:
- **Hover Tooltips**: Show exact values and dates
- **Chart Type Toggle**: Switch between line and bar visualizations
- **Legend Control**: Show/hide data series
- **Zoom/Pan**: Built-in Chart.js interaction capabilities

## ??? Customization Guide

### Color Schemes:
Modify chart colors in the XSLT template:
```javascript
borderColor: 'rgb(75, 192, 192)',  // Target line color
backgroundColor: 'rgba(75, 192, 192, 0.2)',  // Target fill color
```

### Chart Configuration:
Adjust Chart.js options for different behaviors:
```javascript
options: {
    responsive: true,
    maintainAspectRatio: false,
    // Add custom configuration here
}
```

### Styling:
Modify CSS classes in the stylesheet:
- `.chart-container`: Main chart wrapper styling
- `.chart-title`: Chart title appearance
- `.chart-toggle`: Button styling for chart type switching
