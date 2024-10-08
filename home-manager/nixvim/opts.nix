{
  programs.nixvim.opts = {
    timeoutlen = 3000;
    updatetime = 300;

    # Line numbers
    number = true;
    relativenumber = true;

    # Tab spaces
    expandtab = true;
    tabstop = 2;
    softtabstop = 2;
    showtabline = 2;
    shiftwidth = 2;

    # Autoindenting
    smartindent = true;
    breakindent = true;

    # Text wrap
    wrap = true;

    # Access system clipboard
    clipboard = "unnamedplus";

    # Backups
    swapfile = false;
    backup = false;
    writebackup = true;
    undofile = true;

    # Cursor
    cursorline = true; # Highlighting on cursor line
    scrolloff =  8; # Lines above/below cursor

    # Searching
    hlsearch = true;
    incsearch = true;
    ignorecase = true;
    smartcase = true;
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";

    # Splitting
    splitbelow = true;
    splitright = true;

    # Command line
    showmode = false;
    cmdheight = 1;

    # Encoding
    encoding = "utf-8";
    fileencoding = "utf-8";

    # Folding
    foldenable = true;
    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;

    # Spell checking
    spell = true;
    spelllang = [ "en" "cjk" ];

    # Misc
    completeopt = [ "menuone" "noselect" "noinsert" ];
    termguicolors = true;
    hidden = true;
    conceallevel = 0;
    signcolumn = "yes";
    mouse = "a";
  };
}
