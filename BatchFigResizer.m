function BatchFigResizer()
    appVersion = '1.0.1';
    fig = uifigure('Name', ['Figure Layout Resizer v' appVersion], 'Position', [100 100 920 680]);
    rootGrid = uigridlayout(fig, [1, 1]);
    rootGrid.Padding = [0 0 0 0];
    tabs = uitabgroup(rootGrid);

    resizeTab = uitab(tabs, 'Title', 'Batch Resize');
    mergeTab = uitab(tabs, 'Title', 'Merge Figures');
    regionTab = uitab(tabs, 'Title', 'Figure Region Selector');
    copyTab = uitab(tabs, 'Title', 'Copy Figures');
    updateTab = uitab(tabs, 'Title', 'Updates');

    [mainGrid, leftGrid] = createTabColumns(resizeTab, 360, {'fit', 'fit', 'fit', '1x'});

    presetGrid = createPanelGrid(leftGrid, 'Preset', [2, 2]);
    presetGrid.ColumnWidth = {80, '1x'};
    presetGrid.RowHeight = {24, 38};
    presetGrid.RowSpacing = 6;
    uilabel(presetGrid, 'Text', 'Template:');
    presetDropdown = uidropdown(presetGrid, 'Items', {'Ryu Presentation Full', 'Ryu Presentation Short', 'Presentation', 'Document', 'Custom'}, 'Value', 'Ryu Presentation Full');
    presetDescLabel = uilabel(presetGrid, 'WordWrap', 'on', 'FontColor', [0.35 0.35 0.35], 'FontSize', 11, 'VerticalAlignment', 'top');
    presetDescLabel.Layout.Row = 2;
    presetDescLabel.Layout.Column = [1 2];

    dimGrid = createPanelGrid(leftGrid, 'Canvas & Grid Dimensions', [3, 4]);
    dimGrid.ColumnWidth = {'1x', 55, '1x', 55};
    dimGrid.RowHeight = {24, 24, 20};
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

    styleGrid = createPanelGrid(leftGrid, 'Typography & Export Settings', [7, 4]);
    styleGrid.ColumnWidth = {'1x', 55, '1x', 55};
    styleGrid.RowHeight = {24, 24, 24, 24, 24, 24, 24};
    styleGrid.RowSpacing = 8;
    uilabel(styleGrid, 'Text', 'Font Size (pt):');
    fontSizeEdit = uieditfield(styleGrid, 'numeric', 'Value', 12, 'Limits', [1 Inf]);
    uilabel(styleGrid, 'Text', 'Line Width (pt):');
    lineWidthEdit = uieditfield(styleGrid, 'numeric', 'Value', 1.2, 'Limits', [0.1 Inf]);
    uilabel(styleGrid, 'Text', 'DPI / Res:');
    dpiEdit = uieditfield(styleGrid, 'numeric', 'Value', 500, 'Limits', [100 Inf], 'RoundFractionalValues', 'on');
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

    actionGrid = createPanelGrid(leftGrid, 'Batch Operations', [2, 3]);
    actionGrid.ColumnWidth = {130, 32, '1x'};
    actionGrid.RowHeight = {30, 32};
    actionGrid.RowSpacing = 8;
    actionGrid.ColumnSpacing = 6;
    files = {};
    batchPreviewImages = {};
    batchPreviewNames = {};
    batchPreviewIndex = 1;
    batchPreviewTimer = [];
    uibutton(actionGrid, 'Text', 'Select .fig Files', 'ButtonPushedFcn', @(~,~) selectFiles(false));
    uibutton(actionGrid, 'Text', '+', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) selectFiles(true));
    fileLabel = uilabel(actionGrid, 'Text', 'No files loaded', 'FontColor', [0.4 0.4 0.4]);
    exportBtn = uibutton(actionGrid, 'Text', 'Export Figures', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) exportFigs());
    exportBtn.Layout.Row = 2;
    exportBtn.Layout.Column = [1 3];

    rightColumnGrid = uigridlayout(mainGrid, [2, 1]);
    rightColumnGrid.RowHeight = {'1x', '1x'};
    rightColumnGrid.Padding = [0 0 0 0];
    rightColumnGrid.RowSpacing = 12;
    rightGrid = createPanelGrid(rightColumnGrid, 'Layout Preview', [1, 1]);
    ax = uiaxes(rightGrid);
    xlabel(ax, 'Width (in)');
    ylabel(ax, 'Height (in)');
    disableDefaultInteractivity(ax);
    originalFiguresGrid = createPanelGrid(rightColumnGrid, 'Original Figures', [1, 1]);
    originalAx = createPreviewAxes(originalFiguresGrid, 'Select .fig files to preview the originals');

    [mergeGrid, mLeftGrid] = createTabColumns(mergeTab, 360, {'fit', 'fit', 'fit', '1x'});

    mFileGrid = createPanelGrid(mLeftGrid, 'Select Files to Merge', [2, 3]);
    mFileGrid.ColumnWidth = {130, 32, '1x'};
    mFileGrid.RowHeight = {30, 32};

    mergeFilesList = {};
    mergeOutDir = '';
    uibutton(mFileGrid, 'Text', 'Select .fig Files', 'ButtonPushedFcn', @(~,~) selectMergeFiles(false));
    uibutton(mFileGrid, 'Text', '+', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) selectMergeFiles(true));
    mFileLabel = uilabel(mFileGrid, 'Text', 'No files loaded', 'FontColor', [0.4 0.4 0.4]);

    mSetGrid = createPanelGrid(mLeftGrid, 'Merge Settings', [6, 2]);
    mSetGrid.ColumnWidth = {'1x', 90};
    mSetGrid.RowHeight = {24, 24, 24, 24, 24, 'fit'};

    uilabel(mSetGrid, 'Text', 'Figures per output:');
    mFigsPerOut = uieditfield(mSetGrid, 'numeric', 'Value', 10, 'Limits', [1 Inf], 'RoundFractionalValues', 'on');
    uilabel(mSetGrid, 'Text', 'Target Width (in):');
    mWEdit = uieditfield(mSetGrid, 'numeric', 'Value', 10.0, 'Limits', [0 Inf]);
    uilabel(mSetGrid, 'Text', 'Target Height (in):');
    mHEdit = uieditfield(mSetGrid, 'numeric', 'Value', 4.86, 'Limits', [0 Inf]);
    mRmTitleCheck = uicheckbox(mSetGrid, 'Text', 'Remove Titles from subfigures', 'Value', false);
    mRmTitleCheck.Layout.Column = [1 2];

    uilabel(mSetGrid, 'Text', 'Output Folder:');
    uibutton(mSetGrid, 'Text', 'Browse...', 'ButtonPushedFcn', @(~,~) pickOutputFolder());
    mOutDirLabel = uilabel(mSetGrid, 'Text', 'Default: Source folder', 'FontColor', [0.4 0.4 0.4], 'WordWrap', 'on');
    mOutDirLabel.Layout.Column = [1 2];

    mActGrid = createPanelGrid(mLeftGrid, 'Action', [1, 1]);
    uibutton(mActGrid, 'Text', 'Merge Figures', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) runMerge());

    mRightGrid = createPanelGrid(mergeGrid, 'Selected Files for Merge', [1, 1]);
    mListbox = uilistbox(mRightGrid, 'Items', {});

    regionGrid = createTabColumns(regionTab, 285);
    regionControlGrid = createPanelGrid(regionGrid, 'Subplot Region Selector', [7, 1]);
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
    regionPreviewGrid = createPanelGrid(regionGrid, 'Figure Preview', [1, 1]);
    regionPreviewAx = createPreviewAxes(regionPreviewGrid, 'Load a .fig file to begin');

    [copyGrid, cLeftGrid] = createTabColumns(copyTab, 360, {'fit', 'fit'});

    cFileGrid = createPanelGrid(cLeftGrid, 'Select Source & Destination', [3, 2]);
    cFileGrid.ColumnWidth = {100, '1x'};
    cFileGrid.RowHeight = {30, 30, 30};

    uibutton(cFileGrid, 'Text', 'Select Source', 'ButtonPushedFcn', @(~,~) selectCopyFolder(true));
    cSrcLbl = uilabel(cFileGrid, 'Text', 'None selected', 'WordWrap', 'on');

    uibutton(cFileGrid, 'Text', 'Select Dest', 'ButtonPushedFcn', @(~,~) selectCopyFolder(false));
    cDestLbl = uilabel(cFileGrid, 'Text', 'None selected', 'WordWrap', 'on');

    uilabel(cFileGrid, 'Text', 'Plot Type:');
    cTypeDrop = uidropdown(cFileGrid, 'Items', {'All', 'Line Plot', 'Scatter Plot', 'Bar Plot', 'Surface Plot', 'Bode Plot', 'Root Locus Plot'});

    cActGrid = createPanelGrid(cLeftGrid, 'Action', [1, 1]);
    uibutton(cActGrid, 'Text', 'Copy Files', 'FontWeight', 'bold', 'ButtonPushedFcn', @(~,~) runCopy());

    cRightGrid = createPanelGrid(copyGrid, 'Status Log', [1, 1]);
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
            remoteVer = fetchRemoteVersion();
            if ~isempty(remoteVer)
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
        setStatusLabel(updateStatusLbl, 'Checking GitHub for updates...', [0 0 0]);
        downloadUpdateBtn.Enable = 'off';
        drawnow;
        try
            remoteVer = fetchRemoteVersion();
            if ~isempty(remoteVer)
                if isNewerVersion(appVersion, remoteVer)
                    setStatusLabel(updateStatusLbl, sprintf('A new version is available: %s', remoteVer), [0 0.5 0]);
                    downloadUpdateBtn.Enable = 'on';
                else
                    setStatusLabel(updateStatusLbl, 'You are already running the latest version.', [0 0.5 0]);
                end
            else
                setStatusLabel(updateStatusLbl, 'Could not parse version information from GitHub.', [0.75 0.1 0.1]);
            end
        catch ME
            if contains(ME.message, '404')
                updateStatusLbl.Text = 'Error 404: File not found. Make sure the GitHub repo is public and uses the "main" branch.';
            else
                updateStatusLbl.Text = sprintf('Connection failed: %s', ME.message);
            end
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
                setPresetValues(10.0, 4.86, 2, 12, 500);
                presetDescLabel.Text = 'Full Ryu presentation dimensions split across 2 columns.';
            case 'Ryu Presentation Short'
                setPresetValues(10.0, 4.42, 2, 12, 500);
                presetDescLabel.Text = 'Short Ryu presentation dimensions split across 2 columns.';
            case 'Presentation'
                setPresetValues(9.7, 4.85, 2, 12, 500);
                presetDescLabel.Text = 'Standard slide body dimensions split across 2 columns.';
            case 'Document'
                setPresetValues(6.5, 3.0, 1, 10, 600);
                presetDescLabel.Text = 'Standard single-column report or publication width.';
            case 'Custom'
                presetDescLabel.Text = 'User-defined layout parameters.';
        end
        updateVisualizer();
    end

    function setPresetValues(width, height, columns, fontSize, dpi)
        widthEdit.Value = width;
        heightEdit.Value = height;
        colsEdit.Value = columns;
        rowsEdit.Value = 1;
        fontSizeEdit.Value = fontSize;
        dpiEdit.Value = dpi;
    end

    function handleManualChange()
        presetDropdown.Value = 'Custom';
        applyPreset();
    end

    function [width, height, columns, rows] = readLayoutDimensions()
        width = widthEdit.Value;
        height = heightEdit.Value;
        columns = round(colsEdit.Value);
        rows = round(rowsEdit.Value);
    end

    function updateVisualizer()
        [w, h, c, r] = readLayoutDimensions();
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
        [files, selected] = selectFigureFiles(files, appendMode, fileLabel);
        if selected
            buildBatchPreviews();
        end
    end

    function selectMergeFiles(appendMode)
        [mergeFilesList, selected] = selectFigureFiles(mergeFilesList, appendMode, mFileLabel);
        if selected
            mListbox.Items = mergeFilesList;
        end
    end

    function [selectedFiles, selected] = selectFigureFiles(existingFiles, appendMode, statusLabel)
        [fileNames, pathName] = uigetfile('*.fig', 'Select MATLAB Figures', 'MultiSelect', 'on');
        figure(fig);
        selectedFiles = existingFiles;
        selected = ~isequal(fileNames, 0);
        if ~selected
            return;
        end
        if ischar(fileNames)
            fileNames = {fileNames};
        end
        newFiles = reshape(fullfile(pathName, fileNames), 1, []);
        if appendMode
            newFiles = [existingFiles, newFiles];
        end
        selectedFiles = unique(newFiles, 'stable');
        setStatusLabel(statusLabel, sprintf('%d figure(s) loaded', numel(selectedFiles)), [0 0.5 0]);
    end

    function pickOutputFolder()
        sel = uigetdir('', 'Select Output Folder');
        if ischar(sel)
            mergeOutDir = sel;
            setStatusLabel(mOutDirLabel, sel, [0 0.5 0]);
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
                    axs = findPlotAxes(tmpF);
                    axs = flipud(axs);
                    for aIdx = 1:length(axs)
                        axs(aIdx).Parent = tl;
                        axs(aIdx).Layout.Tile = tileIdx;
                        tileIdx = tileIdx + 1;
                        if rmTitles
                            clearPlotTitles(axs(aIdx));
                        end
                    end
                    close(tmpF);
                end
                setFigurePaperSize(newFig, w, h);
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
            try
                previewFigure = openfig(files{previewIndex}, 'invisible');
                batchPreviewImages{end+1} = renderFigurePreview(previewFigure, 120);
                batchPreviewNames{end+1} = previewName;
            catch ME
                failedPreviews{end+1} = sprintf('%s (%s)', previewName, ME.message);
            end
            if ~isempty(previewFigure) && isvalid(previewFigure)
                delete(previewFigure);
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
        [w, h, c, r] = readLayoutDimensions();
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
                allAxes = findPlotAxes(f);
                if makeTitlesLegend
                    [titleSourceAxes, titleLegendLabels] = collectSubplotTitles(allAxes);
                end
                if length(allAxes) > 1
                    hasSubplots = true;
                end
                if ~keepTitles || makeTitlesLegend
                    clearPlotTitles(allAxes);
                end
                if ~keepTitles
                    clearPlotTitles(findall(f, 'Type', 'tiledlayout'));
                    clearPlotTitles(findall(f, 'Tag', 'wraxes'));
                end
                if forceGrid
                    if strcmp(forceGridMode, 'Force Enable')
                        gridState = 'on';
                    else
                        gridState = 'off';
                    end
                    for axIdx = 1:length(allAxes)
                        try
                            grid(allAxes(axIdx), gridState);
                        catch
                        end
                    end
                end
                trySetGraphicsProperty(allAxes, 'FontSize', fSize);
                trySetGraphicsProperty(findall(f, 'type', 'text'), 'FontSize', fSize);
                trySetGraphicsProperty(findall(f, 'type', 'legend'), 'FontSize', fSize);
                trySetGraphicsProperty(findall(f, 'type', 'colorbar'), 'FontSize', fSize);
                plotLines = findall(f, 'Type', 'line');
                trySetGraphicsProperty(plotLines, 'LineWidth', lWidth);
                trySetGraphicsProperty(plotLines, 'MarkerSize', sqrt(dotSize));
                scatterPlots = findall(f, 'Type', 'scatter');
                if ~isempty(scatterPlots)
                    trySetGraphicsProperty(scatterPlots, 'SizeData', dotSize);
                end
                trySetGraphicsProperty(allAxes, 'LineWidth', max(0.8, lWidth * 0.75));
                try
                    f.WindowStyle = 'normal';
                    f.WindowState = 'normal';
                    f.Units = 'inches';
                    f.Position = [1, 1, indW, indH];
                catch
                end
                setFigurePaperSize(f, indW, indH);
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

                if ~keepTitles && ~makeTitlesLegend
                    allLegends = findall(f, 'Type', 'legend');
                    hasTopOutsideLegend = false;
                    for lgIdx = 1:numel(allLegends)
                        lg = allLegends(lgIdx);
                        if isvalid(lg) && strcmpi(get(lg, 'Visible'), 'on')
                            if isprop(lg, 'Location') && any(strcmp(lg.Location, {'northoutside', 'north'}))
                                hasTopOutsideLegend = true;
                                break;
                            end
                        end
                    end
                    if ~hasTopOutsideLegend
                        maximizeAxesFill(f, allAxes);
                    end
                end

                drawnow;
                outFile = fullfile(folder, sprintf('%s_resized%s', name, ext));
                exportFigure(f, outFile, ext, indW, indH, dpiVal);
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
            uiconfirm(fig, msg, titleText, 'Options', {'Open Folder', 'OK'}, 'DefaultOption', 2, 'CancelOption', 2, 'Icon', iconType, 'CloseFcn', @(~, evt) handleConfirm(evt.SelectedOption, lastExportFolder));
        end
    end

    function maximizeAxesFill(targetFigure, plotAxes)
        if isempty(plotAxes), return; end
        validAxes = plotAxes(arrayfun(@(a) isvalid(a) && (isequal(a.Parent, targetFigure) || isa(a.Parent, 'matlab.ui.Figure')), plotAxes));
        if isempty(validAxes), return; end

        set(validAxes, 'Units', 'normalized');
        for aIdx = 1:numel(validAxes)
            if isprop(validAxes(aIdx), 'PositionConstraint')
                validAxes(aIdx).PositionConstraint = 'innerposition';
            elseif isprop(validAxes(aIdx), 'ActivePositionProperty')
                validAxes(aIdx).ActivePositionProperty = 'position';
            end
        end
        drawnow;

        edgePad = 0.015;
        targetLeft = edgePad;
        targetRight = 1 - edgePad;
        targetBottom = edgePad;
        targetTop = 1 - edgePad;

        legends = findall(targetFigure, 'Type', 'legend');
        for lgIdx = 1:numel(legends)
            lg = legends(lgIdx);
            if ~isvalid(lg) || strcmpi(get(lg, 'Visible'), 'off'), continue; end
            try
                lgUnits = lg.Units;
                lg.Units = 'normalized';
                lgPos = lg.Position;
                lg.Units = lgUnits;
                if lgPos(2) + lgPos(4) >= 0.85 && lgPos(4) < 0.5
                    targetTop = min(targetTop, max(0.2, lgPos(2) - edgePad));
                elseif lgPos(2) <= 0.15 && lgPos(4) < 0.5
                    targetBottom = max(targetBottom, min(0.8, lgPos(2) + lgPos(4) + edgePad));
                elseif lgPos(1) >= 0.80 && lgPos(3) < 0.5
                    targetRight = min(targetRight, max(0.2, lgPos(1) - edgePad));
                elseif lgPos(1) <= 0.20 && lgPos(3) < 0.5
                    targetLeft = max(targetLeft, min(0.8, lgPos(1) + lgPos(3) + edgePad));
                end
            catch
            end
        end

        nAx = numel(validAxes);
        tightInsets = zeros(nAx, 4);
        envBounds = zeros(nAx, 4);

        for k = 1:nAx
            ax = validAxes(k);
            pos = ax.Position;
            try
                ti = ax.TightInset;
            catch
                ti = [0.05 0.05 0.02 0.02];
            end
            if isempty(ti) || numel(ti) < 4 || any(~isfinite(ti))
                ti = [0.05 0.05 0.02 0.02];
            end
            tightInsets(k, :) = ti;
            envBounds(k, :) = [pos(1) - ti(1), pos(2) - ti(2), pos(1) + pos(3) + ti(3), pos(2) + pos(4) + ti(4)];
        end

        envLeft = min(envBounds(:, 1));
        envBottom = min(envBounds(:, 2));
        envRight = max(envBounds(:, 3));
        envTop = max(envBounds(:, 4));

        envW = envRight - envLeft;
        envH = envTop - envBottom;
        targetW = targetRight - targetLeft;
        targetH = targetTop - targetBottom;

        if envW <= 0 || envH <= 0 || targetW <= 0 || targetH <= 0
            return;
        end

        scaleX = targetW / envW;
        scaleY = targetH / envH;

        for k = 1:nAx
            ax = validAxes(k);
            ti = tightInsets(k, :);
            bLeft = envBounds(k, 1);
            bBottom = envBounds(k, 2);
            bRight = envBounds(k, 3);
            bTop = envBounds(k, 4);

            newEnvLeft = targetLeft + (bLeft - envLeft) * scaleX;
            newEnvRight = targetLeft + (bRight - envLeft) * scaleX;
            newEnvBottom = targetBottom + (bBottom - envBottom) * scaleY;
            newEnvTop = targetBottom + (bTop - envBottom) * scaleY;

            newX = newEnvLeft + ti(1);
            newY = newEnvBottom + ti(2);
            newW = max(0.05, newEnvRight - ti(3) - newX);
            newH = max(0.05, newEnvTop - ti(4) - newY);

            try
                ax.Position = [newX, newY, newW, newH];
            catch
            end
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
            titleText = graphicsTextToChar(rawTitle);
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
                    property = figureContentPositionProperty(child);
                    if strcmp(property, 'OuterPosition') && isprop(child, 'PositionConstraint')
                        child.PositionConstraint = 'outerposition';
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
                        property = figureContentPositionProperty(child);
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
        setStatusLabel(regionStatusLabel, 'Loading figure preview...', [0.15 0.4 0.7]);
        drawnow;
        try
            closeRegionSource();
            regionSourcePath = fullfile(pathName, fileName);
            regionSourceFig = openfig(regionSourcePath, 'invisible');
            regionSourceAxes = findPlotAxes(regionSourceFig);
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
            regionPreviewImage = renderFigurePreview(regionSourceFig, 200);
            clearPreviewSelection();
            cla(regionPreviewAx);
            previewHeight = size(regionPreviewImage, 1);
            previewWidth = size(regionPreviewImage, 2);
            previewImageHandle = image(regionPreviewAx, 'CData', regionPreviewImage, 'XData', [1 previewWidth], 'YData', [1 previewHeight]);
            hold(regionPreviewAx, 'on');
            previewImageHandle.ButtonDownFcn = @(~,~) beginPreviewDrag();
            previewImageHandle.PickableParts = 'all';
            regionPreviewAx.ButtonDownFcn = @(~,~) beginPreviewDrag();
            regionPreviewAx.XLim = [0.5 previewWidth + 0.5];
            regionPreviewAx.YLim = [0.5 previewHeight + 0.5];
            regionPreviewAx.YDir = 'reverse';
            regionPreviewAx.DataAspectRatio = [1 1 1];
            regionPreviewAx.XTick = [];
            regionPreviewAx.YTick = [];
            title(regionPreviewAx, 'Drag horizontally over any subplot');
            regionClearBtn.Enable = 'off';
            setStatusLabel(regionStatusLabel, sprintf('Loaded %s', fileName), [0 0.5 0]);
        catch ME
            closeRegionSource();
            cla(regionPreviewAx);
            title(regionPreviewAx, 'Load a .fig file to begin');
            setStatusLabel(regionStatusLabel, 'Could not load figure.', [0.75 0.1 0.1]);
            uialert(fig, ME.message, 'Figure Load Error');
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
            setStatusLabel(regionStatusLabel, 'Start the drag inside a subplot plotting area.', [0.65 0.4 0]);
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
                startPreviewDragCallbacks();
                setStatusLabel(regionStatusLabel, 'Drag the selected edge to resize the region.', [0.15 0.4 0.7]);
                return;
            end
        end
        clearPreviewSelection();
        regionSelectedAxesIndex = axesIndex;
        regionDragMode = 'new-selection';
        axesRectangle = previewAxesRectangle(axesIndex);
        regionDragStartX = min(max(point(1), axesRectangle(1)), axesRectangle(1) + axesRectangle(3));
        startPreviewDragCallbacks();
        updatePreviewDrag();
    end

    function startPreviewDragCallbacks()
        fig.WindowButtonMotionFcn = @(~,~) updatePreviewDrag();
        fig.WindowButtonUpFcn = @(~,~) finishPreviewDrag();
    end

    function resetPreviewDrag()
        fig.WindowButtonMotionFcn = [];
        fig.WindowButtonUpFcn = [];
        regionDragStartX = [];
        regionDragMode = '';
        regionDragInitialLimits = [];
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
        setStatusLabel(regionStatusLabel, sprintf('Selected x-range: %.5g to %.5g', regionSelectedXLimits(1), regionSelectedXLimits(2)), [0.15 0.4 0.7]);
    end

    function finishPreviewDrag()
        resetPreviewDrag();
        if isempty(regionSelectedXLimits) || regionSelectedXLimits(2) <= regionSelectedXLimits(1)
            clearPreviewSelection();
            return;
        end
        regionClearBtn.Enable = 'on';
        regionExportBtn.Enable = 'on';
        setStatusLabel(regionStatusLabel, sprintf('Selected x-range: %.5g to %.5g. Drag either red edge to adjust.', regionSelectedXLimits(1), regionSelectedXLimits(2)), [0.15 0.4 0.7]);
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
        resetPreviewDrag();
        deleteSelectionRectangles();
        regionSelectedAxesIndex = [];
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
            setStatusLabel(regionStatusLabel, sprintf('Saved %s', outputName), [0 0.5 0]);
        catch ME
            setStatusLabel(regionStatusLabel, 'Region export failed.', [0.75 0.1 0.1]);
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
    end

    function selectCopyFolder(isSource)
        folder = uigetdir();
        if ischar(folder)
            if isSource
                cSrcPath = folder;
                cSrcLbl.Text = folder;
                label = 'Source';
            else
                cDestPath = folder;
                cDestLbl.Text = folder;
                label = 'Dest';
            end
            cStatusLog.Items = [cStatusLog.Items, {sprintf('%s set: %s', label, folder)}];
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
                    shouldCopy = figureMatchesPlotType(hFig, targetType);
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
    setFigurePaperSize(targetFig, w, h);
    drawnow;
    switch lower(ext)
        case {'.tif', '.tiff'}
            device = '-dtiff';
        case {'.jpeg', '.jpg'}
            device = '-djpeg';
        case '.pdf'
            device = '-dpdf';
        case '.eps'
            device = '-depsc';
        case '.svg'
            device = '-dsvg';
        otherwise
            device = '-dpng';
    end
    if isVectorFormat(ext)
        print(targetFig, outFile, device, '-painters');
    else
        print(targetFig, outFile, device, sprintf('-r%d', round(dpiVal)));
    end
