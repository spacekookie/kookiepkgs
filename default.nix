/* The top-level package collection of kookiepkgs.
 * Unlike the real `top-level.nix` it's simply
 * sorted alphabetically
 */

{ system ? builtins.currentSystem }:

let
   pkgs = import <nixpkgs> { inherit system; };

   callPackage = pkgs.lib.callPackageWith (pkgs // self);

   self = {
      # forge = callPackage ./pkgs/forge { };
      spacekookie-de = callPackage ./pkgs/spacekookie-de { };
      pleroma = callPackage ./pkgs/pleroma { };
   };
   in self

