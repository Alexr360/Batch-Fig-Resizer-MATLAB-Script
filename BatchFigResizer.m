function BatchFigResizer()
    appVersion = '1.0.0';
    fig = uifigure('Name', ['Figure Layout Resizer v' appVersion], 'Position', [100 100 920 680]);
    rootGrid = uigridlayout(fig, [1, 1]);
    rootGrid.Padding = [0 0 0 0];
    tabs = uitabgroup(rootGrid);
    
    resizeTab = uitab(tabs, 'Title', 'Batch Resize');
    mergeTab = uitab(tabs, 'Title', 'Merge Figures');
    regionTab = uitab(tabs, 'Title', 'Figure Region Selector');
    copyTab = uitab(tabs, 'Title', 'Copy Figures');
    updateTab = uitab(tabs, 'Title', 'Updates');
    
    mainGrid = uigridlayout(resizeTab, [1, 2]);
    mainGrid.ColumnWidth = {360, '1x'};
    mainGrid.Padding = [15 15 15 15];
    mainGrid.ColumnSpacing = 15;
    
    leftGrid = uigridlayout(mainGrid, [4, 1]);
    leftGrid.RowHeight = {'fit', 'fit', 'fit', '1x'};
    leftGrid.Padding = [0 0 0 0];
    leftGrid.RowSpacing = 12;
    
    presetPanel = uipanel(leftGrid, 'Title', 'Preset');
    presetGrid = uigridlayout(presetPanel, [2, 2]);
    presetGrid.ColumnWidth = {80, '1x'};
    presetGrid.RowHeight = {24, 38};
    presetGrid.Padding = [10 10 10 10];
    presetGrid.RowSpacing = 6;
    uilabel(presetGrid, 'Text', 'Template:');
    presetDropdown = uidropdown(presetGrid, 'Items', {'Ryu Presentation Full', 'Ryu Presentation Short', 'Presentation', 'Document', 'Custom'}, 'Value', 'Ryu Presentation Full');
    presetDescLabel = uilabel(presetGrid, 'WordWrap', 'on', 'FontColor', [0.35 0.35 0.35], 'FontSize', 11, 'VerticalAlignment', 'top');
    presetDescLabel.Layout.Row = 2;
    presetDescLabel.Layout.Column = [1 2];
    
    dimPanel = uipanel(leftGrid, 'Title', 'Canvas & Grid Dimensions');
    dimGrid = uigridlayout(dimPanel, [3, 4]);
    dimGrid.ColumnWidth = {'1x', 55, '1x', 55};
    dimGrid.RowHeight = {24, 24, 20};
    dimGrid.Padding = [10 10 10 10];
    dimGrid.RowSpacing = 8;
    uilabel(dimGrid, 'Text', 'Total Width (in):');
    widthEdit = uieditfield(dimGrid, 'numeric', 'Value', 10.0, 'Limits', [0 Inf], 'LowerLimitInclusive', 'off');
    uilabel(dimGrid, 'Text', 'Total Height (in):');
    heightEdit = uieditfield(dimGrid, 'numeric', 'Value', 4.86, 'Limits', [0 Inf], 'LowerLimitInclusive', 'off');
    uilabel(dimGrid, 'Text', 'Columns:');
    colsEdit = uieditfield(dimGrid, 'numeric', 'Value', 2, 'Limits', [1 Inf], 'RoundFractionalValues', 'on');
    uilabel(dimGrid, 'Text', 'Rows:');
    rowsEdit = uieditfield(dimGrid, 'numeric', 'Value', 1, 'Limits', [1 Inf], 'RoundFractionalValues', 'on');
    cellSummaryLabel = uilabel(dimGrid, 'Text', '', 'FontColor', [0.15 0.4 0.7], 'FontWeight', 'bold');
    cellSummaryLabel.Layout.Row = 3;
    cellSummaryLabel.Layout.Column = [1 4];
    
    stylePanel = uipanel(leftGrid, 'Title', 'Typography & Export Settings');
    styleGrid = uigridlayout(stylePanel, [7, 4]);
    styleGrid.ColumnWidth = {'1x', 55, '1x', 55};
    styleGrid.RowHeight = {24, 24, 24, 24, 24, 24, 24};
    styleGrid.Padding = [10 10 10 10];
    styleGrid.RowSpacing = 8;
    uilabel(styleGrid, 'Text', 'Font Size (pt):');
    fontSizeEdit = uieditfield(styleGrid, 'numeric', 'Value', 12, 'Limits', [1 Inf]);
    uilabel(styleGrid, 'Text', 'Line Width (pt):');
    lineWidthEdit = uieditfield(styleGrid, 'numeric', 'Value', 1.2, 'Limits', [0.1 Inf]);
    uilabel(styleGrid, 'Text', 'DPI / Res:');
    dpiEdit = uieditfield(styleGrid, 'numeric', 'Value', 500, 'Limits', [100 Inf], 'RoundFractionalValues', 'on');
    uilabel(styleGrid, 'Text', 'Format:');
    formatDropdown = uidropdown(styleGrid, 'Items', {'.tif', '.png', '.pdf', '.jpeg', '.svg', '.eps', '.fig'}, 'Value', '.tif');
    uilabel(styleGrid, 'Text', 'Dot Size (px):');
    dotSizeEdit = uieditfield(styleGrid, 'numeric', 'Value', 5, 'Limits', [1 Inf]);
    uilabel(styleGrid, 'Text', ''); 
    uilabel(styleGrid, 'Text', ''); 
    
    keepTitlesCheck = uicheckbox(styleGrid, 'Text', 'Keep Titles', 'Value', false);
    keepTitlesCheck.Layout.Row = 4;
    keepTitlesCheck.Layout.Column = [1 2];
    forceGridContainer = uigridlayout(styleGrid, [1, 2]);
    forceGridContainer.Layout.Row = 4;
    forceGridContainer.Layout.Column = [3 4];
    forceGridContainer.ColumnWidth = {'fit', '1x'};
    forceGridContainer.RowHeight = {24};
    forceGridContainer.Padding = [0 0 0 0];
    forceGridContainer.ColumnSpacing = 6;
    forceGridCheck = uicheckbox(forceGridContainer, 'Text', 'Force Grid', 'Value', true);
    forceGridDropdown = uidropdown(forceGridContainer, 'Items', {'Enable', 'Disable'}, 'ItemsData', {'Force Enable', 'Force Disable'}, 'Value', 'Force Disable');
    makeTitlesLegendCheck = uicheckbox(styleGrid, 'Text', 'Make Titles Legend', 'Value', false);
    makeTitlesLegendCheck.Layout.Row = 5;
    makeTitlesLegendCheck.Layout.Column = [1 2];
    equalizeSubfiguresCheck = uicheckbox(styleGrid, 'Text', 'Equalize Subfigures', 'Value', false);
    equalizeSubfiguresCheck.Layout.Row = 5;
    equalizeSubfiguresCheck.Layout.Column = [3 4];
    legendLabel = uilabel(styleGrid, 'Text', 'Legend position:');
    legendLabel.Layout.Row = 6;
    legendLabel.Layout.Column = 1;
    legendDropdown = uidropdown(styleGrid, 'Items', {'Keep original', 'Above plot', 'Below plot', 'Right outside', 'Left outside', 'Best inside', 'Top right', 'Top left', 'Bottom right', 'Bottom left'}, 'ItemsData', {'original', 'northoutside', 'southoutside', 'eastoutside', 'westoutside', 'best', 'northeast', 'northwest', 'southeast', 'southwest'}, 'Value', 'northoutside');
    legendDropdown.Layout.Row = 6;
    legendDropdown.Layout.Column = [2 4];
    marginLabel = uilabel(styleGrid, 'Text', 'Legend Margin (in):');
    marginLabel.Layout.Row = 7;
    marginLabel.Layout.Column = [1 2];
    legendMarginEdit = uieditfield(styleGrid, 'numeric', 'Value', 0, 'Limits', [0 Inf]);
    legendMarginEdit.Layout.Row = 7;
    legendMarginEdit.Layout.Column = [3 4];
    
    actionPanel = uipanel(leftGrid, 'Title', 'Batch Operations');
    actionGrid = uigridlayout(actionPanel, [2, 3]);
    actionGrid.ColumnWidth = {130, 32, '1x'};
    actionGrid.RowHeight = {30, 32};
    actionGrid.Padding = [10 10 10 10];
    actionGrid.RowSpacing = 8;
    actionGrid.ColumnSpacing = 6;
    files = {};
    batchPreviewImages = {};
    batchPreviewNames = {};
    batchPreviewIndex = 1;
    batchPreviewTimer = [];
    selectBtn = uibutton(actionGrid, 'Text', 'Select .fig Files', 'ButtonPushedFcn', @(btn,event) selectFiles(false));
    addBtn = uibutton(actionGrid, 'Text', '+', 'FontWeight', 'bold', 'ButtonPushedFcn', @(btn,event) selectFiles(true));
    fileLabel = uilabel(actionGrid, 'Text', 'No files loaded', 'FontColor', [0.4 0.4 0.4]);
    exportBtn = uibutton(actionGrid, 'Text', 'Export Figures', 'FontWeight', 'bold', 'ButtonPushedFcn', @(btn,event) exportFigs());
    exportBtn.Layout.Row = 2;
    exportBtn.Layout.Column = [1 3];
    
    rightColumnGrid = uigridlayout(mainGrid, [2, 1]);
    rightColumnGrid.RowHeight = {'1x', '1x'};
    rightColumnGrid.Padding = [0 0 0 0];
    rightColumnGrid.RowSpacing = 12;
    rightPanel = uipanel(rightColumnGrid, 'Title', 'Layout Preview');
    rightGrid = uigridlayout(rightPanel, [1, 1]);
    rightGrid.Padding = [10 10 10 10];
    ax = uiaxes(rightGrid);
    xlabel(ax, 'Width (in)');
    ylabel(ax, 'Height (in)');
    disableDefaultInteractivity(ax);
    originalFiguresPanel = uipanel(rightColumnGrid, 'Title', 'Original Figures');
    originalFiguresGrid = uigridlayout(originalFiguresPanel, [1, 1]);
    originalFiguresGrid.Padding = [10 10 10 10];
    originalAx = uiaxes(originalFiguresGrid);
    originalAx.XTick = [];
    originalAx.YTick = [];
    originalAx.Box = 'on';
    originalAx.Color = [0.96 0.96 0.96];
    originalAx.Toolbar.Visible = 'off';
    disableDefaultInteractivity(originalAx);
    title(originalAx, 'Select .fig files to preview the originals');
    
    mergeGrid = uigridlayout(mergeTab, [1, 2]);
    mergeGrid.ColumnWidth = {360, '1x'};
    mergeGrid.Padding = [15 15 15 15];
    mergeGrid.ColumnSpacing = 15;
    mLeftGrid = uigridlayout(mergeGrid, [4, 1]);
    mLeftGrid.RowHeight = {'fit', 'fit', 'fit', '1x'};
    mLeftGrid.Padding = [0 0 0 0];
    mLeftGrid.RowSpacing = 12;
    
    mFilePanel = uipanel(mLeftGrid, 'Title', 'Select Files to Merge');
    mFileGrid = uigridlayout(mFilePanel, [2, 3]);
    mFileGrid.ColumnWidth = {130, 32, '1x'};
    mFileGrid.RowHeight = {30, 32};
    mFileGrid.Padding = [10 10 10 10];
    
    mergeFilesList = {};
    mergeOutDir = '';
    mSelectBtn = uibutton(mFileGrid, 'Text', 'Select .fig Files', 'ButtonPushedFcn', @(~,~) selectMergeFiles(false));
    mAddBtn = uibutton(mFileGrid, 'Text', '+', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) selectMergeFiles(true));
    mFileLabel = uilabel(mFileGrid, 'Text', 'No files loaded', 'FontColor', [0.4 0.4 0.4]);
    
    mSetPanel = uipanel(mLeftGrid, 'Title', 'Merge Settings');
    mSetGrid = uigridlayout(mSetPanel, [6, 2]);
    mSetGrid.ColumnWidth = {'1x', 90};
    mSetGrid.RowHeight = {24, 24, 24, 24, 24, 'fit'};
    mSetGrid.Padding = [10 10 10 10];
    
    uilabel(mSetGrid, 'Text', 'Figures per output:');
    mFigsPerOut = uieditfield(mSetGrid, 'numeric', 'Value', 10, 'Limits', [1 Inf], 'RoundFractionalValues', 'on');
    uilabel(mSetGrid, 'Text', 'Target Width (in):');
    mWEdit = uieditfield(mSetGrid, 'numeric', 'Value', 10.0, 'Limits', [0 Inf]);
    uilabel(mSetGrid, 'Text', 'Target Height (in):');
    mHEdit = uieditfield(mSetGrid, 'numeric', 'Value', 4.86, 'Limits', [0 Inf]);
    mRmTitleCheck = uicheckbox(mSetGrid, 'Text', 'Remove Titles from subfigures', 'Value', false);
    mRmTitleCheck.Layout.Column = [1 2];
    
    uilabel(mSetGrid, 'Text', 'Output Folder:');
    mOutDirBtn = uibutton(mSetGrid, 'Text', 'Browse...', 'ButtonPushedFcn', @(~,~) pickOutputFolder());
    mOutDirLabel = uilabel(mSetGrid, 'Text', 'Default: Source folder', 'FontColor', [0.4 0.4 0.4], 'WordWrap', 'on');
    mOutDirLabel.Layout.Column = [1 2];
    
    mActionPanel = uipanel(mLeftGrid, 'Title', 'Action');
    mActGrid = uigridlayout(mActionPanel, [1, 1]);
    mActGrid.Padding = [10 10 10 10];
    mMergeBtn = uibutton(mActGrid, 'Text', 'Merge Figures', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) runMerge());
    
    mRightPanel = uipanel(mergeGrid, 'Title', 'Selected Files for Merge');
    mRightGrid = uigridlayout(mRightPanel, [1, 1]);
    mRightGrid.Padding = [10 10 10 10];
    mListbox = uilistbox(mRightGrid, 'Items', {});
    
    regionGrid = uigridlayout(regionTab, [1, 2]);
    regionGrid.ColumnWidth = {285, '1x'};
    regionGrid.Padding = [15 15 15 15];
    regionGrid.ColumnSpacing = 15;
    regionPanel = uipanel(regionGrid, 'Title', 'Subplot Region Selector');
    regionControlGrid = uigridlayout(regionPanel, [7, 1]);
    regionControlGrid.RowHeight = {'fit', 'fit', 40, 34, 34, '1x', 'fit'};
    regionControlGrid.Padding = [14 14 14 14];
    regionControlGrid.RowSpacing = 10;
    uilabel(regionControlGrid, 'Text', 'Load a .fig file, then drag horizontally over any subplot in the preview to choose the shared x-axis region. Drag either red edge afterward to fine-tune it.', 'WordWrap', 'on', 'FontSize', 13, 'VerticalAlignment', 'top');
    uilabel(regionControlGrid, 'Text', 'The selected x-axis region is applied to every subplot. Each plot keeps its own y-axis, titles, labels, legends, styling, and layout.', 'WordWrap', 'on', 'FontColor', [0.35 0.35 0.35], 'VerticalAlignment', 'top');
    regionLoadBtn = uibutton(regionControlGrid, 'Text', 'Load .fig File', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) loadRegionPreview());
    regionClearBtn = uibutton(regionControlGrid, 'Text', 'Clear Selection', 'Enable', 'off', 'ButtonPushedFcn', @(~,~) clearPreviewSelection());
    regionExportBtn = uibutton(regionControlGrid, 'Text', 'Export Selected Region', 'FontWeight', 'bold', 'Enable', 'off', 'ButtonPushedFcn', @(~,~) exportRegionFigure());
    regionStatusLabel = uilabel(regionControlGrid, 'Text', 'Ready', 'FontColor', [0.35 0.35 0.35], 'WordWrap', 'on', 'VerticalAlignment', 'bottom');
    regionStatusLabel.Layout.Row = 7;
    regionPreviewPanel = uipanel(regionGrid, 'Title', 'Figure Preview');
    regionPreviewGrid = uigridlayout(regionPreviewPanel, [1, 1]);
    regionPreviewGrid.Padding = [10 10 10 10];
    regionPreviewAx = uiaxes(regionPreviewGrid);
    regionPreviewAx.XTick = [];
    regionPreviewAx.YTick = [];
    regionPreviewAx.Box = 'on';
    regionPreviewAx.Color = [0.96 0.96 0.96];
    regionPreviewAx.Toolbar.Visible = 'off';
    disableDefaultInteractivity(regionPreviewAx);
    title(regionPreviewAx, 'Load a .fig file to begin');
    
    copyGrid = uigridlayout(copyTab, [1, 2]);
    copyGrid.ColumnWidth = {360, '1x'};
    copyGrid.Padding = [15 15 15 15];
    copyGrid.ColumnSpacing = 15;
    
    cLeftGrid = uigridlayout(copyGrid, [2, 1]);
    cLeftGrid.RowHeight = {'fit', 'fit'};
    cLeftGrid.Padding = [0 0 0 0];
    cLeftGrid.RowSpacing = 12;
    
    cFilePanel = uipanel(cLeftGrid, 'Title', 'Select Source & Destination');
    cFileGrid = uigridlayout(cFilePanel, [3, 2]);
    cFileGrid.ColumnWidth = {100, '1x'};
    cFileGrid.RowHeight = {30, 30, 30};
    cFileGrid.Padding = [10 10 10 10];
    
    cSrcBtn = uibutton(cFileGrid, 'Text', 'Select Source', 'ButtonPushedFcn', @(~,~) selectCSrc());
    cSrcLbl = uilabel(cFileGrid, 'Text', 'None selected', 'WordWrap', 'on');
    
    cDestBtn = uibutton(cFileGrid, 'Text', 'Select Dest', 'ButtonPushedFcn', @(~,~) selectCDest());
    cDestLbl = uilabel(cFileGrid, 'Text', 'None selected', 'WordWrap', 'on');
    
    uilabel(cFileGrid, 'Text', 'Plot Type:');
    cTypeDrop = uidropdown(cFileGrid, 'Items', {'All', 'Line Plot', 'Scatter Plot', 'Bar Plot', 'Surface Plot', 'Bode Plot', 'Root Locus Plot'});
    
    cActPanel = uipanel(cLeftGrid, 'Title', 'Action');
    cActGrid = uigridlayout(cActPanel, [1, 1]);
    cActGrid.Padding = [10 10 10 10];
    cCopyBtn = uibutton(cActGrid, 'Text', 'Copy Files', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) runCopy());
    
    cRightPanel = uipanel(copyGrid, 'Title', 'Status Log');
    cRightGrid = uigridlayout(cRightPanel, [1, 1]);
    cRightGrid.Padding = [10 10 10 10];
    cStatusLog = uilistbox(cRightGrid, 'Items', {'Ready to copy...'});
    
    uUpdateGrid = uigridlayout(updateTab, [4, 1]);
    uUpdateGrid.RowHeight = {40, 40, 40, '1x'};
    uUpdateGrid.Padding = [20 20 20 20];
    uUpdateGrid.RowSpacing = 15;
    
    uilabel(uUpdateGrid, 'Text', sprintf('Current Version: %s', appVersion), 'FontSize', 16, 'FontWeight', 'bold');
    
    checkUpdateBtn = uibutton(uUpdateGrid, 'Text', 'Check for Updates', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) manualCheckForUpdates());
    checkUpdateBtn.Layout.Row = 2;
    checkUpdateBtn.Layout.Column = 1;
    
    updateStatusLbl = uilabel(uUpdateGrid, 'Text', 'Ready to check for updates.', 'WordWrap', 'on', 'FontSize', 14);
    updateStatusLbl.Layout.Row = 3;
    updateStatusLbl.Layout.Column = 1;
    
    downloadUpdateBtn = uibutton(uUpdateGrid, 'Text', 'Download Update', 'Enable', 'off', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) openGitHubRelease());
    downloadUpdateBtn.Layout.Row = 4;
    downloadUpdateBtn.Layout.Column = 1;
    
    regionSourceFig = [];
    regionSourcePath = '';
    regionSourceAxes = [];
    regionAxesPreviewPositions = [];
    regionOriginalXLimits = [];
    regionAxesXScales = {};
    regionAxesXDirections = {};
    regionPreviewImage = [];
    regionPreviewImageHandle = [];
    regionSelectionRects = [];
    regionSelectedAxesIndex = [];
    regionDragStartX = [];
    regionDragMode = '';
    regionDragInitialLimits = [];
    regionSelectedXLimits = [];
    
    cSrcPath = '';
    cDestPath = '';
    
    fig.CloseRequestFcn = @(~,~) closeApplication();
    presetDropdown.ValueChangedFcn = @(~,~) applyPreset();
    inputs = [widthEdit, heightEdit, colsEdit, rowsEdit];
    for inp = inputs
        inp.ValueChangedFcn = @(~,~) handleManualChange();
    end
    applyPreset();
    checkForUpdates();
    
    function checkForUpdates()
        try
            opts = weboptions('Timeout', 3);
            rawURL = 'https://raw.githubusercontent.com/Alexr360/Batch-Fig-Resizer-MATLAB-Script/main/BatchFigResizer.m';
            remoteCode = webread(rawURL, opts);
            tokens = regexp(remoteCode, 'appVersion\s*=\s*''([^'']+)''', 'tokens', 'once');
            if ~isempty(tokens)
                remoteVer = tokens{1};
                if isNewerVersion(appVersion, remoteVer)
                    ignored = '';
                    if ispref('BatchFigResizer', 'IgnoredVersion')
                        ignored = getpref('BatchFigResizer', 'IgnoredVersion');
                    end
                    if ~strcmp(remoteVer, ignored)
                        msg = sprintf('A new version (%s) is available.\nYou are currently running version %s.\n\nWould you like to download the update?', remoteVer, appVersion);
                        sel = uiconfirm(fig, msg, 'Update Available', 'Options', {'Update Now', 'Remind Me Later', 'Ignore This Version'}, 'DefaultOption', 1, 'CancelOption', 2);
                        if strcmp(sel, 'Update Now')
                            openGitHubRelease();
                        elseif strcmp(sel, 'Ignore This Version')
                            setpref('BatchFigResizer', 'IgnoredVersion', remoteVer);
                        end
                    end
                end
            end
        catch
        end
    end

    function manualCheckForUpdates()
        updateStatusLbl.Text = 'Checking GitHub for updates...';
        updateStatusLbl.FontColor = [0 0 0];
        downloadUpdateBtn.Enable = 'off';
        drawnow;
        try
            opts = weboptions('Timeout', 5);
            rawURL = 'https://raw.githubusercontent.com/Alexr360/Batch-Fig-Resizer-MATLAB-Script/main/BatchFigResizer.m';
            remoteCode = webread(rawURL, opts);
            tokens = regexp(remoteCode, 'appVersion\s*=\s*''([^'']+)''', 'tokens', 'once');
            if ~isempty(tokens)
                remoteVer = tokens{1};
                if isNewerVersion(appVersion, remoteVer)
                    updateStatusLbl.Text = sprintf('A new version is available: %s', remoteVer);
                    updateStatusLbl.FontColor = [0 0.5 0];
                    downloadUpdateBtn.Enable = 'on';
                else
                    updateStatusLbl.Text = 'You are already running the latest version.';
                    updateStatusLbl.FontColor = [0 0.5 0];
                end
            else
                updateStatusLbl.Text = 'Could not parse version information from GitHub.';
                updateStatusLbl.FontColor = [0.75 0.1 0.1];
            end
        catch
            updateStatusLbl.Text = 'Failed to connect to GitHub. Please check your internet connection.';
            updateStatusLbl.FontColor = [0.75 0.1 0.1];
        end
    end

    function openGitHubRelease()
        web('https://github.com/Alexr360/Batch-Fig-Resizer-MATLAB-Script', '-browser');
    end

    function tf = isNewerVersion(curr, rem)
        cParts = str2double(split(curr, '.'));
        rParts = str2double(split(rem, '.'));
        len = max(length(cParts), length(rParts));
        cParts(end+1:len) = 0;
        rParts(end+1:len) = 0;
        tf = false;
        for v = 1:len
            if rParts(v) > cParts(v)
                tf = true; return;
            elseif rParts(v) < cParts(v)
                return;
            end
        end
    end

    function applyPreset()
        switch presetDropdown.Value
            case 'Ryu Presentation Full'
                widthEdit.Value = 10.0;
                heightEdit.Value = 4.86;
                colsEdit.Value = 2;
                rowsEdit.Value = 1;
                fontSizeEdit.Value = 12;
                dpiEdit.Value = 500;
                presetDescLabel.Text = 'Full Ryu presentation dimensions split across 2 columns.';
            case 'Ryu Presentation Short'
                widthEdit.Value = 10.0;
                heightEdit.Value = 4.42;
                colsEdit.Value = 2;
                rowsEdit.Value = 1;
                fontSizeEdit.Value = 12;
                dpiEdit.Value = 500;
                presetDescLabel.Text = 'Short Ryu presentation dimensions split across 2 columns.';
            case 'Presentation'
                widthEdit.Value = 9.7;
                heightEdit.Value = 4.85;
                colsEdit.Value = 2;
                rowsEdit.Value = 1;
                fontSizeEdit.Value = 12;
                dpiEdit.Value = 500;
                presetDescLabel.Text = 'Standard slide body dimensions split across 2 columns.';
            case 'Document'
                widthEdit.Value = 6.5;
                heightEdit.Value = 3.0;
                colsEdit.Value = 1;
                rowsEdit.Value = 1;
                fontSizeEdit.Value = 10;
                dpiEdit.Value = 600;
                presetDescLabel.Text = 'Standard single-column report or publication width.';
            case 'Custom'
                presetDescLabel.Text = 'User-defined layout parameters.';
        end
        updateVisualizer();
    end

    function handleManualChange()
        presetDropdown.Value = 'Custom';
        presetDescLabel.Text = 'User-defined layout parameters.';
        updateVisualizer();
    end

    function updateVisualizer()
        w = widthEdit.Value;
        h = heightEdit.Value;
        c = round(colsEdit.Value);
        r = round(rowsEdit.Value);
        cla(ax);
        ax.YDir = 'normal';
        ax.XTickMode = 'auto';
        ax.YTickMode = 'auto';
        if any(~isfinite([w h c r])) || w <= 0 || h <= 0 || c <= 0 || r <= 0
            cellSummaryLabel.Text = 'Invalid dimension bounds';
            return;
        end
        indW = w / c;
        indH = h / r;
        cellSummaryLabel.Text = sprintf('Each cell: %.2f" W  x  %.2f" H', indW, indH);
        ax.XLim = [0 w];
        ax.YLim = [0 h];
        ax.DataAspectRatio = [1 1 1];
        rectangle(ax, 'Position', [0 0 w h], 'EdgeColor', [0.2 0.2 0.2], 'LineWidth', 1.5);
        hold(ax, 'on');
        for i = 1:(c-1)
            x = i * indW;
            plot(ax, [x x], [0 h], 'Color', [0.5 0.5 0.5], 'LineStyle', '--');
        end
        for j = 1:(r-1)
            y = j * indH;
            plot(ax, [0 w], [y y], 'Color', [0.5 0.5 0.5], 'LineStyle', '--');
        end
        text(ax, w/2, h/2, sprintf('Target Cell Bounds:\n%.2f" x %.2f"', indW, indH), 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10);
        hold(ax, 'off');
    end

    function selectFiles(appendMode)
        [fileNames, pathName] = uigetfile('*.fig', 'Select MATLAB Figures', 'MultiSelect', 'on');
        figure(fig);
        if isequal(fileNames, 0)
            return;
        end
        if ischar(fileNames)
            fileNames = {fileNames};
        end
        newFiles = fullfile(pathName, fileNames);
        if appendMode
            files = unique([files, reshape(newFiles, 1, [])], 'stable');
        else
            files = unique(reshape(newFiles, 1, []), 'stable');
        end
        fileLabel.Text = sprintf('%d figure(s) loaded', length(files));
        fileLabel.FontColor = [0 0.5 0];
        buildBatchPreviews();
    end

    function selectMergeFiles(appendMode)
        [fNames, pName] = uigetfile('*.fig', 'Select MATLAB Figures', 'MultiSelect', 'on');
        figure(fig);
        if isequal(fNames, 0), return; end
        if ischar(fNames), fNames = {fNames}; end
        newFiles = fullfile(pName, fNames);
        if appendMode
            mergeFilesList = unique([mergeFilesList, reshape(newFiles, 1, [])], 'stable');
        else
            mergeFilesList = unique(reshape(newFiles, 1, []), 'stable');
        end
        mFileLabel.Text = sprintf('%d figure(s) loaded', length(mergeFilesList));
        mFileLabel.FontColor = [0 0.5 0];
        mListbox.Items = mergeFilesList;
    end

    function pickOutputFolder()
        sel = uigetdir('', 'Select Output Folder');
        if ischar(sel)
            mergeOutDir = sel;
            mOutDirLabel.Text = sel;
            mOutDirLabel.FontColor = [0 0.5 0];
        end
        figure(fig);
    end

    function runMerge()
        if isempty(mergeFilesList)
            uialert(fig, 'Select at least one .fig file.', 'Missing Files');
            return;
        end
        nPerOut = mFigsPerOut.Value;
        w = mWEdit.Value;
        h = mHEdit.Value;
        rmTitles = mRmTitleCheck.Value;
        totalF = length(mergeFilesList);
        numOut = ceil(totalF / nPerOut);
        if isempty(mergeOutDir)
            outDir = fileparts(mergeFilesList{1});
        else
            outDir = mergeOutDir;
        end
        dlg = uiprogressdlg(fig, 'Title', 'Merging Figures', 'Message', 'Initializing...', 'Cancelable', false);
        failed = {};
        for k = 1:numOut
            dlg.Value = k / numOut;
            dlg.Message = sprintf('Merging output figure %d of %d...', k, numOut);
            idxStart = (k - 1) * nPerOut + 1;
            idxEnd = min(k * nPerOut, totalF);
            currentBatch = mergeFilesList(idxStart:idxEnd);
            nCols = ceil(sqrt(length(currentBatch)));
            nRows = ceil(length(currentBatch) / nCols);
            newFig = figure('Visible', 'off', 'Units', 'inches', 'Position', [1 1 w h]);
            tl = tiledlayout(newFig, nRows, nCols, 'TileSpacing', 'compact', 'Padding', 'compact');
            try
                tileIdx = 1;
                for i = 1:length(currentBatch)
                    tmpF = openfig(currentBatch{i}, 'invisible');
                    axs = findall(tmpF, 'type', 'axes');
                    axs = axs(~arrayfun(@(a) isa(a, 'matlab.graphics.illustration.Legend') || isa(a, 'matlab.graphics.illustration.ColorBar') || strcmpi(get(a, 'Tag'), 'wraxes'), axs));
                    axs = flipud(axs); 
                    for aIdx = 1:length(axs)
                        axs(aIdx).Parent = tl;
                        axs(aIdx).Layout.Tile = tileIdx; 
                        tileIdx = tileIdx + 1; 
                        if rmTitles
                            try, title(axs(aIdx), ''); catch, end
                        end
                    end
                    close(tmpF);
                end
                newFig.PaperUnits = 'inches';
                newFig.PaperSize = [w h];
                newFig.PaperPositionMode = 'manual';
                newFig.PaperPosition = [0 0 w h];
                outFile = fullfile(outDir, sprintf('Merged_Output_%d.fig', k));
                saveFigureForReopen(newFig, outFile);
            catch ME
                failed{end+1} = sprintf('Batch %d: %s', k, ME.message);
            end
            if isvalid(newFig)
                close(newFig);
            end
        end
        close(dlg);
        if ~isempty(failed)
            uialert(fig, sprintf('Merge had errors:\n%s', strjoin(failed, '\n')), 'Warning');
        else
            uiconfirm(fig, sprintf('Merge complete. Files saved in:\n%s', outDir), 'Success', 'Icon', 'info');
        end
    end

    function buildBatchPreviews()
        stopBatchPreviewTimer();
        batchPreviewImages = {};
        batchPreviewNames = {};
        batchPreviewIndex = 1;
        failedPreviews = {};
        previewDialog = uiprogressdlg(fig, 'Title', 'Preparing Previews', 'Message', 'Rendering selected figures...', 'Cancelable', false);
        for previewIndex = 1:numel(files)
            previewDialog.Value = previewIndex / numel(files);
            [~, previewName, ~] = fileparts(files{previewIndex});
            previewDialog.Message = sprintf('Rendering (%d/%d): %s', previewIndex, numel(files), previewName);
            previewFigure = [];
            previewFile = [tempname, '.png'];
            try
                previewFigure = openfig(files{previewIndex}, 'invisible');
                previewFigure.PaperPositionMode = 'auto';
                drawnow;
                print(previewFigure, previewFile, '-dpng', '-r120');
                [previewImage, colorMap] = imread(previewFile);
                if ~isempty(colorMap)
                    previewImage = uint8(round(ind2rgb(previewImage, colorMap) * 255));
                end
                batchPreviewImages{end+1} = previewImage; 
                batchPreviewNames{end+1} = previewName; 
            catch ME
                failedPreviews{end+1} = sprintf('%s (%s)', previewName, ME.message); 
            end
            if ~isempty(previewFigure) && isvalid(previewFigure)
                delete(previewFigure);
            end
            if isfile(previewFile)
                delete(previewFile);
            end
        end
        close(previewDialog);
        if isempty(batchPreviewImages)
            cla(originalAx);
            title(originalAx, 'No original figure previews are available');
        else
            showBatchPreview();
            if numel(batchPreviewImages) > 1
                batchPreviewTimer = timer('ExecutionMode', 'fixedSpacing', 'Period', 2.5, 'BusyMode', 'drop', 'TimerFcn', @(~,~) advanceBatchPreview());
                start(batchPreviewTimer);
            end
        end
        if ~isempty(failedPreviews)
            uialert(fig, sprintf('Could not preview %d figure(s):\n%s', numel(failedPreviews), strjoin(failedPreviews, '\n')), 'Preview Warning', 'Icon', 'warning');
        end
    end

    function advanceBatchPreview()
        if isempty(batchPreviewImages) || ~isvalid(fig)
            return;
        end
        batchPreviewIndex = mod(batchPreviewIndex, numel(batchPreviewImages)) + 1;
        showBatchPreview();
    end

    function showBatchPreview()
        if isempty(batchPreviewImages) || ~isvalid(fig) || ~isvalid(originalAx)
            return;
        end
        batchPreviewIndex = min(max(batchPreviewIndex, 1), numel(batchPreviewImages));
        previewImage = batchPreviewImages{batchPreviewIndex};
        cla(originalAx);
        image(originalAx, previewImage);
        axis(originalAx, 'image');
        originalAx.YDir = 'reverse';
        originalAx.XTick = [];
        originalAx.YTick = [];
        originalAx.Box = 'on';
        title(originalAx, sprintf('%s  (%d of %d)', batchPreviewNames{batchPreviewIndex}, batchPreviewIndex, numel(batchPreviewImages)), 'Interpreter', 'none');
    end

    function stopBatchPreviewTimer()
        if ~isempty(batchPreviewTimer) && isvalid(batchPreviewTimer)
            stop(batchPreviewTimer);
            delete(batchPreviewTimer);
        end
        batchPreviewTimer = [];
    end

    function exportFigs()
        if isempty(files)
            uialert(fig, 'Select at least one .fig file first.', 'Missing Files');
            return;
        end
        w = widthEdit.Value;
        h = heightEdit.Value;
        c = round(colsEdit.Value);
        r = round(rowsEdit.Value);
        fSize = fontSizeEdit.Value;
        lWidth = lineWidthEdit.Value;
        dotSize = dotSizeEdit.Value;
        dpiVal = dpiEdit.Value;
        ext = formatDropdown.Value;
        keepTitles = keepTitlesCheck.Value;
        makeTitlesLegend = makeTitlesLegendCheck.Value;
        forceGrid = forceGridCheck.Value;
        forceGridMode = forceGridDropdown.Value;
        equalizeSubfigures = equalizeSubfiguresCheck.Value;
        legendLocation = legendDropdown.Value;
        legendMargin = legendMarginEdit.Value;
        if any(~isfinite([w h c r fSize lWidth dotSize dpiVal legendMargin])) || w <= 0 || h <= 0 || c <= 0 || r <= 0 || fSize <= 0 || lWidth <= 0 || dotSize <= 0 || dpiVal < 100 || legendMargin < 0
            uialert(fig, 'Dimensions must be > 0, DPI must be >= 100, and the legend margin cannot be negative.', 'Invalid Inputs');
            return;
        end
        indW = w / c;
        indH = h / r;
        hasSubplots = false;
        failedFiles = {};
        lastExportFolder = '';
        d = uiprogressdlg(fig, 'Title', 'Exporting Figures', 'Message', 'Processing...', 'Cancelable', false);
        for i = 1:length(files)
            d.Value = i / length(files);
            [folder, name, ~] = fileparts(files{i});
            lastExportFolder = folder;
            d.Message = sprintf('Exporting (%d/%d): %s', i, length(files), name);
            f = [];
            try
                f = openfig(files{i}, 'invisible');
                delete(findall(f, 'Type', 'axes', 'Tag', 'BatchFigResizerTitlesLegendAxes'));
                allAxes = findall(f, 'type', 'axes');
                allAxes = allAxes(~arrayfun(@(a) isa(a, 'matlab.graphics.illustration.Legend') || isa(a, 'matlab.graphics.illustration.ColorBar') || strcmpi(get(a, 'Tag'), 'wraxes'), allAxes));
                [titleSourceAxes, titleLegendLabels] = collectSubplotTitles(allAxes);
                if length(allAxes) > 1
                    hasSubplots = true;
                end
                if ~keepTitles || makeTitlesLegend
                    for axIdx = 1:length(allAxes)
                        try, title(allAxes(axIdx), ''); catch, end
                    end
                end
                if ~keepTitles
                    tl = findall(f, 'Type', 'tiledlayout');
                    for tlIdx = 1:length(tl)
                        try, title(tl(tlIdx), ''); catch, end
                    end
                    wrax = findall(f, 'Tag', 'wraxes');
                    for wIdx = 1:numel(wrax)
                        try, title(wrax(wIdx), ''); catch, end
                    end
                end
                if forceGrid
                    if strcmp(forceGridMode, 'Force Enable')
                        gridState = 'on';
                    else
                        gridState = 'off';
                    end
                    for axIdx = 1:length(allAxes)
                        try, grid(allAxes(axIdx), gridState); catch, end
                    end
                end
                try, set(allAxes, 'FontSize', fSize); catch, end
                try, set(findall(f, 'type', 'text'), 'FontSize', fSize); catch, end
                try, set(findall(f, 'type', 'legend'), 'FontSize', fSize); catch, end
                try, set(findall(f, 'type', 'colorbar'), 'FontSize', fSize); catch, end
                plotLines = findall(f, 'Type', 'line');
                try, set(plotLines, 'LineWidth', lWidth); catch, end
                try, set(plotLines, 'MarkerSize', sqrt(dotSize)); catch, end
                scatterPlots = findall(f, 'Type', 'scatter');
                if ~isempty(scatterPlots)
                    try, set(scatterPlots, 'SizeData', dotSize); catch, end
                end
                try, set(allAxes, 'LineWidth', max(0.8, lWidth * 0.75)); catch, end
                try
                    f.WindowStyle = 'normal';
                    f.WindowState = 'normal';
                    f.Units = 'inches';
                    f.Position = [1, 1, indW, indH];
                catch
                end
                f.PaperUnits = 'inches';
                f.PaperSize = [indW indH];
                f.PaperPosition = [0 0 indW indH];
                f.PaperPositionMode = 'manual';
                if equalizeSubfigures && length(allAxes) > 1
                    manualAxes = allAxes(arrayfun(@(a) isequal(a.Parent, f), allAxes));
                    if numel(manualAxes) > 1
                        try
                            set(manualAxes, 'Units', 'normalized');
                            positions = vertcat(manualAxes.Position);
                            commonSize = min(positions(:, 3:4), [], 1);
                            for aIdx = 1:numel(manualAxes)
                                position = positions(aIdx, :);
                                position(1:2) = position(1:2) + (position(3:4) - commonSize) / 2;
                                position(3:4) = commonSize;
                                manualAxes(aIdx).Position = position;
                            end
                        catch
                        end
                    end
                end
                if ~strcmp(legendLocation, 'original')
                    legends = findall(f, 'Type', 'legend');
                    for lgIdx = 1:numel(legends)
                        lg = legends(lgIdx);
                        outerTile = false;
                        if isprop(lg, 'Layout') && ~isempty(lg.Layout) && isprop(lg.Layout, 'Tile')
                            tile = lg.Layout.Tile;
                            outerTile = (ischar(tile) || isstring(tile)) && any(strcmp(tile, {'north', 'south', 'east', 'west'}));
                        end
                        if outerTile
                            switch legendLocation
                                case 'northoutside'
                                    lg.Layout.Tile = 'north';
                                case 'southoutside'
                                    lg.Layout.Tile = 'south';
                                case 'eastoutside'
                                    lg.Layout.Tile = 'east';
                                case 'westoutside'
                                    lg.Layout.Tile = 'west';
                                otherwise
                                    lg.Layout.Tile = 'none';
                            end
                        end
                        try
                            lg.Location = legendLocation;
                            if any(strcmp(legendLocation, {'northoutside', 'southoutside'}))
                                lg.Orientation = 'horizontal';
                            else
                                lg.Orientation = 'vertical';
                            end
                        catch
                        end
                    end
                end
                if makeTitlesLegend
                    createTitlesLegend(f, titleSourceAxes, titleLegendLabels, fSize, legendLocation, legendMargin);
                end
                drawnow;
                outFile = fullfile(folder, sprintf('%s_resized%s', name, ext));
                if strcmp(ext, '.fig')
                    saveFigureForReopen(f, outFile);
                else
                    exported = false;
                    try
                        if strcmp(ext, '.pdf') || strcmp(ext, '.eps') || strcmp(ext, '.svg')
                            exportgraphics(f, outFile, 'ContentType', 'vector', 'Units', 'inches', 'Width', indW, 'Height', indH, 'Padding', 'figure');
                        else
                            exportgraphics(f, outFile, 'Resolution', dpiVal, 'Units', 'inches', 'Width', indW, 'Height', indH, 'Padding', 'figure');
                        end
                        exported = true;
                    catch
                        exported = false;
                    end
                    if ~exported
                        exportFigureViaPrint(f, outFile, ext, indW, indH, dpiVal);
                    end
                end
            catch ME
                failedFiles{end+1} = sprintf('%s (%s)', name, ME.message); 
            end
            if ~isempty(f) && isvalid(f)
                close(f);
            end
        end
        close(d);
        if ~isempty(failedFiles)
            uialert(fig, sprintf('Failed to export %d file(s):\n%s', length(failedFiles), strjoin(failedFiles, '\n')), 'Export Errors');
        else
            if hasSubplots
                msg = 'Export complete. Subplots detected; verify layout padding if text overlaps.';
                titleText = 'Subplots Detected';
                iconType = 'warning';
            else
                msg = 'All figures exported successfully.';
                titleText = 'Success';
                iconType = 'info';
            end
            uiconfirm(fig, msg, titleText, 'Options', {'Open Folder', 'OK'}, 'DefaultOption', 2, 'CancelOption', 2, 'Icon', iconType, 'CloseFcn', @(h, evt) handleConfirm(evt.SelectedOption, lastExportFolder));
        end
    end

    function handleConfirm(selectedOption, targetDir)
        if strcmp(selectedOption, 'Open Folder') && ~isempty(targetDir) && isfolder(targetDir)
            if ispc
                winopen(targetDir);
            elseif ismac
                system(['open "', targetDir, '"']);
            else
                system(['xdg-open "', targetDir, '"']);
            end
        end
    end

    function [titleAxes, titleLabels] = collectSubplotTitles(axesHandles)
        titleAxes = axesHandles([]);
        titleLabels = {};
        titlePositions = zeros(0, 2);
        for titleIndex = 1:numel(axesHandles)
            try
                rawTitle = axesHandles(titleIndex).Title.String;
            catch
                rawTitle = '';
            end
            if iscell(rawTitle)
                titleText = strjoin(cellfun(@char, rawTitle, 'UniformOutput', false), ' ');
            elseif isstring(rawTitle)
                titleText = char(strjoin(rawTitle, ' '));
            else
                titleText = char(rawTitle);
            end
            if isempty(strtrim(titleText))
                continue;
            end
            titleAxes(end+1, 1) = axesHandles(titleIndex); 
            titleLabels{end+1, 1} = titleText; 
            pixelPosition = getpixelposition(axesHandles(titleIndex), true);
            titlePositions(end+1, :) = [-(pixelPosition(2) + pixelPosition(4)), pixelPosition(1)]; 
        end
        if ~isempty(titlePositions)
            [~, visualOrder] = sortrows(titlePositions, [1 2]);
            titleAxes = titleAxes(visualOrder);
            titleLabels = titleLabels(visualOrder);
        end
    end

    function createTitlesLegend(targetFigure, titleAxes, titleLabels, fontSize, location, marginInches)
        if isempty(titleLabels)
            return;
        end
        legendAxes = axes(targetFigure, 'Units', 'normalized', 'Position', [0 0 1 1], 'Visible', 'off', 'Color', 'none', 'HitTest', 'off', 'Tag', 'BatchFigResizerTitlesLegendAxes');
        hold(legendAxes, 'on');
        entryCount = numel(titleLabels);
        fallbackColors = lines(entryCount);
        proxyHandles = gobjects(entryCount, 1);
        for entryIndex = 1:entryCount
            sourceLines = findall(titleAxes(entryIndex), 'Type', 'line');
            if isempty(sourceLines)
                lineColor = fallbackColors(entryIndex, :);
                lineStyle = '-';
                markerStyle = 'none';
                lineWidth = 1.5;
            else
                sourceLine = sourceLines(end);
                lineColor = sourceLine.Color;
                lineStyle = sourceLine.LineStyle;
                markerStyle = sourceLine.Marker;
                lineWidth = sourceLine.LineWidth;
                if strcmp(lineStyle, 'none') && strcmp(markerStyle, 'none')
                    lineStyle = '-';
                end
            end
            proxyHandles(entryIndex) = plot(legendAxes, nan, nan, 'Color', lineColor, 'LineStyle', lineStyle, 'Marker', markerStyle, 'LineWidth', lineWidth);
        end
        titleLegend = legend(legendAxes, proxyHandles, titleLabels, 'Location', 'north', 'Orientation', 'horizontal', 'Box', 'on', 'FontSize', fontSize);
        titleLegend.Tag = 'BatchFigResizerTitlesLegend';
        if isprop(titleLegend, 'NumColumns')
            titleLegend.NumColumns = min(entryCount, 4);
        end
        if any(strcmp(location, {'northoutside', 'southoutside'}))
            titleLegend.Units = 'normalized';
            drawnow;
            edgeMargin = 0.02;
            figureHeight = targetFigure.Position(4);
            legendGap = marginInches / figureHeight;
            while titleLegend.Position(3) > 1 - 2 * edgeMargin && titleLegend.NumColumns > 1
                titleLegend.NumColumns = titleLegend.NumColumns - 1;
                drawnow;
            end
            legendPosition = titleLegend.Position;
            bandHeight = legendPosition(4) + edgeMargin + legendGap;
            if legendPosition(3) > 1 - 2 * edgeMargin || bandHeight >= 0.8
                error('BatchFigResizer:LegendTooLarge', 'The title legend and margin do not fit this canvas. Increase the cell dimensions, reduce the margin or font size, or shorten the titles.');
            end
            if strcmp(location, 'northoutside')
                plotPosition = [0 0 1 1-bandHeight];
                legendPosition(2) = 1 - edgeMargin - legendPosition(4);
            else
                plotPosition = [0 bandHeight 1 1-bandHeight];
                legendPosition(2) = edgeMargin;
            end
            legendPosition(1) = (1 - legendPosition(3)) / 2;
            content = targetFigure.Children;
            for childIndex = 1:numel(content)
                child = content(childIndex);
                if isequal(child, legendAxes) || isequal(child, titleLegend)
                    continue;
                end
                if isprop(child, 'Units') && isprop(child, 'Position')
                    child.Units = 'normalized';
                    if isprop(child, 'OuterPosition') && ~isa(child, 'matlab.graphics.illustration.Legend')
                        property = 'OuterPosition';
                        if isprop(child, 'PositionConstraint')
                            child.PositionConstraint = 'outerposition';
                        end
                    else
                        property = 'Position';
                    end
                    bounds = child.(property);
                    bounds(2) = plotPosition(2) + bounds(2) * plotPosition(4);
                    bounds(4) = bounds(4) * plotPosition(4);
                    child.(property) = bounds;
                end
            end
            titleLegend.Position = legendPosition;
            drawnow;
            plotAxes = findall(targetFigure, 'Type', 'axes');
            plotAxes = plotAxes(~arrayfun(@(candidate) isequal(candidate, legendAxes), plotAxes));
            if ~isempty(plotAxes)
                figurePixels = getpixelposition(targetFigure);
                requiredPixels = marginInches * figurePixels(4) / figureHeight;
                for adjustmentIndex = 1:12
                    legendPixels = getpixelposition(titleLegend, true);
                    axesPixels = arrayfun(@(candidate) getpixelposition(candidate, true), plotAxes, 'UniformOutput', false);
                    axesPixels = vertcat(axesPixels{:});
                    if strcmp(location, 'northoutside')
                        actualPixels = legendPixels(2) - max(axesPixels(:, 2) + axesPixels(:, 4));
                    else
                        actualPixels = min(axesPixels(:, 2)) - (legendPixels(2) + legendPixels(4));
                    end
                    shortfall = requiredPixels - actualPixels;
                    if shortfall <= 0
                        break;
                    end
                    correction = (shortfall + 1) / figurePixels(4);
                    for childIndex = 1:numel(content)
                        child = content(childIndex);
                        if isequal(child, legendAxes) || isequal(child, titleLegend) || ~isprop(child, 'Units') || ~isprop(child, 'Position')
                            continue;
                        end
                        child.Units = 'normalized';
                        if isprop(child, 'OuterPosition') && ~isa(child, 'matlab.graphics.illustration.Legend')
                            property = 'OuterPosition';
                        else
                            property = 'Position';
                        end
                        bounds = child.(property);
                        if strcmp(location, 'southoutside')
                            bounds(2) = bounds(2) + correction;
                        end
                        bounds(4) = bounds(4) - correction;
                        if bounds(4) <= 0
                            error('BatchFigResizer:LegendTooLarge', 'The legend margin leaves no room for the plots.');
                        end
                        child.(property) = bounds;
                    end
                    drawnow;
                end
            end
        elseif ~strcmp(location, 'original')
            titleLegend.Location = location;
        end
        set(proxyHandles, 'HandleVisibility', 'off');
        legendAxes.HandleVisibility = 'off';
    end

    function loadRegionPreview()
        [fileName, pathName] = uigetfile('*.fig', 'Select a MATLAB Figure');
        figure(fig);
        if isequal(fileName, 0)
            return;
        end
        regionLoadBtn.Enable = 'off';
        regionStatusLabel.Text = 'Loading figure preview...';
        regionStatusLabel.FontColor = [0.15 0.4 0.7];
        drawnow;
        tempPng = [tempname, '.png'];
        try
            closeRegionSource();
            regionSourcePath = fullfile(pathName, fileName);
            regionSourceFig = openfig(regionSourcePath, 'invisible');
            regionSourceAxes = findall(regionSourceFig, 'Type', 'axes');
            regionSourceAxes = regionSourceAxes(~arrayfun(@(a) isa(a, 'matlab.graphics.illustration.Legend') || isa(a, 'matlab.graphics.illustration.ColorBar') || strcmpi(get(a, 'Tag'), 'wraxes'), regionSourceAxes));
            if isempty(regionSourceAxes)
                error('The selected figure does not contain any plot axes.');
            end
            figurePosition = getpixelposition(regionSourceFig);
            figureWidth = max(1, figurePosition(3));
            figureHeight = max(1, figurePosition(4));
            axesCount = numel(regionSourceAxes);
            regionAxesPreviewPositions = zeros(axesCount, 4);
            regionOriginalXLimits = zeros(axesCount, 2);
            regionAxesXScales = cell(axesCount, 1);
            regionAxesXDirections = cell(axesCount, 1);
            for axesIndex = 1:axesCount
                pixelPosition = getpixelposition(regionSourceAxes(axesIndex), true);
                regionAxesPreviewPositions(axesIndex, :) = [pixelPosition(1) / figureWidth, pixelPosition(2) / figureHeight, pixelPosition(3) / figureWidth, pixelPosition(4) / figureHeight];
                regionOriginalXLimits(axesIndex, :) = regionSourceAxes(axesIndex).XLim;
                regionAxesXScales{axesIndex} = regionSourceAxes(axesIndex).XScale;
                regionAxesXDirections{axesIndex} = regionSourceAxes(axesIndex).XDir;
            end
            regionSourceFig.PaperPositionMode = 'auto';
            drawnow;
            print(regionSourceFig, tempPng, '-dpng', '-r200');
            [previewImage, colorMap] = imread(tempPng);
            if ~isempty(colorMap)
                previewImage = uint8(round(ind2rgb(previewImage, colorMap) * 255));
            end
            regionPreviewImage = previewImage;
            clearPreviewSelection();
            cla(regionPreviewAx);
            previewHeight = size(regionPreviewImage, 1);
            previewWidth = size(regionPreviewImage, 2);
            regionPreviewImageHandle = image(regionPreviewAx, 'CData', regionPreviewImage, 'XData', [1 previewWidth], 'YData', [1 previewHeight]);
            hold(regionPreviewAx, 'on');
            regionPreviewImageHandle.ButtonDownFcn = @(~,~) beginPreviewDrag();
            regionPreviewImageHandle.PickableParts = 'all';
            regionPreviewAx.ButtonDownFcn = @(~,~) beginPreviewDrag();
            regionPreviewAx.XLim = [0.5 previewWidth + 0.5];
            regionPreviewAx.YLim = [0.5 previewHeight + 0.5];
            regionPreviewAx.YDir = 'reverse';
            regionPreviewAx.DataAspectRatio = [1 1 1];
            regionPreviewAx.XTick = [];
            regionPreviewAx.YTick = [];
            title(regionPreviewAx, 'Drag horizontally over any subplot');
            regionClearBtn.Enable = 'off';
            regionStatusLabel.Text = sprintf('Loaded %s', fileName);
            regionStatusLabel.FontColor = [0 0.5 0];
        catch ME
            closeRegionSource();
            cla(regionPreviewAx);
            title(regionPreviewAx, 'Load a .fig file to begin');
            regionStatusLabel.Text = 'Could not load figure.';
            regionStatusLabel.FontColor = [0.75 0.1 0.1];
            uialert(fig, ME.message, 'Figure Load Error');
        end
        if isfile(tempPng)
            delete(tempPng);
        end
        regionLoadBtn.Enable = 'on';
    end

    function beginPreviewDrag()
        if isempty(regionPreviewImage) || isempty(regionSourceAxes)
            return;
        end
        point = regionPreviewAx.CurrentPoint(1, 1:2);
        axesIndex = previewAxesAtPoint(point);
        if isempty(axesIndex)
            regionStatusLabel.Text = 'Start the drag inside a subplot plotting area.';
            regionStatusLabel.FontColor = [0.65 0.4 0];
            return;
        end
        if ~isempty(regionSelectedXLimits)
            pixelBounds = xLimitsToPixels(axesIndex, regionSelectedXLimits);
            edgeTolerance = max(7, 0.012 * size(regionPreviewImage, 2));
            leftDistance = abs(point(1) - pixelBounds(1));
            rightDistance = abs(point(1) - pixelBounds(2));
            if min(leftDistance, rightDistance) <= edgeTolerance
                regionSelectedAxesIndex = axesIndex;
                regionDragInitialLimits = regionSelectedXLimits;
                if leftDistance <= rightDistance
                    regionDragMode = 'left-edge';
                else
                    regionDragMode = 'right-edge';
                end
                fig.WindowButtonMotionFcn = @(~,~) updatePreviewDrag();
                fig.WindowButtonUpFcn = @(~,~) finishPreviewDrag();
                regionStatusLabel.Text = 'Drag the selected edge to resize the region.';
                regionStatusLabel.FontColor = [0.15 0.4 0.7];
                return;
            end
        end
        clearPreviewSelection();
        regionSelectedAxesIndex = axesIndex;
        regionDragMode = 'new-selection';
        axesRectangle = previewAxesRectangle(axesIndex);
        regionDragStartX = min(max(point(1), axesRectangle(1)), axesRectangle(1) + axesRectangle(3));
        fig.WindowButtonMotionFcn = @(~,~) updatePreviewDrag();
        fig.WindowButtonUpFcn = @(~,~) finishPreviewDrag();
        updatePreviewDrag();
    end

    function updatePreviewDrag()
        if isempty(regionDragStartX) || isempty(regionSelectedAxesIndex)
            return;
        end
        point = regionPreviewAx.CurrentPoint(1, 1:2);
        axesRectangle = previewAxesRectangle(regionSelectedAxesIndex);
        currentX = min(max(point(1), axesRectangle(1)), axesRectangle(1) + axesRectangle(3));
        if strcmp(regionDragMode, 'new-selection')
            selectedPixels = sort([regionDragStartX currentX]);
            if diff(selectedPixels) < 1
                return;
            end
            regionSelectedXLimits = pixelsToXLimits(regionSelectedAxesIndex, selectedPixels);
        else
            currentValue = pixelToXValue(regionSelectedAxesIndex, currentX);
            minimumSpan = max(eps(max(abs(regionDragInitialLimits))), abs(diff(regionOriginalXLimits(regionSelectedAxesIndex, :))) * 1e-8);
            if strcmp(regionDragMode, 'left-edge')
                regionSelectedXLimits = [min(currentValue, regionDragInitialLimits(2) - minimumSpan), regionDragInitialLimits(2)];
            elseif strcmp(regionDragMode, 'right-edge')
                regionSelectedXLimits = [regionDragInitialLimits(1), max(currentValue, regionDragInitialLimits(1) + minimumSpan)];
            end
        end
        drawSharedRegionRectangles();
        regionStatusLabel.Text = sprintf('Selected x-range: %.5g to %.5g', regionSelectedXLimits(1), regionSelectedXLimits(2));
        regionStatusLabel.FontColor = [0.15 0.4 0.7];
    end

    function finishPreviewDrag()
        fig.WindowButtonMotionFcn = [];
        fig.WindowButtonUpFcn = [];
        regionDragStartX = [];
        regionDragMode = '';
        regionDragInitialLimits = [];
        if isempty(regionSelectedXLimits) || regionSelectedXLimits(2) <= regionSelectedXLimits(1)
            clearPreviewSelection();
            return;
        end
        regionClearBtn.Enable = 'on';
        regionExportBtn.Enable = 'on';
        regionStatusLabel.Text = sprintf('Selected x-range: %.5g to %.5g. Drag either red edge to adjust.', regionSelectedXLimits(1), regionSelectedXLimits(2));
        regionStatusLabel.FontColor = [0.15 0.4 0.7];
    end

    function axesIndex = previewAxesAtPoint(point)
        axesIndex = [];
        matches = [];
        for index = 1:size(regionAxesPreviewPositions, 1)
            rectanglePosition = previewAxesRectangle(index);
            if point(1) >= rectanglePosition(1) && point(1) <= rectanglePosition(1) + rectanglePosition(3) && point(2) >= rectanglePosition(2) && point(2) <= rectanglePosition(2) + rectanglePosition(4)
                matches(end+1) = index; 
            end
        end
        if ~isempty(matches)
            areas = regionAxesPreviewPositions(matches, 3) .* regionAxesPreviewPositions(matches, 4);
            [~, smallest] = min(areas);
            axesIndex = matches(smallest);
        end
    end

    function rectanglePosition = previewAxesRectangle(axesIndex)
        normalizedPosition = regionAxesPreviewPositions(axesIndex, :);
        previewWidth = size(regionPreviewImage, 2);
        previewHeight = size(regionPreviewImage, 1);
        rectanglePosition = [1 + normalizedPosition(1) * (previewWidth - 1), 1 + (1 - normalizedPosition(2) - normalizedPosition(4)) * (previewHeight - 1), normalizedPosition(3) * (previewWidth - 1), normalizedPosition(4) * (previewHeight - 1)];
    end

    function limits = pixelsToXLimits(axesIndex, pixelBounds)
        axesRectangle = previewAxesRectangle(axesIndex);
        fractions = (pixelBounds - axesRectangle(1)) / axesRectangle(3);
        fractions = min(max(fractions, 0), 1);
        if strcmp(regionAxesXDirections{axesIndex}, 'reverse')
            fractions = 1 - fliplr(fractions);
        end
        originalLimits = regionOriginalXLimits(axesIndex, :);
        if strcmp(regionAxesXScales{axesIndex}, 'log')
            logLimits = log10(originalLimits);
            limits = 10 .^ (logLimits(1) + fractions * diff(logLimits));
        else
            limits = originalLimits(1) + fractions * diff(originalLimits);
        end
        limits = sort(limits);
    end

    function value = pixelToXValue(axesIndex, pixelPosition)
        limits = pixelsToXLimits(axesIndex, [pixelPosition pixelPosition]);
        value = limits(1);
    end

    function pixelBounds = xLimitsToPixels(axesIndex, limits)
        axesRectangle = previewAxesRectangle(axesIndex);
        originalLimits = regionOriginalXLimits(axesIndex, :);
        if strcmp(regionAxesXScales{axesIndex}, 'log')
            fractions = (log10(limits) - log10(originalLimits(1))) ./ diff(log10(originalLimits));
        else
            fractions = (limits - originalLimits(1)) ./ diff(originalLimits);
        end
        if strcmp(regionAxesXDirections{axesIndex}, 'reverse')
            fractions = 1 - fractions;
        end
        fractions = min(max(fractions, 0), 1);
        pixelBounds = sort(axesRectangle(1) + fractions * axesRectangle(3));
    end

    function drawSharedRegionRectangles()
        deleteSelectionRectangles();
        for axesIndex = 1:numel(regionSourceAxes)
            pixelBounds = xLimitsToPixels(axesIndex, regionSelectedXLimits);
            axesRectangle = previewAxesRectangle(axesIndex);
            width = diff(pixelBounds);
            if width <= 0
                continue;
            end
            selectionRectangle = rectangle(regionPreviewAx, 'Position', [pixelBounds(1), axesRectangle(2), width, axesRectangle(4)], 'EdgeColor', [0.85 0.15 0.1], 'LineWidth', 2, 'LineStyle', '-');
            selectionRectangle.HitTest = 'off';
            regionSelectionRects = [regionSelectionRects; selectionRectangle]; 
        end
    end

    function clearPreviewSelection()
        fig.WindowButtonMotionFcn = [];
        fig.WindowButtonUpFcn = [];
        deleteSelectionRectangles();
        regionSelectedAxesIndex = [];
        regionDragStartX = [];
        regionDragMode = '';
        regionDragInitialLimits = [];
        regionSelectedXLimits = [];
        regionClearBtn.Enable = 'off';
        regionExportBtn.Enable = 'off';
    end

    function deleteSelectionRectangles()
        if ~isempty(regionSelectionRects)
            validRectangles = regionSelectionRects(isvalid(regionSelectionRects));
            if ~isempty(validRectangles)
                delete(validRectangles);
            end
        end
        regionSelectionRects = [];
    end

    function exportRegionFigure()
        if isempty(regionSourceFig) || ~isvalid(regionSourceFig) || isempty(regionSelectedXLimits)
            uialert(fig, 'Load a figure and select an x-range first.', 'Missing Selection');
            return;
        end
        [sourceFolder, sourceName, ~] = fileparts(regionSourcePath);
        defaultOutput = fullfile(sourceFolder, [sourceName, '_region.fig']);
        [outputName, outputFolder] = uiputfile('*.fig', 'Save Extracted Region', defaultOutput);
        figure(fig);
        if isequal(outputName, 0)
            return;
        end
        if isempty(regexpi(outputName, '\.fig$', 'once'))
            outputName = [outputName, '.fig'];
        end
        outputPath = fullfile(outputFolder, outputName);
        if strcmpi(outputPath, regionSourcePath)
            uialert(fig, 'Choose a new filename so the source figure is not overwritten.', 'Choose New Filename');
            return;
        end
        try
            for axesIndex = 1:numel(regionSourceAxes)
                if isvalid(regionSourceAxes(axesIndex))
                    xlim(regionSourceAxes(axesIndex), regionSelectedXLimits);
                end
            end
            regionSourceFig.Name = [sourceName, ' - selected region'];
            regionSourceFig.NumberTitle = 'off';
            saveFigureForReopen(regionSourceFig, outputPath);
            regionStatusLabel.Text = sprintf('Saved %s', outputName);
            regionStatusLabel.FontColor = [0 0.5 0];
        catch ME
            regionStatusLabel.Text = 'Region export failed.';
            regionStatusLabel.FontColor = [0.75 0.1 0.1];
            uialert(fig, ME.message, 'Region Export Error');
        end
    end

    function closeRegionSource()
        clearPreviewSelection();
        if ~isempty(regionSourceFig) && isvalid(regionSourceFig)
            delete(regionSourceFig);
        end
        regionSourceFig = [];
        regionSourcePath = '';
        regionSourceAxes = [];
        regionAxesPreviewPositions = [];
        regionOriginalXLimits = [];
        regionAxesXScales = {};
        regionAxesXDirections = {};
        regionPreviewImage = [];
        regionPreviewImageHandle = [];
    end
    
    function selectCSrc()
        d = uigetdir();
        if d ~= 0
            cSrcPath = d;
            cSrcLbl.Text = d;
            cStatusLog.Items = [cStatusLog.Items, {['Source set: ' d]}];
        end
        figure(fig);
    end

    function selectCDest()
        d = uigetdir();
        if d ~= 0
            cDestPath = d;
            cDestLbl.Text = d;
            cStatusLog.Items = [cStatusLog.Items, {['Dest set: ' d]}];
        end
        figure(fig);
    end

    function runCopy()
        if isempty(cSrcPath) || isempty(cDestPath)
            uialert(fig, 'Select both source and destination folders.', 'Error');
            return;
        end
        targetType = cTypeDrop.Value;
        copyCandidates = dir(fullfile(cSrcPath, '**', '*.fig'));
        copiedCount = 0;
        dlg = uiprogressdlg(fig, 'Title', 'Copying Figures', 'Message', 'Initializing...', 'Cancelable', false);
        totalFiles = length(copyCandidates);
        cStatusLog.Items = [cStatusLog.Items, {sprintf('Scanning for %s in %d files...', targetType, totalFiles)}];
        for i = 1:totalFiles
            dlg.Value = i / totalFiles;
            dlg.Message = sprintf('Processing file %d of %d...', i, totalFiles);
            oldPath = fullfile(copyCandidates(i).folder, copyCandidates(i).name);
            shouldCopy = false;
            if strcmp(targetType, 'All')
                shouldCopy = true;
            else
                try
                    hFig = openfig(oldPath, 'invisible');
                    switch targetType
                        case 'Line Plot'
                            objs = findall(hFig, 'Type', 'line');
                            if ~isempty(objs), shouldCopy = true; end
                        case 'Scatter Plot'
                            objs = findall(hFig, 'Type', 'scatter');
                            if ~isempty(objs), shouldCopy = true; end
                        case 'Bar Plot'
                            objs = findall(hFig, 'Type', 'bar');
                            if ~isempty(objs), shouldCopy = true; end
                        case 'Surface Plot'
                            objs = findall(hFig, 'Type', 'surface');
                            if ~isempty(objs), shouldCopy = true; end
                        case 'Bode Plot'
                            shouldCopy = isBodePlotFigure(hFig);
                        case 'Root Locus Plot'
                            shouldCopy = isRootLocusPlotFigure(hFig);
                    end
                    close(hFig);
                catch
                    if exist('hFig', 'var') && isgraphics(hFig)
                        close(hFig);
                    end
                end
            end
            if shouldCopy
                newPath = fullfile(cDestPath, copyCandidates(i).name);
                copyfile(oldPath, newPath);
                copiedCount = copiedCount + 1;
                cStatusLog.Items = [cStatusLog.Items, {sprintf('Copied: %s', copyCandidates(i).name)}];
            end
        end
        close(dlg);
        cStatusLog.Items = [cStatusLog.Items, {sprintf('Done! Copied %d files successfully.', copiedCount)}];
        scroll(cStatusLog, 'bottom');
        uiconfirm(fig, sprintf('Copied %d files successfully.', copiedCount), 'Success', 'Icon', 'info');
    end

    function closeApplication()
        stopBatchPreviewTimer();
        closeRegionSource();
        delete(fig);
    end