end

function tf = isBodePlotFigure(hFig)
    tf = false;
    if isempty(hFig) || ~isvalid(hFig), return; end
    if hasPlotMetadata(hFig, 'bode', {'BodePlot', 'WaveformPlot'})
        tf = true;
        return;
    end
    axs = findall(hFig, 'Type', 'axes');
    hasMag = false;
    hasPhase = false;
    for k = 1:numel(axs)
        ax = axs(k);
        try
            labels = axesLabelText(ax, {'YLabel', 'Title'});
            if ~isempty(regexpi(labels, 'magnitude|mag\s*\(db\)')), hasMag = true; end
            if ~isempty(regexpi(labels, 'phase|phase\s*\(deg\)')), hasPhase = true; end
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
    if hasPlotMetadata(hFig, 'rlocus|root\s*locus', {'RootLocusPlot', 'RLocusPlot'})
        tf = true;
        return;
    end
    axs = findall(hFig, 'Type', 'axes');
    for k = 1:numel(axs)
        ax = axs(k);
        try
            comb = axesLabelText(ax, {'XLabel', 'YLabel', 'Title'});
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

function [grid, leftGrid] = createTabColumns(parent, leftWidth, leftRowHeights)
    grid = uigridlayout(parent, [1, 2]);
    grid.ColumnWidth = {leftWidth, '1x'};
    grid.Padding = [15 15 15 15];
    grid.ColumnSpacing = 15;
    if nargout > 1
        leftGrid = uigridlayout(grid, [numel(leftRowHeights), 1]);
        leftGrid.RowHeight = leftRowHeights;
        leftGrid.Padding = [0 0 0 0];
        leftGrid.RowSpacing = 12;
    end
