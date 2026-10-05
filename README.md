# BatchFigResizer

A MATLAB GUI application designed to streamline the post-processing, batch resizing, typography standardization, and export of MATLAB `.fig` files for academic papers, slide decks, and technical reports.

---

## Features

### 1. Batch Resize & Styling
* **Dimension & Grid Presets:** Quickly format figures using built-in presets (Document, Standard Presentation, Ryu Presentation layouts) or define custom width, height, row, and column cell dimensions.
* **Typography & Line Standardization:** Set global font sizes, line widths, scatter dot sizes, and DPI resolution across all loaded figures.
* **Control System Toolbox Compatibility:** Robust handling of complex response plots (such as Bode diagrams and Root Locus plots), preventing dot-indexing errors caused by internal axes wrappers (`wraxes`).
* **Titles & Legends:** Automatically force or strip plot titles, toggle grid visibility, reposition legends, or convert subplot titles into a unified figure legend.
* **Multiple Export Formats:** Export single or batch figures directly to `.png`, `.tif`, `.pdf`, `.eps`, `.svg`, `.jpeg`, or updated `.fig` formats.
* **Live Layout Preview:** Visualizes target cell boundaries alongside an automated slideshow preview of loaded figures.

### 2. Merge Figures
* Combine multiple individual `.fig` files into unified tiled layouts.
* Specify items per output canvas and target dimensions.
* Automatically manage subplot tiles and clean redundant headers.

### 3. Figure Region Selector
* Load any multi-axis `.fig` file to inspect subplots.
* Click and drag horizontally over any subplot to define a shared x-axis interval.
* Interactive red boundary handles to fine-tune region endpoints.
* Full support for both linear and logarithmic x-axis scales.
* Export the cropped subplots directly into a new `.fig` file while preserving axes labels, legends, and styling.

### 4. Selective Figure Copying
* Scan nested directories recursively to filter and copy `.fig` files by plot type.
* Supported filters: **Line Plot**, **Scatter Plot**, **Bar Plot**, **Surface Plot**, **Bode Plot**, **Root Locus Plot**, or **All**.

---

## Installation & Requirements

* **MATLAB Version:** R2020b or newer recommended (requires UI Figures and `tiledlayout` support).
* **Toolboxes:** 
  * MATLAB base system.
  * *(Optional)* Control System Toolbox (required only if generating or inspecting specialized Bode/RLocus figures).

### Setup
1. Clone or download this repository:
   ```bash
   git clone [https://github.com/your-username/BatchFigResizer.git](https://github.com/your-username/BatchFigResizer.git)
   ```
2. Open MATLAB and navigate to the downloaded directory.
3. Run the script in the MATLAB Command Window: `BatchFigResizer`


---

## Usage Guide

### Batch Resizing Figures

1. Navigate to the **Batch Resize** tab.


2. Click **Select .fig Files** (or use **+** to append additional files).


3. Choose a template preset from the dropdown or manually enter total dimensions, rows, and columns.


4. Adjust typography settings (Font Size, Line Width, DPI, and Output Format).


5. Configure layout options such as **Keep Titles**, **Make Titles Legend**, **Equalize Subfigures**, or **Force Grid**.


6. Click **Export Figures**. Resized assets are saved in the source directory with a `_resized` suffix.



### Cropping Shared X-Axis Regions

1. Switch to the **Figure Region Selector** tab.


2. Click **Load .fig File**.


3. Click and drag across the plot area of any subplot to highlight the desired x-axis window.


4. Drag either red border edge to adjust boundaries.


5. Click **Export Selected Region** to save the synchronized cropped figure.



### Merging Figures

1. Switch to the **Merge Figures** tab.


2. Select the figures to merge, set the number of subfigures per output figure, and set the target output size.


3. Select an output folder and click **Merge Figures**.



### Filtering and Copying Figures

1. Switch to the **Copy Figures** tab.


2. Choose a source root directory and a destination folder.


3. Select the desired plot classification (e.g., `Bode Plot`, `Root Locus Plot`, `Line Plot`).


4. Click **Copy Files**.



---

## License

Distributed under the MIT License. See `LICENSE` for details.