end

function exportFigureViaPrint(targetFig, outFile, ext, w, h, dpiVal)
    targetFig.PaperUnits = 'inches';
    targetFig.PaperSize = [w h];
    targetFig.PaperPositionMode = 'manual';
    targetFig.PaperPosition = [0 0 w h];
    drawnow;
    switch lower(ext)
        case {'.tif', '.tiff'}
            print(targetFig, outFile, '-dtiff', sprintf('-r%d', round(dpiVal)));
        case '.png'
            print(targetFig, outFile, '-dpng', sprintf('-r%d', round(dpiVal)));
        case {'.jpeg', '.jpg'}
            print(targetFig, outFile, '-djpeg', sprintf('-r%d', round(dpiVal)));
        case '.pdf'
            print(targetFig, outFile, '-dpdf', '-painters');
        case '.eps'
            print(targetFig, outFile, '-depsc', '-painters');
        case '.svg'
            print(targetFig, outFile, '-dsvg', '-painters');
        otherwise
            print(targetFig, outFile, '-dpng', sprintf('-r%d', round(dpiVal)));
    end
end

function tf = isBodePlotFigure(hFig)
    tf = false;
    if isempty(hFig) || ~isvalid(hFig), return; end
    nameTag = [get(hFig, 'Name') ' ' get(hFig, 'Tag')];
    if ~isempty(regexpi(nameTag, 'bode')), tf = true; return; end
    ad = getappdata(hFig);
    if isfield(ad, 'BodePlot') || isfield(ad, 'WaveformPlot')
        tf = true;
        return;
    end
    axs = findall(hFig, 'Type', 'axes');
    hasMag = false;
    hasPhase = false;
    for k = 1:numel(axs)
        ax = axs(k);
        try
            yStr = '';
            tStr = '';
            if isprop(ax, 'YLabel') && ~isempty(ax.YLabel), yStr = char(ax.YLabel.String); end
            if isprop(ax, 'Title') && ~isempty(ax.Title), tStr = char(ax.Title.String); end
            if ~isempty(regexpi([yStr ' ' tStr], 'magnitude|mag\s*\(db\)')), hasMag = true; end
            if ~isempty(regexpi([yStr ' ' tStr], 'phase|phase\s*\(deg\)')), hasPhase = true; end
        catch
        end
    end
    if hasMag || hasPhase || (numel(axs) >= 2 && any(strcmpi(get(axs, 'XScale'), 'log')))
        tf = true;
    end