end

function previewAxes = createPreviewAxes(parent, caption)
    previewAxes = uiaxes(parent);
    previewAxes.XTick = [];
    previewAxes.YTick = [];
    previewAxes.Box = 'on';
    previewAxes.Color = [0.96 0.96 0.96];
    previewAxes.Toolbar.Visible = 'off';
    disableDefaultInteractivity(previewAxes);
    title(previewAxes, caption);
end

function remoteVersion = fetchRemoteVersion()
    opts = weboptions('Timeout', 5, 'CertificateFilename', '');
    rawURL = 'https://raw.githubusercontent.com/Alexr360/Batch-Fig-Resizer-MATLAB-Script/main/BatchFigResizer.m';
    remoteCode = webread(rawURL, opts);
    tokens = regexp(remoteCode, 'appVersion\s*=\s*''([^'']+)''', 'tokens', 'once');
    remoteVersion = '';
    if ~isempty(tokens)
        remoteVersion = tokens{1};
    end
end

function plotAxes = findPlotAxes(targetFigure)
    plotAxes = findall(targetFigure, 'Type', 'axes');
    excluded = arrayfun(@(a) isa(a, 'matlab.graphics.illustration.Legend') || ...
        isa(a, 'matlab.graphics.illustration.ColorBar') || strcmpi(a.Tag, 'wraxes'), plotAxes);
    plotAxes = plotAxes(~excluded);
