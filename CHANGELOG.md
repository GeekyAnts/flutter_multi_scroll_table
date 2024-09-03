## 1.1.0 - 2024-09-03

### Added

- **`dataList` Support:** Added support for providing data in a row-wise format using the `dataList` parameter. This allows users to define their table data row by row, and it is automatically converted to the previously used column-wise format internally.
- **`jsonDataList` Handling:** Implemented functionality to automatically generate headers from the keys of JSON data provided through `jsonDataList` when explicit headers are not passed. Missing data in the JSON is now replaced with "--"
- **Row-Specific Customization:** Introduced the `onGenerateRowConfiguration` callback, enabling row-specific customizations like background color and text style for each cell.
- **Fixed Column Support:** Added the ability to define a fixed number of columns (`fixedCount`) that do not scroll horizontally with the rest of the table.
- **Sort by Column:** Added the ability to sort table columns by clicking on the header. You can now organize your data in ascending or descending order.
- **`ResizableColumn` Updates:** Improved the `ResizableColumn` widget to support expandable columns, draggable resizing, and the application of header-specific styles.

### Changed

- **Headers with Priority:** Enhanced the headers list to accept a `priority` parameter, allowing custom prioritization of headers. The priority system ensures headers are ordered correctly based on user-defined priorities.
- **Error Handling:** Improved error handling for cases where the number of columns provided does not match the number of headers.
- **Internal Refactoring:** Refactored the internal logic for handling `jsonDataList` and `dataList` to ensure consistent behavior across different data formats.

### Fixed

- **Expandable Columns:** Fixed issues related to expandable columns where they would not properly adjust their width based on available space.
- **Data Replacement:** Resolved bugs related to missing data handling, ensuring "--" is correctly displayed where data is unavailable.

### Documentation

- Updated the README file to include examples of using `dataList` and `jsonDataList`, along with explanations of the new features like row-specific configurations and fixed columns.

## 0.0.1

- Initial release