end

function tf = isRootLocusPlotFigure(hFig)
    tf = false;
    if isempty(hFig) || ~isvalid(hFig), return; end
    nameTag = [get(hFig, 'Name') ' ' get(hFig, 'Tag')];
    if ~isempty(regexpi(nameTag, 'rlocus|root\s*locus')), tf = true; return; end
    ad = getappdata(hFig);
    if isfield(ad, 'RootLocusPlot') || isfield(ad, 'RLocusPlot')
        tf = true;
        return;
    end
    axs = findall(hFig, 'Type', 'axes');
    for k = 1:numel(axs)
        ax = axs(k);
        try
            xStr = '';
            yStr = '';
            tStr = '';
            if isprop(ax, 'XLabel') && ~isempty(ax.XLabel), xStr = char(ax.XLabel.String); end
            if isprop(ax, 'YLabel') && ~isempty(ax.YLabel), yStr = char(ax.YLabel.String); end
            if isprop(ax, 'Title') && ~isempty(ax.Title), tStr = char(ax.Title.String); end
            comb = [xStr ' ' yStr ' ' tStr];
            if ~isempty(regexpi(comb, 'root\s*locus|real\s*axis|imaginary\s*axis'))
                tf = true;
                return;
            end
        catch
        end
    end
    lines = findall(hFig, 'Type', 'line');
    markers = get(lines, 'Marker');
    if ischar(markers), markers = {markers}; end
    if any(strcmp(markers, 'x')) && any(strcmp(markers, 'o'))
        tf = true;
    end
end

function saveFigureForReopen(sourceFigure, outputPath)
    originalVisibility = sourceFigure.Visible;
    sourceFigure.Visible = 'on';
    visibilityCleanup = onCleanup(@() set(sourceFigure, 'Visible', originalVisibility));
    drawnow;
    savefig(sourceFigure, outputPath);
    clear visibilityCleanup;
end