end

function setFigurePaperSize(targetFigure, width, height)
    targetFigure.PaperUnits = 'inches';
    targetFigure.PaperSize = [width height];
    targetFigure.PaperPositionMode = 'manual';
    targetFigure.PaperPosition = [0 0 width height];
end

function clearPlotTitles(targets)
    for index = 1:numel(targets)
        try
            title(targets(index), '');
        catch
        end
    end
end

function trySetGraphicsProperty(targets, property, value)
    try
        set(targets, property, value);
    catch
    end
end

function previewImage = renderFigurePreview(targetFigure, resolution)
    previewFile = [tempname, '.png'];
    fileCleanup = onCleanup(@() deleteFileIfPresent(previewFile));
    targetFigure.PaperPositionMode = 'auto';
    drawnow;
    print(targetFigure, previewFile, '-dpng', sprintf('-r%d', resolution));
    [previewImage, colorMap] = imread(previewFile);
    if ~isempty(colorMap)
        previewImage = uint8(round(ind2rgb(previewImage, colorMap) * 255));
    end
end

function deleteFileIfPresent(path)
    if isfile(path)
        delete(path);
    end
end

function exportFigure(targetFigure, outputPath, extension, width, height, resolution)
    if strcmp(extension, '.fig')
        saveFigureForReopen(targetFigure, outputPath);
        return;
    end
    try
        if isVectorFormat(extension)
            exportgraphics(targetFigure, outputPath, 'ContentType', 'vector', ...
                'Units', 'inches', 'Width', width, 'Height', height, 'Padding', 'figure');
        else
            exportgraphics(targetFigure, outputPath, 'Resolution', resolution, ...
                'Units', 'inches', 'Width', width, 'Height', height, 'Padding', 'figure');
        end
    catch
        exportFigureViaPrint(targetFigure, outputPath, extension, width, height, resolution);
    end
