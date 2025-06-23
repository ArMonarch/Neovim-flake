{
  description = "Ar Monarch's Neovim Config using nixcats on NixOS";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    # nixcats added here
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = { self, nixpkgs, nixCats, ... }@inputs:
    let

      inherit (nixCats) utils;
      # path the the store path to be loaded as Neovim config directory
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      # the following extra_pkg_config contains any values
      # which you want to pass to the config set of nixpkgs
      # import nixpkgs { config = extra_pkg_config; inherit system; }
      # will not apply to module imports
      # as that will have your system values
      extra_pkg_config = {
        # allowUnfree = true;
      };

      # management of the system variable is one of the harder parts of using flakes.

      # so I have done it here in an interesting way to keep it out of the way.
      # It gets resolved within the builder itself, and then passed to your
      # categoryDefinitions and packageDefinitions.

      # this allows you to use ${pkgs.system} whenever you want in those sections
      # without fear.

      dependencyOverlays = # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )
        ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions =
        { pkgs, settings, categories, extra, name, mkPlugin, ... } @ packageDef: {
          # to define and use a new category, simply add a new list to a set here, 
          # and later, you will include categoryname = true; in the set you
          # provide when you build the package using this builder function.
          # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = with pkgs; { general = [ ripgrep fd lazygit wl-clipboard universal-ctags ]; };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = with pkgs.vimPlugins; {
            gitPlugins = [ ];
            general = [ 
              # NOTE: Themes to set themes check plugins.lua
              tokyonight-nvim catppuccin-nvim gruvbox-material
              todo-comments-nvim
              which-key-nvim
              gitsigns-nvim

              (nvim-treesitter.withPlugins(
                plugins: with plugins; [
                  bash
                  c
                  corn
                  cpp
                  css
                  csv
                  diff
                  dockerfile
                  html
                  javascript
                  jsdoc
                  json
                  jsonc
                  latex
                  lua
                  luadoc
                  luap
                  markdown
                  markdown-inline
                  nginx
                  nix
                  printf
                  python
                  query
                  regex
                  rust
                  sql
                  toml
                  tsx
                  typescript
                  vim
                  vimdoc
                  xml
                  yaml
                  zig
                ]
              ))

              lualine-nvim

              snacks-nvim

              smear-cursor-nvim

              # NOTE: Needed to correctly display icons,
              # many plugins depend on these for proper icons rendering, e.g. which-key
              mini-icons
              
              mini-pairs
            ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          # NOTE: this template is using lazy.nvim so, which list you put them in is irrelevant.
          # startupPlugins or optionalPlugins, it doesnt matter, lazy.nvim does the loading.
          # I just put them all in startupPlugins. I could have put them all in here instead.
          optionalPlugins = with pkgs.vimPlugins; {
            gitPlugins = [ ];
            general = [  ];
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs;
              [
                # libgit2
              ];
          };

          # environmentVariables:
          # this section is for environmentVariables that should be available
          # at RUN TIME for plugins. Will be available to path within neovim terminal
          environmentVariables = {
            test = {
              CATTESTVAR = "It worked!";
              ECHO = "echo";
            };
          };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = {
            test = [ ''--set CATTESTVAR2 "It worked again!"'' ];
          };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages
          # do not forget to set `hosts.python3.enable` in package settings

          # get the path to this python environment
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          python3.libraries = { test = (_: [ ]); };
          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = { test = [ (_: [ ]) ]; };

        };

      # lists of the functions you would have passed to
      # python.withPackages or lua.withPackages
      # do not forget to set `hosts.python3.enable` in package settings

      # get the path to this python environment
      # in your lua config via
      # vim.g.python3_host_prog
      # or run from nvim terminal via :!<packagename>-python3
      python3.libraries = { test = (_: [ ]); };
      # populates $LUA_PATH and $LUA_CPATH
      extraLuaPackages = { test = [ (_: [ ]) ]; };

      # And then build a package with specific categories from above here:
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # These are the names of your packages
        # you can include as many as you wish.
        nvim = { pkgs, name, ... }: {
          # they contain a settings set defined above
          # see :help nixCats.flake.output.settings
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            #IMPORTANT:
            # your alias may not conflict with your other packages.
            aliases = [ "vim" ];
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            hosts.python3.enable = true;
            hosts.node.enable = true;
          };

          # and a set of categories that you want
          # (and other information to pass to lua)
          categories = {
            general = true;
            gitPlugins = true;
            customPlugins = true;
            test = true;

            # [ "tokyonight", "tokyonight-day":light, "tokyonight-storm", "tokyonight-moon", "tokyonight-night" ]
            # [ "catppuccin", "catppuccin-latte":light, "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha", ]
            # [ "gruvbox-material" ]
            colorscheme = "gruvbox-material";

            # this kickstart extra didnt require any extra plugins
            # so it doesnt have a category above.
            # but we can still send the info from nix to lua that we want it!
            nvim-gitsigns = true;

            # we can pass whatever we want actually.
            have_nerd_font = true;

          };
        };
      };

      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "nvim";

      # see :help nixCats.flake.outputs.exports
    in forEachSystem (system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        # this is just for using utils such as pkgs.mkShell
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
        pkgs = import nixpkgs { inherit system; };

      in { 
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will make a package out of each of the packageDefinitions defined above
        # and set the default package to the one passed in here.
        packages = utils.mkAllWithDefault defaultPackage;

        # choose your package for devShell
        # and add whatever else you want in it.
        devShell = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputFrom = [ ];
            shellHook = '''';
          };
        };
        
      });
}