end

function tf = isVectorFormat(extension)
    tf = any(strcmpi(extension, {'.pdf', '.eps', '.svg'}));
end

function property = figureContentPositionProperty(child)
    if isprop(child, 'OuterPosition') && ~isa(child, 'matlab.graphics.illustration.Legend')
        property = 'OuterPosition';
    else
        property = 'Position';
    end
end

function tf = figureMatchesPlotType(targetFigure, plotType)
    switch plotType
        case {'Line Plot', 'Scatter Plot', 'Bar Plot', 'Surface Plot'}
            objectTypes = {'line', 'scatter', 'bar', 'surface'};
            plotTypes = {'Line Plot', 'Scatter Plot', 'Bar Plot', 'Surface Plot'};
            objectType = objectTypes{strcmp(plotType, plotTypes)};
            tf = ~isempty(findall(targetFigure, 'Type', objectType));
        case 'Bode Plot'
            tf = isBodePlotFigure(targetFigure);
        case 'Root Locus Plot'
            tf = isRootLocusPlotFigure(targetFigure);
        otherwise
            tf = false;
    end
end

function tf = hasPlotMetadata(targetFigure, namePattern, appDataFields)
    nameTag = [get(targetFigure, 'Name') ' ' get(targetFigure, 'Tag')];
    tf = ~isempty(regexpi(nameTag, namePattern, 'once')) || ...
        any(isfield(getappdata(targetFigure), appDataFields));
end

function text = axesLabelText(targetAxes, properties)
    labels = cell(1, numel(properties));
    for index = 1:numel(properties)
        property = properties{index};
        labels{index} = '';
        if isprop(targetAxes, property) && ~isempty(targetAxes.(property))
            labels{index} = graphicsTextToChar(targetAxes.(property).String);
        end
    end
    text = strjoin(labels, ' ');
end

function text = graphicsTextToChar(rawText)
    if iscell(rawText)
        text = strjoin(cellfun(@char, rawText, 'UniformOutput', false), ' ');
    elseif isstring(rawText)
        text = char(strjoin(rawText, ' '));
    else
        text = char(rawText);
    end
end

function grid = createPanelGrid(parent, caption, gridSize)
    panel = uipanel(parent, 'Title', caption);
    grid = uigridlayout(panel, gridSize);
    grid.Padding = [10 10 10 10];
end

function setStatusLabel(label, message, color)
    label.Text = message;
    label.FontColor = color;
end
